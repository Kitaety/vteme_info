import 'package:flutter/material.dart';
import 'package:vteme_info/ui/currency_converter_screen/currency_converter_screen.dart';
import 'package:vteme_info/ui/main_screen/main_screen.dart';
import 'package:vteme_info/utils/navigation_service.dart';

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
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        highlightColor: Colors.purple[50],
        splashColor: Colors.purple[50],
        accentColor: Colors.purple,
        primaryColor: Colors.white,
      ),
    );
  }
}
