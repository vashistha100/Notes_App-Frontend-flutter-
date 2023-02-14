import 'package:flutter/cupertino.dart';
import 'package:notes_app/models/Note.dart';
import 'package:notes_app/services/api_services.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];

  NotesProvider() {
    fetchNotes();
  }

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
    ApiServices.addNote(note);
  }

  void updateNote(Note note) {
    int indexOffNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOffNote] = note;
    notifyListeners();
    ApiServices.addNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    notifyListeners();
    ApiServices.deleteNote(note);
  }

  void fetchNotes()  async{
    notes = await ApiServices.fetchNotes("manishsharma");
    notifyListeners();
  }
}
