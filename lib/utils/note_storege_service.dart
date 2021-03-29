import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:vteme_info/data/note.dart';

class NoteStoregeService {
  static Database db;

  static Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'notes.db'),
        version: 2, onCreate: (Database db, int version) async {
      db.execute('''
          create table Notes(
            id integer primary key autoincrement,
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
      'content': note.content,
      'color': note.color.value.toRadixString(16),
    };
    await db.insert('Notes', value);
  }

  static Future updateNote(Note note) async {
    print("[Database] Update notes");
    var value = {
      'id': note.id,
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
