import 'package:flutter/cupertino.dart';
import 'package:notes_app/models/Note.dart';
import 'package:notes_app/services/api_services.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];
  bool isLoading = true;

  NotesProvider() {
    fetchNotes();
  }
  void sortNotes() {
    notes.sort((a, b) => b.dateadded!.compareTo(a.dateadded!));
  }

  List<Note> searchNotes(String searchQuery) {
    return notes
        .where((element) =>
            element.title!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            element.content!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  void addNote(Note note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiServices.addNote(note);
  }

  void updateNote(Note note) {
    int indexOffNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOffNote] = note;
    sortNotes();
    notifyListeners();
    ApiServices.addNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiServices.deleteNote(note);
  }

  void fetchNotes() async {
    notes = await ApiServices.fetchNotes("manishsharma");
    isLoading = false;
    sortNotes();
    notifyListeners();
  }
}
