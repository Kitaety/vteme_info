import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:relation/relation.dart';
import 'package:vteme_info/data/company.dart';
import 'package:vteme_info/ui/company/company_widget.dart';
import 'package:vteme_info/utils/web_services.dart';

class HostelsPage extends StatefulWidget {
  HostelsPage({Key key}) : super(key: key);

  @override
  _HostelsPageState createState() => _HostelsPageState();
}

//TODO: Доделать загрузку списка при смене экрана
class _HostelsPageState extends State<HostelsPage>
    with TickerProviderStateMixin {
  TabController _controller;
  EntityStreamedState<List<Company>> companys =
      EntityStreamedState<List<Company>>();
  final List<int> categoryes = [4, 5, 6, 7];
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);

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
            tabs: [
              Tab(text: "all".tr()),
              Tab(text: "inn".tr()),
              Tab(text: "hotel".tr()),
              Tab(text: "hostel".tr()),
              Tab(text: "manor".tr()),
            ],
          ),
          title: Text(
            "hotels".tr(),
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
        // child: TabBarView(
        //     controller: _controller,
        //     children: [
        //       Text("all".tr()),
        //       Text("Гостиница"),
        //       Text("Отель"),
        //       Text("Хостел"),
        //       Text("Усадьба"),
        //     ],
        //   ),
      ),
    );
  }

  void getCompanyList(int index) async {
    companys.loading();
    (index == 0
            ? WebServices().getCompanyByGroup(CompanyGroup.Hotels)
            : WebServices().getCompanyByCategoryId(categoryes[index - 1]))
        .then((value) => companys.content(value))
        .catchError((error) => companys.error(error));
  }
}
