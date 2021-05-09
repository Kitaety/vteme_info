import 'package:flutter/material.dart';
import 'package:vteme_info/data/company.dart';
import 'package:vteme_info/ui/company/company_screen/company_page.dart';

class EntertainmentPage extends StatefulWidget {
  EntertainmentPage({Key key}) : super(key: key);

  @override
  _EntertainmentPageState createState() => _EntertainmentPageState();
}

class _EntertainmentPageState extends State<EntertainmentPage> {
  @override
  Widget build(BuildContext context) {
    return CompanyPage(
      group: CompanyGroup.Entertainment,
    );
  }
}
