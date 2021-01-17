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
  // final childrenState = r.EntityStateBuilder<List<WidgetModel>>();
  /// Reload news article
  final refreshAction = r.Action();

  final tapAction = r.Action();

  NewsPageWM() : super(errorHandler: NewsPageErrorHandle()) {
    subscribe(tapAction.stream, (article) => _onTapNewsArticleWidget(article));
    subscribe(refreshAction.stream, (_) => _loadNewsArticle());
    _loadNewsArticle();
  }

  Future<void> _loadNewsArticle() async {
    articlesState.loading();
    try {
      final List<NewsArticle> articles = await WebServices().getNewsArticles();
      articlesState.content(articles);
    } on Exception catch (e) {
      articlesState.error();
      handleError(e);
    }
  }

  Future<void> _onTapNewsArticleWidget(NewsArticle article) async {
    NavigationService.instance.navigateTo("article_page", arguments: article);
  }
}

class NewsPageErrorHandle extends ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint('[News Page]:${e.toString()}');
  }
}
