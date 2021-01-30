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

class Note {
  final int id;
  String title;
  String content;
  Color color;

  Note({
    this.id,
    this.title,
    this.content,
    this.color,
  });

  Map<String, dynamic> toMap(bool forUpdate) {
    var data = {
      'title': utf8.encode(title),
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
    return 'Note(id: $id, title: $title, content: $content, color: $color)';
  }
}
