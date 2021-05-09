import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vteme_info/ui/company/company_screen/company_screen.dart';
import 'package:vteme_info/ui/company/pages/entertainment_page.dart';
import 'package:vteme_info/ui/company/pages/food_point_page.dart';
import 'package:vteme_info/ui/company/pages/hostels_page.dart';
import 'package:vteme_info/ui/company/pages/medical_page.dart';
import 'package:vteme_info/ui/company/pages/organizations_page.dart';
import 'package:vteme_info/ui/company/pages/shops_page.dart';
import 'package:vteme_info/ui/currency_converter_screen/currency_converter_screen.dart';
import 'package:vteme_info/ui/main_screen/main_screen.dart';
import 'package:vteme_info/utils/navigation_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'news_article_screen/news_article_screen.dart';
import 'note_screen/note_screen.dart';
import 'package:vteme_info/ui/currency_converter_screen/add_currency_page/add_currency_page.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigationKey,
      initialRoute: "screen_home",
      routes: {
        // "login":(BuildContext context) =>Login(),
        // "register":(BuildContext context) =>Register(),
        "screen_home": (BuildContext context) => MainScreen(),
        "screen_article": (context) => NewsArticleScreen(),
        "screen_note": (context) => NoteScreen(),
        "screen_currency_converter": (context) => CurrencyConverterScreen(),
        "add_currency_page": (context) => AddCurrencyPage(),
        "news_article_screen": (context) => NewsArticleScreen(),
        "company_screen": (context) => CompanyScreen(),
        "hostels": (context) => HostelsPage(),
        "food_points": (context) => FoodPointPage(),
        "organizations": (context) => OrganizationsPage(),
        "medical": (context) => MedicalPage(),
        "entertainment": (context) => EntertainmentPage(),
        "shops": (context) => ShopsPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        highlightColor: Colors.purple[50],
        splashColor: Colors.purple[50],
        accentColor: Colors.purple,
        primaryColor: Colors.white,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
    );
  }
}
