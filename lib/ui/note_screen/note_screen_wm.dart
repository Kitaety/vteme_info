import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:relation/relation.dart' as r;
import 'package:test_app/common/error_handler.dart';
import 'package:test_app/common/widget_model.dart';
import 'package:test_app/data/note.dart';
import 'package:test_app/utils/navigation_service.dart';
import 'package:test_app/utils/note_storege_service.dart';

enum NoteMode {
  Adding,
  Editing,
}

class NoteArgs {
  final NoteMode mode;
  final Note note;

  NoteArgs(this.mode, this.note);
}

class NoteScreenWM extends WidgetModel {
  Note _note;
  NoteMode _mode;
  r.StreamedState selectedColorState = r.StreamedState();
  r.Action<Color> changeColor = r.Action();
  r.Action<Note> saveNote = r.Action();
  r.Action<Note> deleteNote = r.Action();

  NoteScreenWM(NoteArgs args) {
    _note = args.note;
    _mode = args.mode;
    selectedColorState
        .accept(mode == NoteMode.Editing ? _note.color : Note.defaultColor);

    subscribe(changeColor.stream, (color) {
      selectedColorState.accept(color);
    });

    subscribe(saveNote.stream, (Note note) async {
      if (_mode == NoteMode.Adding) {
        await _addNote(note)
            .then((value) => NavigationService.instance.goback());
      } else {
        _note.color = note.color;
        _note.content = note.content;

        await _editNote(_note)
            .then((value) => NavigationService.instance.goback());
      }
    });

    subscribe(deleteNote.stream, (_) => _removeNote());
  }

  get mode => _mode;
  get noteContent => mode == NoteMode.Editing ? _note.content : "";
  get noteColor => selectedColorState.value;

  Future<void> _addNote(Note note) async {
    await NoteStoregeService.insertNote(note);
  }

  Future<void> _removeNote() async {
    await NoteStoregeService.deleteNote(_note)
        .then((value) => NavigationService.instance.goback());
  }

  Future<void> _editNote(Note note) async {
    await NoteStoregeService.updateNote(note);
  }
}

class NotesScreenErrorHandle extends ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint('[News Screen]:${e.toString()}');
  }
}
