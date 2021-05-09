import 'package:flutter/material.dart';
import 'package:vteme_info/data/company.dart';
import 'package:vteme_info/ui/company/company_screen/company_page.dart';

class ShopsPage extends StatefulWidget {
  ShopsPage({Key key}) : super(key: key);

  @override
  _ShopsPageState createState() => _ShopsPageState();
}

class _ShopsPageState extends State<ShopsPage> {
  @override
  Widget build(BuildContext context) {
    return CompanyPage(
      group: CompanyGroup.Shops,
    );
  }
}
