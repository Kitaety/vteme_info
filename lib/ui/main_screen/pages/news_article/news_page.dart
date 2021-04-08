import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';
import 'package:vteme_info/data/news_article.dart';
import 'package:vteme_info/ui/widgets/slide_ad_block.dart';
import 'package:vteme_info/utils/ad_mob_service.dart';
import 'news_article_widget.dart';
import 'news_page_wm.dart';
import 'package:easy_localization/easy_localization.dart';

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
        results.add(Provider.of<AdMobService>(context).getVipBanner());
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
                      Text('error'.tr()),
                      TextButton(
                          onPressed: widget.wm.refresNewsArticle,
                          child: Text('refresh'.tr())),
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
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
