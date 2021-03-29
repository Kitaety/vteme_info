import 'package:flutter/foundation.dart';
import 'package:relation/relation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vteme_info/common/error_handler.dart';
import 'package:vteme_info/common/widget_model.dart';
import 'package:vteme_info/data/currency.dart';
import 'package:vteme_info/utils/web_services.dart';
import 'package:vteme_info/utils/navigation_service.dart';

class CurrencyConverterScreenWM extends WidgetModel {
  final List<String> defaultCurrencyList = [
    "BYN",
    "USD",
    "EUR",
    "RUB",
    "UAH",
    "PLN",
  ];

  List<String> userCurrencyList = [];
  List<Currency> currencyList = [];

  final currencyState = EntityStreamedState<List<Currency>>()..loading();
  final countBYNState = StreamedState<double>();
  final selectedIndex = StreamedState<int>();
  final changeSelectIndex = Action<int>();
  final tapKey = Action<String>();
  final selectText = StreamedState<String>();
  final tapOnAddBtn = Action<String>();

  CurrencyConverterScreenWM()
      : super(errorHandler: CurrencyConverterScreenErrorHandler()) {
    _loadCurrency();
    subscribe(changeSelectIndex.stream, (index) {
      double value = _currencyList[index].countState.value;

      _changeCounts(value, _currencyList[index]);

      selectText
          .accept(value == 0.0 ? "0" : value.toString().replaceAll(".", ","));
      selectedIndex.accept(index);
    });
    subscribe(tapKey.stream, (key) => _onTapKey(key));
    subscribe(tapOnAddBtn.stream, (key) async {
      await NavigationService.instance.navigateTo("add_currency_page");
      _loadCurrency();
    });
  }

  int get _selectedIndex => selectedIndex.value;
  String get _selectedText => selectText.value;
  List<Currency> get _currencyList => currencyState.value.data;

  void _loadCurrency() async {
    currencyState.loading();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userCurrencyList = prefs.getStringList('currency');
    print(userCurrencyList);
    if (userCurrencyList == null) {
      prefs.setStringList('currency', defaultCurrencyList);
      userCurrencyList = defaultCurrencyList;
    }

    List<Currency> list = [];
    currencyList = await WebServices.currencyList;
    for (String abb in userCurrencyList) {
      for (Currency c in currencyList) if (c.abbreviation == abb) list.add(c);
    }
    currencyState.content(list);
    _changeCounts(1, _currencyList[0]);
    selectedIndex.accept(0);
    selectText.accept(1.0.toStringAsFixed(0));
  }

  void _changeCounts(double countCoin, Currency currency) {
    double byn = double.parse(
        (countCoin * currency.officialRate / currency.scale)
            .toStringAsFixed(4));
    for (Currency c in currencyState.value.data) {
      c.refresh(byn);
    }
  }

  void _onTapKey(String key) {
    switch (key) {
      case ",":
        if (!_selectedText.contains(key))
          selectText.accept(_selectedText + key);
        break;
      case "d":
        if (_selectedText.length > 1)
          selectText
              .accept(_selectedText.substring(0, _selectedText.length - 1));
        else {
          selectText.accept('0');
        }
        _changeCounts(
            double.parse(_selectedText.toString().replaceAll(",", ".")),
            _currencyList[_selectedIndex]);

        break;
      case "c":
        selectText.accept("0");
        _changeCounts(0, _currencyList[_selectedIndex]);
        break;
      default:
        if (_selectedText == "0")
          selectText.accept(key);
        else
          selectText.accept(_selectedText + key);
        _changeCounts(
            double.parse(_selectedText.toString().replaceAll(",", ".")),
            _currencyList[_selectedIndex]);
        break;
    }
  }
}

class CurrencyConverterScreenErrorHandler extends ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint('[Currency Converter Screen]:${e.toString()}');
  }
}
