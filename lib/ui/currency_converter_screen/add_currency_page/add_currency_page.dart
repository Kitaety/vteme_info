import 'package:flutter/material.dart';
import 'package:relation/relation.dart';
import 'package:test_app/data/currency.dart';
import 'package:test_app/ui/currency_converter_screen/add_currency_page/add_currency_page_wm.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class AddCurrencyPage extends StatefulWidget {
  AddCurrencyPageWM wm = AddCurrencyPageWM();

  AddCurrencyPage({Key key}) : super(key: key);

  @override
  _AddCurrencyPageState createState() => _AddCurrencyPageState();
}

class _AddCurrencyPageState extends State<AddCurrencyPage> {
  @override
  void dispose() {
    widget.wm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            iconTheme: IconThemeData(
              color: Theme.of(context).accentColor,
            ),
            title: Text("Настройки конвертера",
                style: TextStyle(color: Theme.of(context).accentColor)),
          ),
          body: EntityStateBuilder<List<Currency>>(
            streamedState: widget.wm.currencysEntity,
            loadingChild: Center(child: CircularProgressIndicator()),
            child: (context, List<Currency> list) => ListView.builder(
                itemCount: list.length,
                padding: EdgeInsets.symmetric(horizontal: 5),
                itemBuilder: (context, index) => Container(
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: SizedBox(
                            width: ResponsiveFlutter.of(context).scale(50),
                            child: SvgPicture.asset(
                              "icons/flags/svg/${list[index].abbreviation.toLowerCase().substring(0, 2)}.svg",
                              package: 'country_icons',
                              height: ResponsiveFlutter.of(context).scale(30),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              list[index].abbreviation,
                              style: TextStyle(
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(2.5)),
                            ),
                            Text(
                              list[index].name,
                              style: TextStyle(
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(2)),
                            )
                          ],
                        ),
                        trailing: index > 0
                            ? StreamedStateBuilder(
                                streamedState: widget.wm.userCurrency,
                                builder: (context, List<String> item) =>
                                    IconButton(
                                  icon: Icon(
                                      item.contains(list[index].abbreviation)
                                          ? Icons.delete
                                          : Icons.add),
                                  iconSize:
                                      ResponsiveFlutter.of(context).scale(26),
                                  onPressed: () {
                                    item.contains(list[index].abbreviation)
                                        ? widget.wm.deleteCurrency(
                                            list[index].abbreviation)
                                        : widget.wm.addCurrency(
                                            list[index].abbreviation);
                                  },
                                ),
                              )
                            : null,
                      ),
                    )),
          )),
    );
  }
}
