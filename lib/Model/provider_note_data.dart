import 'package:flutter/foundation.dart';
import 'package:note_app/Model/model_note.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NoteData extends ChangeNotifier {
  List<Note> _notes = [];
  List<Note> _filteredNotes = [];

  List<Note> get notes => _filteredNotes.isEmpty ? _notes : _filteredNotes;

  NoteData() {
    loadNotes();
  }

  void addNote(String title, String content) {
    final note = Note(
      title: title,
      content: content,
    );
    _notes.add(note);
    saveNotes();
    notifyListeners();
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    saveNotes();
    notifyListeners();
  }

  void editNote(Note oldNote, String newTitle, String newContent) {
    final noteIndex = _notes.indexOf(oldNote);
    if (noteIndex != -1) {
      _notes[noteIndex] = Note(
        title: newTitle,
        content: newContent,
      );
      saveNotes();
      notifyListeners();
    }
  }

  void saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> noteStrings = _notes
        .map((note) =>
            json.encode({'title': note.title, 'content': note.content}))
        .toList();
    await prefs.setStringList('notes', noteStrings);
  }

  void loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? noteStrings = prefs.getStringList('notes');
    if (noteStrings != null) {
      _notes = noteStrings.map((noteString) {
        Map<String, dynamic> noteMap = json.decode(noteString);
        return Note(
          title: noteMap['title'],
          content: noteMap['content'],
        );
      }).toList();
      notifyListeners();
    }
  }

  void filterNotes(String query) {
    if (query.isEmpty) {
      _filteredNotes = [];
    } else {
      _filteredNotes = _notes
          .where((note) =>
              note.title.toLowerCase().contains(query.toLowerCase()) ||
              note.content.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void deleteAllNotes() {
    _notes.clear();
    saveNotes();
    notifyListeners();
  }
}
