import 'package:flutter/material.dart';
import 'package:note_app/UI/edit_note_screen.dart';
// import 'package:notes_app/models/note.dart';
// import 'package:notes_app/screens/edit_note_screen.dart';
import 'package:provider/provider.dart';
// import 'package:notes_app/models/note_data.dart';
import 'package:share/share.dart';

import '../Model/model_note.dart';
import '../Model/provider_note_data.dart';

class NoteDetailScreen extends StatelessWidget {
  final Note note;

  const NoteDetailScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 25,
          ),
        ),
        title: Text(
          note.title,
          style: const TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {
              Share.share(note.content, subject: note.title);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditNoteScreen(note: note),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              _showDeleteConfirmationDialog(context, note);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(note.content),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Provider.of<NoteData>(context, listen: false).deleteNote(note);
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close the NoteDetailScreen
              },
            ),
          ],
        );
      },
    );
  }
}
