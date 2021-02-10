import 'package:relation/relation.dart';

class Currency {
  final int id;
  final String abbreviation;
  final int scale;
  final double officialRate;
  final String name;
  final countState = StreamedState<double>();

  Currency({
    this.id,
    this.abbreviation,
    this.scale,
    this.officialRate,
    this.name,
  }) {
    refresh(1);
  }

  void refresh(double byn) {
    double count = (byn / officialRate) * scale;

    countState.accept(double.parse(count.toStringAsFixed(4)));
  }

  //JSON
  // Cur_ID: 303,
  // Date: "2021-02-08T00:00:00",
  // Cur_Abbreviation: "IRR",
  // Cur_Scale: 100000,
  // Cur_Name: "Иранских риалов",
  // Cur_OfficialRate: 6.2576,
  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
        id: json['Cur_ID'],
        abbreviation: json['Cur_Abbreviation'],
        scale: json['Cur_Scale'],
        officialRate: json['Cur_OfficialRate'],
        name: json['Cur_Name']);
  }

  static Map<String, String> iconCurrency = {
    "BYN": 'icons/flags/svg/by.svg',
    "AUD": "icons/flags/svg/au.svg",
    "BGN": "icons/flags/svg/bg.svg",
    "UAH": "icons/flags/svg/ua.svg",
    "DKK": "icons/flags/svg/dk.svg",
    "USD": "icons/flags/svg/us.svg",
    "EUR": "icons/flags/svg/eu.svg",
    "PLN": "icons/flags/svg/pl.svg",
    "JPY": "icons/flags/svg/jp.svg",
    "IRR": "icons/flags/svg/ir.svg",
    "ISK": "icons/flags/svg/is.svg",
    "CAD": "icons/flags/svg/ca.svg",
    "CNY": "icons/flags/svg/au.svg",
    "KWD": "icons/flags/svg/au.svg",
    "MDL": "icons/flags/svg/au.svg",
    "NZD": "icons/flags/svg/au.svg",
    "NOK": "icons/flags/svg/au.svg",
    "RUB": 'icons/flags/svg/ru.svg',
    "XDR": "icons/flags/svg/au.svg",
    "SGD": "icons/flags/svg/au.svg",
    "KGS": "icons/flags/svg/au.svg",
    "KZT": "icons/flags/svg/au.svg",
    "TRY": "icons/flags/svg/au.svg",
    "GBP": "icons/flags/svg/au.svg",
    "CZK": "icons/flags/svg/au.svg",
    "SEK": "icons/flags/svg/au.svg",
    "CHF": "icons/flags/svg/au.svg",
  };

  static Currency byn = Currency(
    id: 0,
    abbreviation: 'BYN',
    scale: 1,
    officialRate: 1,
    name: 'Белорусский рубль',
  );
}
