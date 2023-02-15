import 'package:flutter/material.dart';
import 'package:notes_app/models/Note.dart';
import 'package:notes_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNote extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewNote({super.key, required this.isUpdate, this.note});

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  FocusNode notefocus = FocusNode();

  @override
  void initState() {
    if (widget.isUpdate == true) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }

    super.initState();
  }

  void addNewNote() {
    Note newNote = Note(
        id: const Uuid().v1(),
        userid: "manishsharma",
        title: titleController.text,
        content: contentController.text,
        dateadded: DateTime.now());
    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updateNewNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    widget.note!.dateadded = DateTime.now();

    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                if (widget.isUpdate == true) {
                  updateNewNote();
                } else {
                  addNewNote();
                }
              },
              icon: const Icon(Icons.check),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                autofocus: (widget.isUpdate == true) ? false : true,
                onSubmitted: (val) {
                  if (val != "") {
                    notefocus.requestFocus();
                  }
                },
                style: const TextStyle(fontSize: 28),
                decoration: const InputDecoration(
                    hintText: "Title", border: InputBorder.none),
              ),
              Expanded(
                child: TextField(
                  controller: contentController,
                  maxLines: null,
                  focusNode: notefocus,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                      hintText: "Content", border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
