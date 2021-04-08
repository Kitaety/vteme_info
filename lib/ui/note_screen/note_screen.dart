import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:intl/intl.dart';
import 'package:relation/relation.dart';
import 'package:vteme_info/data/note.dart';
import 'package:vteme_info/utils/navigation_service.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'note_screen_wm.dart';
import 'package:easy_localization/easy_localization.dart';

class NoteScreen extends StatefulWidget {
  NoteScreenWM wm;

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  TextEditingController _contentController = TextEditingController();

  bool isEnableButton = false;
  String _title;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.wm = NoteScreenWM(ModalRoute.of(context).settings.arguments);

    _contentController = TextEditingController(
      text: widget.wm.noteContent,
    );
    _title =
        widget.wm.mode == NoteMode.Adding ? "note_add".tr() : "note_edit".tr();

    isEnableButton = _contentController.value.text.isNotEmpty;
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
                  iconSize: ResponsiveFlutter.of(context).scale(25),
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
                    hintText: 'note_content'.tr(),
                    border: InputBorder.none,
                  ),
                  onChanged: (text) {
                    setState(() {
                      isEnableButton = text.isNotEmpty;
                    });
                  },
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
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).accentColor),
                ),
                onPressed: !isEnableButton
                    ? null
                    : () {
                        widget.wm.saveNote(Note(
                          color: widget.wm.noteColor,
                          content: _contentController.value.text,
                        ));
                      },
                child: Text(
                  "save".tr(),
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
  Widget _buildAlarmCheckButton() {
    return InkWell(
      onTap: () {
        DatePicker.showDateTimePicker(context,
            showTitleActions: true,
            minTime: DateTime.now(),
            maxTime: DateTime(9999, 1, 1), onChanged: (date) {
          print('change $date');
        }, onConfirm: (date) {
          widget.wm.changeDateNotification(date);
          print('confirm $date');
        }, currentTime: DateTime.now(), locale: LocaleType.ru);
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
            StreamedStateBuilder<DateTime>(
                streamedState: widget.wm.dateNotificationState,
                builder: (context, date) {
                  return SizedBox(
                      width: 120,
                      child: date == null
                          ? Text("remind".tr())
                          : Text(DateFormat("dd-MM-yyyy HH:mm").format(date)));
                }),
          ],
        ),
      ),
    );
  }

  Future<Color> _showColorPicker(context, Color selectedColor) {
    Color _color = selectedColor;
    print("debug");
    return showDialog<Color>(
        context: context,
        builder: (_) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(8),
            title: Text("color_selection".tr()),
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
              TextButton(
                onPressed: NavigationService.instance.goback,
                child: Text(
                  "cancel".tr(),
                ),
              ),
              TextButton(
                onPressed: () =>
                    NavigationService.instance.goback(results: _color),
                child: Text(
                  "ok".tr(),
                ),
              ),
            ],
          );
        });
  }

  void _showDeleteDialoge() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("note_delete".tr()),
              content: Text("note_delete_q".tr()),
              actions: [
                TextButton(
                  onPressed: () {
                    NavigationService.instance.goback();
                    widget.wm.deleteNote();
                  },
                  child: Text(
                    "ok".tr(),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    NavigationService.instance.goback();
                  },
                  child: Text(
                    "cancel".tr(),
                  ),
                ),
              ],
            ));
  }
}
