import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:vteme_info/data/news_article.dart';

class NewsArticleScreen extends StatefulWidget {
  const NewsArticleScreen({Key key}) : super(key: key);
  @override
  _NewsArticlePageState createState() => _NewsArticlePageState();
}

class _NewsArticlePageState extends State<NewsArticleScreen> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  @override
  void dispose() {
    flutterWebViewPlugin.close();
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NewsArticle article =
        ModalRoute.of(context).settings.arguments as NewsArticle;
    return WebviewScaffold(
      key: widget.key,
      url: article.url,
      appCacheEnabled: true,
      hidden: false,
      appBar: new AppBar(
        title: new Text(article.title),
      ),
    );
  }
}
