import 'package:relation/relation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vteme_info/data/currency.dart';
import 'package:vteme_info/utils/web_services.dart';
import 'package:vteme_info/common/widget_model.dart';

class AddCurrencyPageWM extends WidgetModel {
  StreamedState<List<String>> userCurrency = StreamedState();
  EntityStreamedState<List<Currency>> currencysEntity = EntityStreamedState();
  Action<String> addCurrency = Action();
  Action<String> deleteCurrency = Action();

  AddCurrencyPageWM() {
    _loadUserCurrency();

    subscribe(addCurrency.stream, (value) {
      List<String> list = userCurrency.value;
      list.add(value);
      userCurrency.accept(list);
      _save();
    });
    subscribe(deleteCurrency.stream, (value) {
      List<String> list = userCurrency.value;
      list.remove(value);
      userCurrency.accept(list);
      _save();
    });
  }

  void _loadUserCurrency() async {
    currencysEntity.loading();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userCurrency.accept(prefs.getStringList('currency'));
    currencysEntity.content(WebServices.currencyList);
  }

  void _save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('currency', userCurrency.value);
  }

  @override
  void dispose() async {
    _save();
    super.dispose();
  }
}
