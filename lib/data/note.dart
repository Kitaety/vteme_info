import 'dart:convert';

import 'package:flutter/material.dart';

///класс описывающий заметку
///свойства
/// * @param id - Int, ид заметки в бд
/// * @param title - String, заголовок заметки
/// * @param content - String, содержание заметки
/// * @param color - Color, цвет заметки
///
/// методы
/// *toMap - функция toMap для запросов к БД
///
/// константы:
/// *defaultColor - возвращает цвет заметки поумолчанию

class Note {
  static const Color defaultColor = Colors.purpleAccent;
  final int id;
  String content;
  Color color;

  Note({
    this.id,
    this.content,
    this.color,
  });

  Map<String, dynamic> toMap(bool forUpdate) {
    var data = {
      'content': utf8.encode(content),
      'color': color.value,
    };
    if (forUpdate) {
      data["id"] = this.id;
    }
    return data;
  }

  @override
  String toString() {
    return 'Note(id: $id,  content: $content, color: $color)';
  }
}
