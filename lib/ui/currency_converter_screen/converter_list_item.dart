import 'package:flutter/material.dart';
import 'package:relation/relation.dart';
import 'package:test_app/data/currency.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConverterListItem extends StatelessWidget {
  final Currency currency;
  String text;
  double currentCount = 0;

  ConverterListItem({Key key, this.currency, this.text}) : super(key: key) {
    currentCount = currency.officialRate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              width: 70,
              child: SvgPicture.asset(
                "icons/flags/svg/${currency.abbreviation.toLowerCase().substring(0, 2)}.svg",
                package: 'country_icons',
                height: 40,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              currency.abbreviation,
              style: TextStyle(fontSize: 25),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).accentColor),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: StreamedStateBuilder<Object>(
                  streamedState: this.currency.countState,
                  builder: (context, snapshot) {
                    return Text(
                      text == null ? "$snapshot".replaceAll(".", ",") : text,
                      style: TextStyle(fontSize: 20),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}