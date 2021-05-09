import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:vteme_info/data/company.dart';
import 'package:vteme_info/data/currency.dart';
import 'package:vteme_info/data/news_article.dart';
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

  final String _urlNews = "http://pinsk.gov.by/about/info/news/rss/";
  final String _urlCurrency =
      "https://www.nbrb.by/api/exrates/rates?periodicity=";

  final String _urlCompany = "https://anika-cs.by/appnewvtemeinfo/api/company/";

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

  Future<List<Company>> getAllCompany() async {
    print("[WebService] Load Company");
    final response = await dio.get(_urlCompany + "read.php");
    if (response.statusCode == 200) {
      List<Company> company = [];
      (response.data as List).forEach((element) {
        company.add(Company.fromJson(element));
      });
      return company;
    } else {
      throw Exception("Failled to get currency");
    }
  }

  Future<List<Company>> getCompanyByCategoryId(int id) async {
    print("[WebService] Load Company");
    final response = await dio
        .get(_urlCompany + "read_by_category_id.php?id=" + id.toString());
    if (response.statusCode == 200) {
      List<Company> company = [];
      (response.data as List).forEach((element) {
        company.add(Company.fromJson(element));
      });
      return company;
    } else {
      throw Exception("Failled to get currency");
    }
  }

  Future<List<Company>> getCompanyByGroup(CompanyGroup group) async {
    print("[WebService] Load Company");
    final response = await dio.get(
        _urlCompany + "read_group.php?group=" + (group.index + 1).toString());
    if (response.statusCode == 200) {
      List<Company> company = [];
      (response.data as List).forEach((element) {
        company.add(Company.fromJson(element));
      });
      return company;
    } else {
      throw Exception("Failled to get currency");
    }
  }

  Future<Company> getCompanyById(int id) async {
    print("[WebService] Load Company");
    final response =
        await dio.get(_urlCompany + "read_one.php?id=" + id.toString());
    if (response.statusCode == 200) {
      return Company.fromJson(response.data);
    } else {
      throw Exception("Failled to get currency");
    }
  }
}
