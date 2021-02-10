import 'package:flutter/material.dart';
import 'package:relation/relation.dart' as r;
import 'package:test_app/common/error_handler.dart';
import 'package:test_app/common/widget_model.dart';
import 'package:test_app/utils/navigation_service.dart';
import 'package:test_app/utils/web_services.dart';
import 'package:test_app/data/news_article.dart';

class NewsPageWM extends WidgetModel {
  /// Represent news article
  final articlesState = r.EntityStreamedState<List<NewsArticle>>()..loading();

  final tapAction = r.Action();

  NewsPageWM() : super(errorHandler: NewsPageErrorHandle()) {
    subscribe(tapAction.stream, (article) => _onTapNewsArticleWidget(article));
    _loadNewsArticle();
  }

  Future<void> _loadNewsArticle({bool refresh = false}) async {
    articlesState.loading();
    try {
      final List<NewsArticle> articles = refresh
          ? await WebServices.instance.getNewsArticles()
          : await WebServices.articlesList;
      articlesState.content(articles);
    } on Exception catch (e) {
      articlesState.error();
      handleError(e);
    }
  }

  Future<void> refresNewsArticle() async {
    return _loadNewsArticle(refresh: true);
  }

  Future<void> _onTapNewsArticleWidget(NewsArticle article) async {
    NavigationService.instance.navigateTo("screen_article", arguments: article);
  }
}

class NewsPageErrorHandle extends ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint('[News Page]:${e.toString()}');
  }
}
