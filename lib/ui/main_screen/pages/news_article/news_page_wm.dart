import 'package:flutter/material.dart';
import 'package:relation/relation.dart' as r;
import 'package:test_app/common/error_handler.dart';
import 'package:test_app/common/widget_model.dart';
import 'package:test_app/utils/web_services.dart';
import 'package:test_app/data/news_article.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/webfeed.dart';
import 'package:intl/intl.dart';
import 'package:html/parser.dart';

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
        var document = parse(item.description);
        String desc = "";
        for (var i in document.children[0].children[1].children) {
          if (i.text.replaceAll('\n', '').trim().isNotEmpty) {
            desc = i.text.replaceAll('\n', '');
            break;
          }
        }
        articles.add(
          NewsArticle(
              title: item.title,
              description: desc,
              category: "",
              publishedAt: "",
              date: DateFormat('dd-MM-yyyy kk:mm').format(item.pubDate),
              url: item.link,
              urlToImage: item.enclosure != null ? item.enclosure.url : ""),
        );
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
