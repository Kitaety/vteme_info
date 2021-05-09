import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:relation/relation.dart';
import 'package:vteme_info/data/company.dart';
import 'package:vteme_info/ui/company/company_widget.dart';
import 'package:vteme_info/utils/web_services.dart';

class CompanyPage extends StatefulWidget {
  final CompanyGroup group;
  List<int> categoryes;
  List<String> categoryesName;
  String title;

  CompanyPage({
    Key key,
    this.group,
  }) : super(key: key) {
    switch (group) {
      case CompanyGroup.Hotels:
        {
          categoryes = [4, 5, 6, 7];
          categoryesName = ["all", "inn", "hotel", "hostel", "manor"];
          title = "hotels";
          break;
        }
      case CompanyGroup.FoodPoints:
        {
          categoryes = [8, 9, 10, 11, 12, 13];
          categoryesName = [
            "all",
            "restaurant",
            "cafe",
            "pub",
            "canteen",
            "coffee_house",
            "pizzeria"
          ];
          title = "food_points";
          break;
        }
      case CompanyGroup.MedicalInstitutions:
        {
          categoryes = [17, 18, 19, 20, 21, 22];
          categoryesName = [
            "all",
            "hospital",
            "polyclinic",
            "dispensary",
            "maternity_hospital",
            "pharmacy",
            "health_center"
          ];
          title = "medical_institutions";
          break;
        }
      case CompanyGroup.Shops:
        {
          categoryes = [28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38];
          categoryesName = [
            "all",
            "grocery_store",
            "hardware_store",
            "household_store",
            "clothes_and_footwear",
            "stationery",
            "auto-moto-bike_goods",
            "beauty_and_health",
            "jewelry",
            "household_products",
            "agriculture",
            "sports_and_recreation",
          ];
          title = "shops";
          break;
        }
      case CompanyGroup.Entertainment:
        {
          categoryes = [23, 24, 25, 26, 27];
          categoryesName = [
            "all",
            "club",
            "quest",
            "cinema",
            "theatre",
            "leisure"
          ];
          title = "shops";
          break;
        }
    }
  }

  @override
  _HostelsPageState createState() => _HostelsPageState();
}

class _HostelsPageState extends State<CompanyPage>
    with TickerProviderStateMixin {
  TabController _controller;
  EntityStreamedState<List<Company>> companys =
      EntityStreamedState<List<Company>>();
  @override
  void initState() {
    super.initState();
    _controller =
        TabController(length: widget.categoryes.length + 1, vsync: this);

    _controller.addListener(() {
      setState(() {
        getCompanyList(_controller.index);
      });
    });
    getCompanyList(0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
              controller: _controller,
              indicatorColor: Theme.of(context).accentColor,
              isScrollable: true,
              tabs: widget.categoryesName
                  .map((e) => Tab(
                        text: e.tr(),
                      ))
                  .toList()),
          title: Text(
            widget.title.tr(),
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).accentColor,
          ),
        ),
        body: EntityStateBuilder(
          streamedState: companys,
          child: (context, List<Company> snapshot) => ListView(
            children: snapshot
                .map((e) => Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: CompanyWidget(
                        company: e,
                      ),
                    ))
                .toList(),
          ),
          loadingChild: Center(
            child: CircularProgressIndicator(),
          ),
          errorChild: Center(
            child: Text("not_found".tr()),
          ),
        ),
      ),
    );
  }

  void getCompanyList(int index) async {
    companys.loading();
    (index == 0
            ? WebServices().getCompanyByGroup(widget.group)
            : WebServices()
                .getCompanyByCategoryId(widget.categoryes[index - 1]))
        .then((value) => companys.content(value))
        .catchError((error) => companys.error(error));
  }
}
