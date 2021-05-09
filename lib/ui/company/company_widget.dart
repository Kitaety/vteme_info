import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:vteme_info/data/company.dart';
import 'package:vteme_info/utils/navigation_service.dart';

class CompanyWidget extends StatelessWidget {
  final Company company;
  const CompanyWidget({Key key, this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: ResponsiveFlutter.of(context).scale(130),
        child: InkWell(
          onTap: () async {
            NavigationService.instance
                .navigateTo("company_screen", arguments: company);
          },
          child: Row(
            children: [
              //TODO:Изображение предприятия
              // Container(
              //   child: Stack(
              //     children: [
              //       SizedBox(
              //         width: ResponsiveFlutter.of(context).scale(130),
              //         height: ResponsiveFlutter.of(context).scale(130),
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(5),
              //           child: Image(
              //             errorBuilder: (context, error, stackTrace) => Image(
              //               fit: BoxFit.fitHeight,
              //               image: AssetImage('assets/images/logo.png'),
              //             ),
              //             fit: BoxFit.fitHeight,
              //             image: article.urlToImage != ""
              //                 ? CachedNetworkImageProvider(
              //                     article.urlToImage,
              //                   )
              //                 : AssetImage('assets/images/logo.png'),
              //           ),
              //         ),
              //       ),
              //       r.StreamedStateBuilder(
              //         streamedState: widget.wm.favoriteState,
              //         builder: (context, isFavorite) => SizedBox(
              //           width: ResponsiveFlutter.of(context).scale(30),
              //           height: ResponsiveFlutter.of(context).scale(30),
              //           child: IconButton(
              //             padding: EdgeInsets.all(0),
              //             alignment: Alignment.topLeft,
              //             onPressed: widget.wm.favoriteTapAction,
              //             iconSize: ResponsiveFlutter.of(context).scale(30),
              //             splashColor: Colors.transparent,
              //             highlightColor: Colors.transparent,
              //             icon: Icon(
              //               isFavorite
              //                   ? IconsVteme.bookmark_selected
              //                   : IconsVteme.bookmark,
              //               color: isFavorite
              //                   ? Theme.of(context).accentColor
              //                   : Colors.white,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Expanded(
                child: Material(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                company.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(2.2),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                company.category,
                                style: TextStyle(
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(1.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Text(
                            company.description != null
                                ? company.description
                                : "",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                            ),
                            maxLines: 3,
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
                                  Text(
                                    company.city,
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(1.5),
                                    ),
                                  ),
                                  Text(
                                    DateFormat("dd.MM.yyyy")
                                        .format(company.dateUpdate),
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(1.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
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
