import 'package:flutter/cupertino.dart';

enum TypeUser {
  business,
  base,
}

class User {
  int id;
  String email;
  String password;
  String name;
  int type;

  User({
    @required this.id,
    @required this.email,
    @required this.password,
    @required this.name,
    @required this.type,
  });
}
