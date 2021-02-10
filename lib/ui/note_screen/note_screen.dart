import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:relation/relation.dart';
import 'package:test_app/data/note.dart';
import 'package:test_app/utils/navigation_service.dart';

import 'note_screen_wm.dart';

class NoteScreen extends StatefulWidget {
  NoteScreenWM wm;

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  TextEditingController _titleController = TextEditingController(text: "");
  TextEditingController _contentController = TextEditingController();

  bool isEnableButton = false;
  String _title;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.wm = NoteScreenWM(ModalRoute.of(context).settings.arguments);

    _titleController = TextEditingController(
      text: widget.wm.noteTitle,
    );
    _contentController = TextEditingController(
      text: widget.wm.noteContent,
    );
    _title = widget.wm.mode == NoteMode.Adding
        ? "Добавить заметку"
        : "Изменить заметку";

    isEnableButton = _titleController.value.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _title,
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).accentColor,
        ),
        actions: widget.wm.mode == NoteMode.Editing
            ? [
                IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                  ),
                  iconSize: 25,
                  tooltip: "Delete note",
                  onPressed: () {
                    _showDeleteDialoge();
                  },
                )
              ]
            : null,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              onChanged: (text) {
                setState(() {
                  isEnableButton = text.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                hintText: 'Заголовок заметки',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: Theme.of(context).accentColor,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: Theme.of(context).accentColor,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: Theme.of(context).accentColor,
                    width: 1,
                  ),
                ),
              ),
              maxLines: 1,
            ),
            Container(
              height: 16,
            ),
            Expanded(
              flex: 10,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).accentColor,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Содержание заметки',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAlarmCheckButton(),
                  _builColorSelectButton(),
                ],
              ),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: FlatButton(
                color: Theme.of(context).accentColor,
                disabledColor: Colors.grey[400],
                onPressed: !isEnableButton
                    ? null
                    : () {
                        widget.wm.saveNote(Note(
                          color: widget.wm.noteColor,
                          title: _titleController.value.text,
                          content: _contentController.value.text,
                        ));
                      },
                child: Text(
                  "Сохранить",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _builColorSelectButton() {
    return InkWell(
      onTap: () async {
        _showColorPicker(context, widget.wm.noteColor).then((color) => {
              if (color != null) {widget.wm.changeColor.accept(color)}
            });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Theme.of(context).accentColor),
        ),
        width: 70,
        height: 38,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.palette_outlined,
              color: Theme.of(context).accentColor,
            ),
            StreamedStateBuilder(
                streamedState: widget.wm.selectedColorState,
                builder: (context, color) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: color,
                    ),
                    height: 20,
                    width: 20,
                  );
                }),
          ],
        ),
      ),
    );
  }

  bool a = true;
  //TODO доделать включение/выключение напоминания
  Widget _buildAlarmCheckButton() {
    return InkWell(
      onTap: () {
        setState(() {
          a = !a;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Theme.of(context).accentColor),
        ),
        width: 200,
        height: 38,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.notifications_active_outlined,
              color: Theme.of(context).accentColor,
            ),
            SizedBox(
                width: 120,
                child: a ? Text("Не напоминать") : Text("03-02-2021 16:53")),
          ],
        ),
      ),
    );
  }

  Future<Color> _showColorPicker(context, Color selectedColor) {
    Color _color = selectedColor;
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(8),
            title: Text("Выбор цвета"),
            content: Container(
              height: 250,
              child: MaterialColorPicker(
                allowShades: false,
                colors: accentColors,
                selectedColor: _color,
                onMainColorChange: (color) => setState(() {
                  _color = color;
                }),
              ),
            ),
            actions: [
              FlatButton(
                child: Text(
                  "ОТМЕНА",
                ),
                onPressed: NavigationService.instance.goback,
              ),
              FlatButton(
                child: Text("ПОДТВЕРДИТЬ"),
                onPressed: () {
                  NavigationService.instance.goback(results: _color);
                },
              )
            ],
          );
        });
  }

  void _showDeleteDialoge() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Удаление заметки"),
              content: Text("Вы точно хотите удалить данную заметку?"),
              actions: [
                FlatButton(
                  child: Text("Подтвердить"),
                  onPressed: () {
                    NavigationService.instance.goback();
                    widget.wm.deleteNote();
                  },
                ),
                FlatButton(
                  child: Text("Отмена"),
                  onPressed: () {
                    NavigationService.instance.goback();
                  },
                ),
              ],
            ));
  }
}
