import 'package:flutter/material.dart';
import 'package:relation/relation.dart';
import 'package:test_app/widget_model/mian_screen/news_article_screen_wm.dart';
import 'package:test_app/data/news_article.dart';

class NewsArticlePage extends StatefulWidget {
  NewsArticleScreenWM wm;

  @override
  _NewsArticlePageState createState() => _NewsArticlePageState();
}

class _NewsArticlePageState extends State<NewsArticlePage> {
  @override
  void dispose() {
    widget.wm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.wm = new NewsArticleScreenWM(
        article: ModalRoute.of(context).settings.arguments);

    return Container(
      child: StreamedStateBuilder(
        streamedState: widget.wm.articlesState,
        builder: (context, NewsArticle article) => SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: widget.wm.tapToBack,
              ),
            ),
            body: ListView(
              children: [
                Image(
                    image: NetworkImage(
                  article.urlToImage,
                )),
                Text(article.title),
                //todo поменять при загрузке нормальных статей
                Text(article.description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
