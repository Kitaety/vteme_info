import 'package:flutter/material.dart';
import 'package:relation/relation.dart';
import 'package:test_app/ui/widgets/primary_appbar.dart';
import 'package:test_app/ui/widgets/left_menu/left_menu.dart';
import 'package:test_app/utils/icons_vteme_icons.dart';
import 'package:test_app/widget_model/mian_screen/main_screen_wn.dart';

import 'pages/news_page.dart';

class MainScreen extends StatefulWidget {
  final MainScreenWM wm = new MainScreenWM();
  final Widget drawer = LeftMenu();

  @override
  State<StatefulWidget> createState() => _MainScreenState();


}

class _MainScreenState extends State<MainScreen> {

  @override
  void dispose() {
    widget.wm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
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
              onTap: widget.wm.changePageAction,
              iconSize: 25,
            ),
          ),
        ),
        appBar: PrimaryAppBar(
          title: Text(
            "Пинск",
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
        ),
        drawer: widget.drawer,
        body: StreamedStateBuilder(
          streamedState: widget.wm.pageIndexState,
          builder: (context, pageIndex) => IndexedStack(
            index: pageIndex,
            children: [
              NewsPage(),
              NewsPage(),
              NewsPage(),
              NewsPage(),
              NewsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
