import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:relation/relation.dart';
import 'package:vteme_info/common/icons_vteme_icons.dart';
import 'package:vteme_info/ui/main_screen/pages/notes/notes_page.dart';
import 'package:vteme_info/ui/widgets/left_menu/left_menu.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'main_screen_wm.dart';
import 'pages/news_article/news_page.dart';
import 'pages/sevices/services_page.dart';
import 'package:easy_localization/easy_localization.dart';

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
    setState(() {
      _switchState = EasyLocalization.of(context).locale.toString() == "en_US";
    });
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
                height: ResponsiveFlutter.of(context).wp(7),
                width: ResponsiveFlutter.of(context).wp(14),
                valueFontSize: ResponsiveFlutter.of(context).fontSize(1.2),
                toggleSize: ResponsiveFlutter.of(context).wp(5),
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
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(IconsVteme.bookmark),
                activeIcon: Icon(IconsVteme.bookmark_selected),
                label: "favorites".tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(IconsVteme.notebook),
                activeIcon: Icon(IconsVteme.notebook_selected),
                label: 'notes'.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(IconsVteme.home),
                activeIcon: Icon(IconsVteme.home_selected),
                label: 'home'.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(IconsVteme.services),
                activeIcon: Icon(IconsVteme.services_selected),
                label: 'services'.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(IconsVteme.taxi),
                activeIcon: Icon(IconsVteme.taxi_selected),
                label: 'taxi'.tr(),
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
        return "favorites".tr();
      case 1:
        return "notes".tr();
      case 3:
        return "services".tr();
      case 4:
        return "taxi".tr();
      default:
        return "VTEME";
    }
  }

  void setTitleAppBar(int index) {
    setState(() {
      switch (index) {
        case 2:
          setTitle(Text(
            "pinsk".tr(),
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

  //todo сохранение выбранной локали
  void _onChangeStateSwitch(bool state) {
    EasyLocalization.of(context).locale =
        state ? Locale("en", "US") : Locale("ru", "RU");
    setState(() {
      _switchState = state;
    });
  }

  void setTitle(Widget widget) {
    this.widget.wm.onChangeTitleAppBar(widget);
  }
}
