import 'package:flutter/material.dart';
import 'package:vteme_info/data/company.dart';
import 'package:vteme_info/ui/company/company_screen/company_page.dart';

class HostelsPage extends StatefulWidget {
  HostelsPage({Key key}) : super(key: key);

  @override
  _HostelsPageState createState() => _HostelsPageState();
}

class _HostelsPageState extends State<HostelsPage> {
  @override
  Widget build(BuildContext context) {
    return CompanyPage(
      group: CompanyGroup.Hotels,
    );
  }
}
