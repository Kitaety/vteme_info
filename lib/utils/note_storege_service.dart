import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:test_app/data/note.dart';

class NoteStoregeService {
  static Database db;

  static final List<Note> notes = [
    Note(
      color: Colors.redAccent,
      id: 1,
      title: "Заметка 1",
      content:
          'ыоасывар оаы враыа ораы ывраыв аорыоары орыра ыро ыоаыр ры аоа' +
              'ы аоыаыраыоы ыа ыаоыаывл fsdjf fs hfs hj dad ad f sf sf s',
    ),
    Note(
      color: Colors.purpleAccent,
      id: 2,
      title: "Заметка 2",
      content:
          'ыоасывар оаы враыа ораы ывраыв аорыоары орыра ыро ыоаыр ры аоа' +
              'ы аоыаыраыоы ыа ыаоыаывл fsdjf fs hfs hj dad ad f sf sf s',
    ),
    Note(
      color: Colors.purpleAccent,
      id: 3,
      title: "Заметка 3",
      content:
          'ыоасывар оаы враыа ораы ывраыв аорыоары орыра ыро ыоаыр ры аоа' +
              'ы аоыаыраыоы ыа ыаоыаывл fsdjf fs hfs hj dad ad f sf sf s',
    ),
    Note(
      color: Colors.purpleAccent,
      id: 4,
      title: "Заметка 4",
      content:
          'ыоасывар оаы враыа ораы ывраыв аорыоары орыра ыро ыоаыр ры аоа' +
              'ы аоыаыраыоы ыа ыаоыаывл fsdjf fs hfs hj dad ad f sf sf s',
    ),
    Note(
      color: Colors.purpleAccent,
      id: 5,
      title: "Заметка 5",
      content:
          'ыоасывар оаы враыа ораы ывраыв аорыоары орыра ыро ыоаыр ры аоа' +
              'ы аоыаыраыоы ыа ыаоыаывл fsdjf fs hfs hj dad ad f sf sf s',
    ),
  ];

  static Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'notes.db'),
        version: 1, onCreate: (Database db, int version) async {
      db.execute('''
          create table Notes(
            id integer primary key autoincrement,
            title text not null,
            content text not null,
            color text not null
          );
          ''');
    });
  }

  static Future<List<Map<String, dynamic>>> getListNote() async {
    print("[Database] Load notes");
    if (db == null) {
      await open();
    }

    return await db.query("Notes");
  }

  static Future insertNote(Note note) async {
    print("[Database] Add notes");
    var value = {
      'title': note.title,
      'content': note.content,
      'color': note.color.value.toRadixString(16),
    };
    await db.insert('Notes', value);
  }

  static Future updateNote(Note note) async {
    print("[Database] Update notes");
    var value = {
      'id': note.id,
      'title': note.title,
      'content': note.content,
      'color': note.color.value.toRadixString(16),
    };
    await db.update('Notes', value, where: "id = ?", whereArgs: [note.id]);
  }

  static Future deleteNote(Note note) async {
    print("[Database] Delete notes");
    await db.delete('Notes', where: "id = ?", whereArgs: [note.id]);
  }
}
