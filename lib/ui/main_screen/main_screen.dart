import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:relation/relation.dart';
import 'package:test_app/common/icons_vteme_icons.dart';
import 'package:test_app/ui/main_screen/pages/notes/notes_page.dart';
import 'package:test_app/ui/widgets/left_menu/left_menu.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'main_screen_wm.dart';
import 'pages/news_article/news_page.dart';
import 'pages/sevices/services_page.dart';

class MainScreen extends StatefulWidget {
  final MainScreenWM wm = new MainScreenWM();

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Widget _drawer = LeftMenu();
  bool _switchState = false;
  bool isHideAction = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setTitleAppBar(defaultPageIndex);
  }

  @override
  void dispose() {
    widget.wm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamedStateBuilder(
          streamedState: widget.wm.titleAppBarState,
          builder: (context, title) => title,
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).accentColor,
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Row(children: [
              FlutterSwitch(
                height: 25,
                width: 50,
                valueFontSize: ResponsiveFlutter.of(context).fontSize(1.2),
                toggleSize: 16.0,
                value: _switchState,
                onToggle: _onChangeStateSwitch,
                showOnOff: true,
                inactiveText: "RU",
                activeText: "EN",
                activeColor: Theme.of(context).accentColor,
                inactiveTextColor: Colors.white,
                activeTextColor: Colors.white,
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: StreamedStateBuilder(
          streamedState: widget.wm.pageIndexState,
          builder: (context, pageIndex) => BottomNavigationBar(
            unselectedIconTheme: IconThemeData(
              size: 30,
            ),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(IconsVteme.bookmark),
                activeIcon: Icon(IconsVteme.bookmark_selected),
                label: 'Закладки',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconsVteme.notebook),
                activeIcon: Icon(IconsVteme.notebook_selected),
                label: 'Заметки',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconsVteme.home),
                activeIcon: Icon(IconsVteme.home_selected),
                label: 'Главная',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconsVteme.services),
                activeIcon: Icon(IconsVteme.services_selected),
                label: 'Сервисы',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconsVteme.taxi),
                activeIcon: Icon(IconsVteme.taxi_selected),
                label: 'Такси',
              ),
            ],
            currentIndex: pageIndex,
            selectedItemColor: Colors.purple,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: false,
            showSelectedLabels: true,
            onTap: (index) {
              widget.wm.changePageAction(index);
              setTitleAppBar(index);
            },
            iconSize: 25,
          ),
        ),
      ),
      drawer: _drawer,
      body: StreamedStateBuilder(
        streamedState: widget.wm.pageIndexState,
        builder: (context, pageIndex) => getPage(pageIndex),
      ),
    );
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return NewsPage();
      case 1:
        return NotesPage();
      case 3:
        return ServicesPage();
      case 4:
        return NewsPage();
      default:
        return NewsPage();
    }
  }

  String getPageName(int index) {
    switch (index) {
      case 0:
        return "Закладки";
      case 1:
        return "Заметки";
      case 3:
        return "Сервисы";
      case 4:
        return "Такси";
      default:
        return "VTEME";
    }
  }

  void setTitleAppBar(int index) {
    setState(() {
      switch (index) {
        case 2:
          setTitle(Text(
            "Пинск",
            style: TextStyle(color: Theme.of(context).accentColor),
          ));
          break;
        default:
          setTitle(Text(
            getPageName(index),
            style: TextStyle(color: Theme.of(context).accentColor),
          ));
          break;
      }
    });
  }

  void _onChangeStateSwitch(bool state) {
    setState(() {
      _switchState = state;
    });
  }

  void setTitle(Widget widget) {
    this.widget.wm.onChangeTitleAppBar(widget);
  }
}
