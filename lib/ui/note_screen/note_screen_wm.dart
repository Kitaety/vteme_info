import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:relation/relation.dart' as r;
import 'package:vteme_info/common/error_handler.dart';
import 'package:vteme_info/common/widget_model.dart';
import 'package:vteme_info/data/note.dart';
import 'package:vteme_info/main.dart';
import 'package:vteme_info/utils/navigation_service.dart';
import 'package:vteme_info/utils/note_storege_service.dart';
import 'package:vteme_info/utils/notifications_helper.dart';
import 'package:easy_localization/easy_localization.dart';

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
  r.StreamedState<DateTime> dateNotificationState = r.StreamedState();
  r.StreamedState selectedColorState = r.StreamedState();
  r.Action<Color> changeColor = r.Action();
  r.Action<Note> saveNote = r.Action();
  r.Action<Note> deleteNote = r.Action();
  r.Action<DateTime> changeDateNotification = r.Action();

  NoteScreenWM(NoteArgs args) {
    if (args.note != null) {
      _note = args.note;
      getDateTimeNotification(notifsPlugin, _note.id)
          .then((value) => dateNotificationState.accept(value));
    } else {
      _note = Note();
      changeColor.accept(Note.defaultColor);
    }
    _mode = args.mode;
    selectedColorState
        .accept(mode == NoteMode.Editing ? _note.color : Note.defaultColor);

    subscribe(changeColor.stream, (color) {
      selectedColorState.accept(color);
    });

    subscribe(changeDateNotification.stream, (date) {
      dateNotificationState.accept(date);
    });

    subscribe(saveNote.stream, (Note note) async {
      if (_mode == NoteMode.Adding) {
        await _addNote(note).then((value) {
          addNotification(value, note.content);

          NavigationService.instance.goback();
        });
      } else {
        _note.color = note.color;
        _note.content = note.content;

        await _editNote(_note).then((value) {
          cancelNotification(notifsPlugin, _note.id);
          addNotification(_note.id, note.content);
          NavigationService.instance.goback();
        });
      }
    });

    subscribe(deleteNote.stream, (_) => _removeNote());
  }

  NoteMode get mode => _mode;
  String get noteContent => mode == NoteMode.Editing ? _note.content : "";
  get noteColor => selectedColorState.value;
  Note get note => _note;
  DateTime get dateNotifications => dateNotificationState.value;

  Future<int> _addNote(Note note) async {
    return await NoteStoregeService.insertNote(note);
  }

  Future<void> _removeNote() async {
    cancelNotification(notifsPlugin, _note.id);
    await NoteStoregeService.deleteNote(_note)
        .then((value) => NavigationService.instance.goback());
  }

  Future<int> _editNote(Note note) async {
    return await NoteStoregeService.updateNote(note);
  }

  void addNotification(int id, String body) async {
    if (dateNotifications != null) {
      scheduleNotification(
          notifsPlugin: notifsPlugin, //Or whatever you've named it in main.dart
          id: id,
          body: body,
          title: "reminder_notes".tr(),
          scheduledTime:
              dateNotifications); //Or whenever you actually want to trigger it}
    }
  }
}

class NotesScreenErrorHandler extends ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint('[Notes Screen]:${e.toString()}');
  }
}
