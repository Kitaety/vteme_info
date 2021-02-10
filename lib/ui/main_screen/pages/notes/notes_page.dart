import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:relation/relation.dart';
import 'package:test_app/data/note.dart';
import 'package:test_app/ui/main_screen/pages/notes/notes_page_wm.dart';

///NotesPage - страница "Заметки"
class NotesPage extends StatefulWidget {
  NotesPageWM wm = NotesPageWM();

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    widget.wm.loadNotesList();
    return Scaffold(
      body: EntityStateBuilder(
        streamedState: widget.wm.noteState,
        child: (context, List<Note> data) => StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: data.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () async {
              await widget.wm.onTapNoteWidget(data[index]);
              await widget.wm.refreshListNotes();
            },
            child: _NoteTile(data[index], index.isEven),
          ),
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(2, index.isEven ? 2 : 1),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await widget.wm.onTapAddNote();
          await widget.wm.refreshListNotes();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

/// _NoteTile - виджет карточки заметки на странице "Заметки"
class _NoteTile extends StatelessWidget {
  final Note note;
  final bool isEven;

  _NoteTile(this.note, this.isEven);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: note.color,
                boxShadow: [
                  BoxShadow(offset: Offset(0.0, 0.25)),
                ]),
            child: Text(
              note.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              note.content,
              overflow: TextOverflow.ellipsis,
              maxLines: isEven ? 8 : 2,
            ),
          ),
        ],
      ),
    );
  }
}
