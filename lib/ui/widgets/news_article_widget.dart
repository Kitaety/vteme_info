import 'package:flutter/material.dart';
import 'package:relation/relation.dart';
import 'package:test_app/common/icons_vteme_icons.dart';
import 'package:test_app/common/widget_model.dart';
import 'package:test_app/data/news_article.dart';

import 'package:test_app/widget_model/widgets/news_article_block_wm.dart';
import 'spacer_list_item.dart';

class NewsArticleWidget extends StatefulWidget {
  NewsArticleWidget({
    @required this.onTap,
    WidgetModel widgetModel,
    Key key,
  })  : this.wm = widgetModel,
        super(
          key: key,
        );

  final Function onTap;
  final NewsArticleBlockWm wm;

  @override
  State<StatefulWidget> createState() {
    return NewsArticleWidgetState();
  }
}

class NewsArticleWidgetState extends State<NewsArticleWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamedStateBuilder(
      streamedState: widget.wm.repoState,
      builder: (context, NewsArticle article) => Container(
        height: 130,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Container(
              child: Stack(
                children: [
                  SizedBox(
                    width: 130,
                    height: 130,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image(
                        errorBuilder: (context, error, stackTrace) => Image(
                          fit: BoxFit.fitHeight,
                          image: AssetImage('assets/images/logo.png'),
                        ),
                        fit: BoxFit.fitHeight,
                        image: article.urlToImage != ""
                            ? NetworkImage(
                                article.urlToImage,
                              )
                            : AssetImage('assets/images/logo.png'),
                      ),
                    ),
                  ),
                  StreamedStateBuilder(
                    streamedState: widget.wm.isFavoriteState,
                    builder: (context, isFavorite) => SizedBox(
                      width: 30,
                      height: 30,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        alignment: Alignment.topLeft,
                        onPressed: widget.wm.favoriteTapAction,
                        iconSize: 30,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: Icon(
                          isFavorite
                              ? IconsVteme.bookmark_selected
                              : IconsVteme.bookmark,
                          color: isFavorite
                              ? Theme.of(context).accentColor
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Material(
                child: InkWell(
                  onTap: widget.onTap,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            article.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Text(
                            article.description != null
                                ? article.description
                                : "",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Пинск"),
                                  Text(article.publishedAt)
                                ],
                              ),
                            ),
                            SpacerListItem(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
