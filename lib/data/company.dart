import 'dart:convert';
import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:vteme_info/data/work_time.dart';

//TODO: Добавить изображения и рейтинг
class Company {
  final int id;
  final String name;
  final String unp;
  final String description;
  final String city;
  //post_index
  final int postIndex;
  final String address;
  final String contact;
  final String phone;
  final String email;
  final String services;
  //date_registration
  final DateTime dateRegistration;
  //date_update
  final DateTime dateUpdate;
  final String category;
  //work_time
  final List workTime;

  Company(
      {this.id,
      this.name,
      this.unp,
      this.description,
      this.city,
      this.postIndex,
      this.address,
      this.contact,
      this.phone,
      this.email,
      this.services,
      this.dateRegistration,
      this.dateUpdate,
      this.category,
      this.workTime});

  factory Company.fromJson(Map<String, dynamic> json) {
    Company result = Company(
        id: int.parse(json['id']),
        name: json['name'],
        unp: json['unp'],
        description: json['description'],
        city: json['city'],
        postIndex: int.parse(json['post_index']),
        address: json['address'],
        contact: json['contact'],
        phone: json['phone'],
        email: json['email'],
        services: json['services'],
        dateRegistration: DateTime.parse(json['date_registration']),
        dateUpdate: DateTime.parse(json['date_update']),
        category: json['category'],
        workTime: []);
    dynamic worktime = json['work_time'];
    (worktime as List).forEach((element) {
      result.workTime.add(WorkTime.fromJson(element));
    });
    return result;
  }
}

enum CompanyGroup {
  Hotels,
  FoodPoints,
  MedicalInstitutions,
  Entertainment,
  Shops
}
