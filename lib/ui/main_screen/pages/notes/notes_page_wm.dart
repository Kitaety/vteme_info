import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:relation/relation.dart' as r;
import 'package:vteme_info/common/error_handler.dart';
import 'package:vteme_info/common/widget_model.dart';
import 'package:vteme_info/data/note.dart';
import 'package:vteme_info/ui/note_screen/note_screen_wm.dart';
import 'package:vteme_info/utils/navigation_service.dart';
import 'package:vteme_info/utils/note_storege_service.dart';

///класс widget model страницы с заметками
///свойства
///* noteState - EntityStreamedState, список заметок
///* tapOnNote - Action, нажатие на заметку
///* tapOnAddNote - Action, нажатие на кнопку добавить заметку
///
///методы
///* _loadNotesList - загрузка списка заметок
///* onTapNoteWidget - обработчик нажатия на виджет заметки
///* onTapAddNote - обработчик нажатия на кнопку добавить заметку

class NotesPageWM extends WidgetModel {
  final noteState = r.EntityStreamedState<List<Note>>()..loading();
  final tapOnNote = r.Action();
  final tapOnAddNote = r.Action();
  final refreshListNotes = r.Action();

  NotesPageWM() : super(errorHandler: NotesPageErrorHandle()) {
    subscribe(tapOnNote.stream, (article) => onTapNoteWidget(article));
    subscribe(tapOnAddNote.stream, (_) => onTapAddNote());
    subscribe(refreshListNotes.stream, (_) => loadNotesList());
  }

  Future<void> loadNotesList() async {
    noteState.loading();
    try {
      List<Map<String, dynamic>> n = await NoteStoregeService.getListNote();
      List<Note> notes = [];
      for (dynamic item in n) {
        notes.add(Note(
          id: item['id'],
          content: item['content'],
          color: toColor(item['color']),
        ));

        Colors.purpleAccent.value.toRadixString(16);
      }
      noteState.content(notes);
    } on Exception catch (e) {
      noteState.error();
      handleError(e);
    }
  }

  Future<void> onTapNoteWidget(Note note) async {
    await NavigationService.instance
        .navigateTo("screen_note", arguments: NoteArgs(NoteMode.Editing, note));
  }

  Future<void> onTapAddNote() async {
    await NavigationService.instance
        .navigateTo("screen_note", arguments: NoteArgs(NoteMode.Adding, null));
  }
}

toColor(String text) {
  var hexColor = text.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }
}

class NotesPageErrorHandle extends ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint('[Notes Page]:${e.toString()}');
  }
}
