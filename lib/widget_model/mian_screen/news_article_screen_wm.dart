import 'package:flutter/foundation.dart';
import 'package:relation/relation.dart';
import 'package:test_app/common/error_handler.dart';
import 'package:test_app/common/widget_model.dart';
import 'package:test_app/data/news_article.dart';
import 'package:relation/relation.dart' as r;
import 'package:test_app/utils/navigation_service.dart';

class NewsArticleScreenWM extends WidgetModel {
  /// Represent news article
  final article;
  final articlesState = new StreamedState<NewsArticle>();

  final tapToBack = new r.Action();

  NewsArticleScreenWM({
    @required this.article,
  }) : super(errorHandler: NewsArticleScreenErrorHandler()) {
    articlesState.accept(article);

    subscribe(tapToBack.stream, (_) => _onTapToBack());
  }

  void _onTapToBack() {
    NavigationService.instance.goback();
  }
}

class NewsArticleScreenErrorHandler extends ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint('[News Article Page]:${e.toString()}');
  }
}
