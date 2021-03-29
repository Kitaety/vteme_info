import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:test_app/data/news_article.dart';

class NewsArticleScreen extends StatefulWidget {
  const NewsArticleScreen({Key key}) : super(key: key);
  @override
  _NewsArticlePageState createState() => _NewsArticlePageState();
}

class _NewsArticlePageState extends State<NewsArticleScreen> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  @override
  void dispose() {
    super.dispose();
    flutterWebViewPlugin.close();
    flutterWebViewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NewsArticle article =
        ModalRoute.of(context).settings.arguments as NewsArticle;
    return WebviewScaffold(
      url: article.url,
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      appBar: new AppBar(
        title: new Text(article.title),
      ),
    );
  }
}
