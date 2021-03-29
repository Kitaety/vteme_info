import 'package:flutter/material.dart';
import 'package:vteme_info/common/icons_vteme_icons.dart';
import '../spacer_list_item.dart';
import 'left_menu_header.dart';
import 'left_menu_item.dart';

const Duration drawerAnimationDuration = Duration(milliseconds: 250);

class LeftMenu extends StatefulWidget {
  final Color color;

  const LeftMenu({
    Key key,
    this.color,
  }) : super(key: key);

  @override
  _LeftMenuState createState() => _LeftMenuState();
}

class _LeftMenuState extends State<LeftMenu>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height,
      color:
          widget.color != null ? widget.color : Theme.of(context).primaryColor,
      child: ListView(
        children: [
          LeftMenuHeader(),
          LeftMenuItem(
            title: "В помощь туристу",
            iconData: IconsVteme.tourism,
            onTap: () {},
          ),
          SpacerListItem(),
          LeftMenuItem(
            iconData: IconsVteme.bus,
            title: "Расписание городского транспорта",
            onTap: () {},
          ),
          SpacerListItem(),
          LeftMenuItem(
            iconData: IconsVteme.hostel,
            title: "Места размещения",
            onTap: () {},
          ),
          LeftMenuItem(
            iconData: IconsVteme.food_points,
            title: "Пункты питания",
            onTap: () {},
          ),
          LeftMenuItem(
            iconData: IconsVteme.plant,
            title: "Каталог организаций",
            onTap: () {},
          ),
          LeftMenuItem(
            iconData: IconsVteme.coin,
            title: "Банковские и финансовые услуги",
            onTap: () {},
          ),
          LeftMenuItem(
            iconData: IconsVteme.heartbeat,
            title: "Медицинские учреждения",
            onTap: () {},
          ),
          LeftMenuItem(
            iconData: IconsVteme.entertainment,
            title: "Отдых и развлечения",
            onTap: () {},
          ),
          LeftMenuItem(
            iconData: IconsVteme.trade,
            title: "Магазины",
            onTap: () {},
          ),
          SpacerListItem(),
          LeftMenuItem(
            iconData: IconsVteme.announcements,
            title: "Объявления",
            onTap: () {},
          ),
          LeftMenuItem(
            iconData: IconsVteme.my_announcements,
            title: "Мои объявления",
            onTap: () {},
          ),
          SpacerListItem(),
          LeftMenuItem(
            iconData: IconsVteme.warning,
            title: "Сообщить об ошибке",
            onTap: () {},
          ),
          LeftMenuItem(
            iconData: IconsVteme.settings,
            title: "О разработчике",
            onTap: () {},
          ),
          LeftMenuItem(
            iconData: IconsVteme.share,
            title: "Рассказать друзьям",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
