import 'package:flutter/material.dart';
import 'package:vteme_info/data/company.dart';

class CompanyScreen extends StatefulWidget {
  Company company;
  CompanyScreen({Key key, this.company}) : super(key: key);

  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  Company company;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      widget.company = ModalRoute.of(context).settings.arguments;
    });
  }

  @override
  Widget build(BuildContext context) {
    company = this.widget.company;
    return Container(
      child: Scaffold(
        body: ListView(
          children: this.widget.company != null
              ? [
                  Text(company.id.toString()),
                  Text(company.name),
                  Text(company.unp),
                  Text(company.city),
                  Text(company.postIndex.toString()),
                  Text(company.address),
                  Text(company.contact),
                  Text(company.phone),
                  Text(company.email),
                  Text(company.services),
                ]
              : Center(
                  child: Text("Not found"),
                ),
        ),
      ),
    );
  }
}
