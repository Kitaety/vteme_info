import 'dart:async';
import 'package:flutter/material.dart';
import 'package:relation/relation.dart' as r;
import 'package:test_app/common/error_handler.dart';
import 'package:test_app/data/news_article.dart';
import 'package:test_app/utils/widget_model.dart';

class NewsArticleBlockWm extends WidgetModel {
  /// Emit events about favorites storage change
  final favoritesChangedState = r.StreamedState<bool>();

  /// Tap on favorite button
  final favoriteTapAction = r.Action<bool>();

  /// Is repository favorite indicator
  final isFavoriteState = r.StreamedState<bool>(false);

  /// Repository data
  final repoState = r.StreamedState<NewsArticle>();

  NewsArticleBlockWm(
    NewsArticle repo,
  ): super(errorHandler: NewsArticleBlockErrorHandler()) {
    subscribe(favoriteTapAction.stream,
        (_) => _handleFavoriteTap(!repoState.value.isFavorite));
    _init(repo);
  }

  void _init(NewsArticle article) {
    repoState.accept(article);
    isFavoriteState.accept(article.isFavorite);
  }

  Future<void> _handleFavoriteTap(bool isFavorite) async {
    final NewsArticle article = repoState.value;
    print(isFavorite.toString());
    article.isFavorite = isFavorite;
    isFavoriteState.accept(isFavorite);

    try {} on Exception catch (e) {
      handleError(e);
    }
  }
}

class NewsArticleBlockErrorHandler extends ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint("[News Article Block]: ${e.toString()}");
  }
}
