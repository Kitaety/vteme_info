import 'package:flutter/material.dart';
import 'package:test_app/common/navigation_service.dart';
import 'package:test_app/ui/screen/main_screen/main_screen.dart';
import 'package:test_app/ui/screen/main_screen/pages/news_article_page.dart';


class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigationKey,
      initialRoute: "home",
      routes: {
        // "login":(BuildContext context) =>Login(),
        // "register":(BuildContext context) =>Register(),
        "home":(BuildContext context) => MainScreen(),
        "article_page":(context) => NewsArticlePage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        highlightColor: Colors.purple[50],
        splashColor:  Colors.purple[50],
        accentColor: Colors.purple,
        primaryColor: Colors.white,

      ),
      // home: MainScreen(),
    );
  }
}