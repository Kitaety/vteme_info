import 'package:flutter/material.dart';
import 'package:vteme_info/data/company.dart';
import 'package:vteme_info/ui/company/company_screen/company_page.dart';

class OrganizationsPage extends StatefulWidget {
  OrganizationsPage({Key key}) : super(key: key);

  @override
  _OrganizationsPageState createState() => _OrganizationsPageState();
}

class _OrganizationsPageState extends State<OrganizationsPage> {
  @override
  Widget build(BuildContext context) {
    return CompanyPage(
      group: CompanyGroup.Hotels,
    );
  }
}
