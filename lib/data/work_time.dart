import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WorkTime {
  final int id;
  final int idCompany;
  final int numberOfDay;
  final DateTime workStart;
  final DateTime wokrEnd;
  final DateTime pauseStart;
  final DateTime pauseEnd;

  WorkTime(
      {this.id,
      this.numberOfDay,
      this.idCompany,
      this.workStart,
      this.wokrEnd,
      this.pauseEnd,
      this.pauseStart});

  factory WorkTime.fromJson(Map<String, dynamic> json) {
    return WorkTime(
      id: int.parse(json['id']),
      numberOfDay: int.parse(json['number_day_of_week']),
      idCompany: int.parse(json['id_company']),
      workStart: DateFormat("HH:mm:ss").parse(json['work_start']),
      wokrEnd: DateFormat("HH:mm:ss").parse(json['work_end']),
      pauseStart: DateFormat("HH:mm:ss").parse(json['pause_start']),
      pauseEnd: DateFormat("HH:mm:ss").parse(json['pause_end']),
    );
  }
}
