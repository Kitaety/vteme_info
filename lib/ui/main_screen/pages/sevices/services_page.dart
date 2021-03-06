import 'package:flutter/material.dart';
import 'package:vteme_info/common/icons_vteme_icons.dart';
import 'package:vteme_info/utils/navigation_service.dart';
import 'package:easy_localization/easy_localization.dart';

class ServicesPage extends StatefulWidget {
  ServicesPage({Key key}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        childAspectRatio: 1,
        children: [
          Center(
              child: SizedBox(
            width: 120,
            child: InkWell(
              onTap: () {
                NavigationService.instance
                    .navigateTo("screen_currency_converter");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    IconsVteme.currency_converter,
                    color: Theme.of(context).accentColor,
                    size: 40,
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(
                    "currency_converter".tr(),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
