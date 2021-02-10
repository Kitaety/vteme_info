import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:relation/relation.dart' as r;
import 'package:test_app/common/error_handler.dart';
import 'package:test_app/common/icons_vteme_icons.dart';
import 'package:test_app/common/widget_model.dart';
import 'package:test_app/data/news_article.dart';

///NewsArticleWidget - блок для показа статьи в списке
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
  final NewsArticleWidgetWm wm;

  @override
  State<StatefulWidget> createState() {
    return NewsArticleWidgetState();
  }
}

class NewsArticleWidgetState extends State<NewsArticleWidget> {
  @override
  Widget build(BuildContext context) {
    return r.StreamedStateBuilder(
      streamedState: widget.wm.repoState,
      builder: (context, NewsArticle article) => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: 130,
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
                              ? CachedNetworkImageProvider(
                                  article.urlToImage,
                                )
                              : AssetImage('assets/images/logo.png'),
                        ),
                      ),
                    ),
                    r.StreamedStateBuilder(
                      streamedState: widget.wm.favoriteState,
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
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
      ),
    );
  }
}

///NewsArticleWidgetWm - модель виджета статьи в списке
///свойства:
///* favoritesState - находиться ли статья в закладках
///* favoriteTapAction - событие нажатия на кнопку "закладка"
///* favoriteState - находиться ли статья в закладках
///* repoState - объект NewsArticle
class NewsArticleWidgetWm extends WidgetModel {
  final favoriteTapAction = r.Action<bool>();
  final favoriteState = r.StreamedState<bool>(false);
  final repoState = r.StreamedState<NewsArticle>();

  NewsArticleWidgetWm(
    NewsArticle repo,
  ) : super(errorHandler: NewsArticleBlockErrorHandler()) {
    subscribe(favoriteTapAction.stream,
        (_) => _handleFavoriteTap(!repoState.value.isFavorite));
    _init(repo);
  }

  void _init(NewsArticle article) {
    repoState.accept(article);
    favoriteState.accept(article.isFavorite);
  }

  //TODO добавление статьи в закладки
  Future<void> _handleFavoriteTap(bool isFavorite) async {
    final NewsArticle article = repoState.value;
    print(isFavorite.toString());
    article.isFavorite = isFavorite;

    favoriteState.accept(isFavorite);

    try {} on Exception catch (e) {
      handleError(e);
    }
  }
}

class NewsArticleBlockErrorHandler extends ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint("[News Article Block]: ${e.toString()}");
  }
}
