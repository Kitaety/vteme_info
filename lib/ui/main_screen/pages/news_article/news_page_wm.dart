import 'package:flutter/material.dart';
import 'package:relation/relation.dart' as r;
import 'package:test_app/common/error_handler.dart';
import 'package:test_app/common/widget_model.dart';
import 'package:test_app/utils/web_services.dart';
import 'package:test_app/data/news_article.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/webfeed.dart';
import 'package:intl/intl.dart';

class NewsPageWM extends WidgetModel {
  /// Represent news article
  final articlesState = r.EntityStreamedState<List<NewsArticle>>()..loading();
  NewsPageWM() : super(errorHandler: NewsPageErrorHandle()) {
    _loadNewsArticle();
  }

  Future<void> _loadNewsArticle({bool refresh = false}) async {
    articlesState.loading();
    try {
      final RssFeed feed = refresh
          ? await WebServices.instance.getNewsArticles()
          : await WebServices.articlesList;
      List<NewsArticle> articles = [];
      for (RssItem item in feed.items) {
        articles.add(NewsArticle(
            title: item.title,
            category: item.categories[0].value,
            publishedAt: "TUT.BY",
            description: item.description.substring(
                item.description.indexOf(">") + 1,
                item.description.indexOf("<br")),
            urlToImage: item.enclosure.url,
            url: item.link,
            date: DateFormat('dd-MM-yyyy kk:mm').format(item.pubDate)));
      }
      articlesState.content(articles);
    } on Exception catch (e) {
      articlesState.error();
      handleError(e);
    }
  }

  Future<void> refresNewsArticle() async {
    return _loadNewsArticle(refresh: true);
  }
}

class NewsPageErrorHandle extends ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint('[News Page]:${e.toString()}');
  }
}
