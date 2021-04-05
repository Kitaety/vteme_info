import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:vteme_info/data/note.dart';

class NoteStoregeService {
  static Database db;

  static Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'notes.db'),
        version: 5, onCreate: (Database db, int version) async {
      db.execute('''
          create table Notes(
            id integer primary key autoincrement,
            content text not null,
            color text not null
          );
          ''');
    });
  }

  static Future<List<Note>> getListNote() async {
    print("[Database] Load notes");
    if (db == null) {
      await open();
    }

    List<Map<String, dynamic>> list = await db.query("Notes");
    List<Note> notes = [];
    for (dynamic item in list) {
      notes.add(Note(
        id: item['id'],
        content: item['content'],
        color: _toColor(item['color']),
      ));

      Colors.purpleAccent.value.toRadixString(16);
    }
    return notes;
  }

  static Future<Note> getNote({int id}) async {
    print("[Database] Load notes");
    if (db == null) {
      await open();
    }

    Map<String, dynamic> item =
        (await db.query("Notes", where: "id =?", whereArgs: [id]))[0];

    Note note = Note(
      id: item['id'],
      content: item['content'],
      color: _toColor(item['color']),
    );
    Colors.purpleAccent.value.toRadixString(16);

    return note;
  }

  static Future<int> insertNote(Note note) async {
    print("[Database] Add notes");
    var value = {
      'content': note.content,
      'color': note.color.value.toRadixString(16),
    };
    return await db.insert('Notes', value);
  }

  static Future updateNote(Note note) async {
    print("[Database] Update notes");
    var value = {
      'id': note.id,
      'content': note.content,
      'color': note.color.value.toRadixString(16),
    };
    return await db
        .update('Notes', value, where: "id = ?", whereArgs: [note.id]);
  }

  static Future deleteNote(Note note) async {
    print("[Database] Delete notes");
    await db.delete('Notes', where: "id = ?", whereArgs: [note.id]);
  }

  static _toColor(String text) {
    var hexColor = text.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
