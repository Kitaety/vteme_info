import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:relation/relation.dart';
import 'package:test_app/data/news_article.dart';
import 'package:test_app/ui/widgets/slide_ad_block.dart';
import 'news_article_widget.dart';
import 'news_page_wm.dart';
import 'vip_ad_block.dart';

class NewsPage extends StatefulWidget {
  final NewsPageWM wm = new NewsPageWM();

  @override
  State<StatefulWidget> createState() {
    return NewsPageState();
  }
}

class NewsPageState extends State<NewsPage> {
  int modCountAd = 7;
  GlobalKey<RefreshIndicatorState> refreshState;

  List<Widget> buildItemList(List<NewsArticle> articles) {
    List<Widget> results = [];
    for (int i = 0; i < articles.length; i++) {
      if (i > 0 && i % modCountAd == 0) {
        //TODO доделать баннер рекламы
        results.add(VipAdBlock());
      } else {
        results.add(Card(
          child: NewsArticleWidget(
            widgetModel: new NewsArticleWidgetWm(articles[i]),
          ),
        ));
      }
    }
    return results;
  }

  @override
  void initState() {
    super.initState();
    refreshState = GlobalKey<RefreshIndicatorState>();
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
                        onPressed: widget.wm.refresNewsArticle,
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
                child: (ctx, articles) => RefreshIndicator(
                  key: refreshState,
                  onRefresh: () async {
                    await widget.wm.refresNewsArticle();
                  },
                  child: ListView(
                    children: buildItemList(articles),
                    clipBehavior: Clip.antiAlias,
                  ),
                  // child: ListView.builder(
                  //   padding: EdgeInsets.symmetric(horizontal: 10),
                  //   clipBehavior: Clip.antiAlias,
                  //   itemBuilder: (ctx, i) {
                  //   },
                  // ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
