import 'package:flutter/material.dart';
import 'package:relation/relation.dart';
import 'package:test_app/data/news_article.dart';
import 'package:test_app/ui/widgets/slide_ad_block.dart';
import 'package:test_app/ui/widgets/news_article_widget.dart';
import 'package:test_app/ui/widgets/vip_ad_block.dart';
import 'package:test_app/widget_model/mian_screen/pages/news_page_wm.dart';
import 'package:test_app/widget_model/widgets/news_article_block_wm.dart';
import 'package:test_app/widget_model/widgets/vip_ad_block_wm.dart';

class NewsPage extends StatefulWidget {
  NewsPageWM wm = new NewsPageWM();

  @override
  State<StatefulWidget> createState() {
    return NewsPageState();
  }
}

class NewsPageState extends State<NewsPage> {
  int modCountAd = 7;

  Widget buildItemList(int i, NewsArticle article) {
    if (i > 0 && i % modCountAd == 0) {
      return VipAdBlock(widgetModel: new VipAdBlockWM());
    } else {
      return NewsArticleWidget(
          widgetModel: new NewsArticleBlockWm(article),
          onTap: () {
            widget.wm.tapAction.call(article);
          });
    }
  }

  @override
  void dispose() {
    widget.wm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SlideAdBlock(),
          Expanded(
            child: Container(
              child: EntityStateBuilder<List<NewsArticle>>(
                streamedState: widget.wm.articlesState,
                errorChild: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Произошла ошибка'),
                      FlatButton(
                        onPressed: widget.wm.refreshAction,
                        child: const Text('Обновить'),
                      ),
                    ],
                  ),
                ),
                loadingChild: Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor),
                  ),
                ),
                child: (ctx, articles) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      clipBehavior: Clip.antiAlias,
                      itemBuilder: (ctx, i) {
                        if (i + (i~/modCountAd) >= articles.length) return null;
                        else return buildItemList(i, articles[i - (i~/modCountAd)]);
                      },
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
      // body:
    );
  }
}
