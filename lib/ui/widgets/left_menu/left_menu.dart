import 'package:flutter/material.dart';
import 'package:vteme_info/common/icons_vteme_icons.dart';
import 'package:vteme_info/utils/navigation_service.dart';
import '../spacer_list_item.dart';
import 'left_menu_header.dart';
import 'left_menu_item.dart';
import 'package:easy_localization/easy_localization.dart';

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
            title: "tourist_assistance".tr(),
            iconData: IconsVteme.tourism,
            onTap: () {},
          ),
          SpacerListItem(),
          LeftMenuItem(
            iconData: IconsVteme.bus,
            title: "urban_transport".tr(),
            onTap: () {},
          ),
          SpacerListItem(),
          LeftMenuItem(
            iconData: IconsVteme.hostel,
            title: "hotels".tr(),
            onTap: () async {
              await NavigationService.instance.navigateTo("hostels");
            },
          ),
          LeftMenuItem(
            iconData: IconsVteme.food_points,
            title: "food_points".tr(),
            onTap: () async {
              await NavigationService.instance.navigateTo("food_points");
            },
          ),
          LeftMenuItem(
            iconData: IconsVteme.plant,
            title: "organizations".tr(),
            onTap: () async {
              await NavigationService.instance.navigateTo("organizations");
            },
          ),
          LeftMenuItem(
            iconData: IconsVteme.coin,
            title: "banking_services".tr(),
            onTap: () {},
          ),
          LeftMenuItem(
            iconData: IconsVteme.heartbeat,
            title: "medical_institutions".tr(),
            onTap: () async {
              await NavigationService.instance.navigateTo("medical");
            },
          ),
          LeftMenuItem(
            iconData: IconsVteme.entertainment,
            title: "entertainment".tr(),
            onTap: () async {
              await NavigationService.instance.navigateTo("entertainment");
            },
          ),
          LeftMenuItem(
            iconData: IconsVteme.trade,
            title: "shops".tr(),
            onTap: () async {
              await NavigationService.instance.navigateTo("shops");
            },
          ),
          SpacerListItem(),
          LeftMenuItem(
            iconData: IconsVteme.announcements,
            title: "ads".tr(),
            onTap: () {},
          ),
          LeftMenuItem(
            iconData: IconsVteme.my_announcements,
            title: "my_ads".tr(),
            onTap: () {},
          ),
          SpacerListItem(),
          LeftMenuItem(
            iconData: IconsVteme.warning,
            title: "report".tr(),
            onTap: () {},
          ),
          LeftMenuItem(
            iconData: IconsVteme.settings,
            title: "about".tr(),
            onTap: () {},
          ),
          LeftMenuItem(
            iconData: IconsVteme.share,
            title: "share".tr(),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
