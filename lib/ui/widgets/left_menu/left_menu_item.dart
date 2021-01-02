import 'package:flutter/material.dart';

class LeftMenuItem extends StatelessWidget {
  final String title;
  final Function onTap;
  final IconData iconData;

  const LeftMenuItem({
    Key key,
    this.iconData,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: ListTile(
        leading: Icon(
          iconData,
          color: Colors.black87,
        ),
        title: Text(
          title != null? title : "",
        ),
        onTap: onTap,
      ),
    );
  }
}
