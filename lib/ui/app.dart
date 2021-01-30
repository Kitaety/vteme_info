import 'package:flutter/material.dart';
import 'package:test_app/ui/main_screen/main_screen.dart';
import 'package:test_app/utils/navigation_service.dart';

import 'news_article_screen/news_article_screen.dart';
import 'note_screen/note_screen.dart';

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
        "note": (context) => NoteScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        highlightColor: Colors.purple[50],
        splashColor: Colors.purple[50],
        accentColor: Colors.purple,
        primaryColor: Colors.white,
      ),
      // home: MainScreen(),
    );
  }
}
