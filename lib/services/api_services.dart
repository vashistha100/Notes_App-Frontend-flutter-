import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:notes_app/models/Note.dart';

class ApiServices {
  static String baseUrl =
      "https://backend-production-524d.up.railway.app/notes";

  static Future<void> addNote(Note note) async {
    Uri urirequest = Uri.parse(baseUrl + "/add");

    var response = await http.post(urirequest, body: note.toMap());

    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<void> deleteNote(Note note) async {
    Uri urirequest = Uri.parse(baseUrl + "/delete");

    var response = await http.post(urirequest, body: note.toMap());

    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<List<Note>> fetchNotes(String userid) async {
    Uri urirequest = Uri.parse(baseUrl + "/list");

    var response = await http.post(urirequest, body: {userid: userid});

    var decoded = jsonDecode(response.body);
    print(decoded.toString());

    List<Note> notes = [];

    for (var notemap in decoded) {
      Note newNote = Note.fromMap(notemap);
      notes.add(newNote);
    }

    return notes;
  }
}
