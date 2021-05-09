import 'package:flutter/material.dart';
import 'package:vteme_info/data/company.dart';
import 'package:vteme_info/ui/company/company_screen/company_page.dart';

class FoodPointPage extends StatefulWidget {
  FoodPointPage({Key key}) : super(key: key);

  @override
  _FoodPointPageState createState() => _FoodPointPageState();
}

class _FoodPointPageState extends State<FoodPointPage> {
  @override
  Widget build(BuildContext context) {
    return CompanyPage(
      group: CompanyGroup.FoodPoints,
    );
  }
}
