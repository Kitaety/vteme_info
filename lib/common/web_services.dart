import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:test_app/data/news_article.dart';

class WebServices{
  final String _urlNews = "https://newsapi.org/v2/top-headlines?country=ru&apiKey=9a0b6fe30abc41c19f15e44e3f924fce";

  var dio = new Dio();

  /// Get Github-users
  Future<List<NewsArticle>> getNewsArticles() async {
    final response = await dio.get(_urlNews);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result['articles'];
      return list.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception("Failled to get top news");
    }

  }
}