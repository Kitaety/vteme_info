import 'package:dio/dio.dart';
import 'package:test_app/data/currency.dart';
import 'package:test_app/data/news_article.dart';
import 'package:webfeed/webfeed.dart';

class WebServices {
  static WebServices instance = WebServices();
  static get articlesList => instance.articles.length == 0
      ? instance.getNewsArticles()
      : instance.articles;
  static get currencyList => instance.currency.length == 0
      ? instance.getCurrency()
      : instance.currency;
  List<NewsArticle> articles = [];
  List<Currency> currency = [];

  //final String _urlNews = "https://news.tut.by/rss/all.rss";
  final String _urlNews = "http://pinsk.gov.by/about/info/news/rss/";
  final String _urlCurrency =
      "https://www.nbrb.by/api/exrates/rates?periodicity=";
  var dio = new Dio();

  Future<RssFeed> getNewsArticles() async {
    print("[WebService] Load Articles");
    final response = await dio.get(_urlNews);
    if (response.statusCode == 200) {
      return RssFeed.parse(response.data);
    } else {
      throw Exception("Failled to get top news");
    }
  }

  Future<List<Currency>> getCurrency() async {
    print("[WebService] Load Currency");
    final response = await dio.get(_urlCurrency + "0");
    if (response.statusCode == 200) {
      currency = [
        Currency.byn,
      ];
      (response.data as List).forEach((element) {
        if (element['Cur_Abbreviation'] != 'XDR') {
          currency.add(Currency.fromJson(element));
        }
      });
      return currency;
    } else {
      throw Exception("Failled to get currency");
    }
  }
}
