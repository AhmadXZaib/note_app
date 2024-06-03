import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/model_note.dart';
import '../Model/provider_note_data.dart';
// import 'package:notes_app/models/note_data.dart';
// import 'package:notes_app/models/note.dart';

class EditNoteScreen extends StatelessWidget {
  final Note note;
  final TextEditingController titleController;
  final TextEditingController contentController;

  EditNoteScreen({super.key, required this.note})
      : titleController = TextEditingController(text: note.title),
        contentController = TextEditingController(text: note.content);

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
            )),
        centerTitle: true,
        title: const Text(
          'Edit Note',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: null,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                Provider.of<NoteData>(context, listen: false).editNote(
                    note, titleController.text, contentController.text);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
