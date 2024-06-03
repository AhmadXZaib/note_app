import 'package:flutter/material.dart';
import 'package:note_app/UI/add_note_screen.dart';
import 'package:note_app/UI/note_detail_screen.dart';

import 'package:provider/provider.dart';

import '../Model/provider_note_data.dart';
import '../widgets/floating_action_button.dart';
// import 'package:notes_app/models/note_data.dart';
// import 'package:notes_app/screens/add_note_screen.dart';
// import 'package:notes_app/screens/note_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Notes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 34,
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (query) {
                Provider.of<NoteData>(context, listen: false)
                    .filterNotes(query);
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: Consumer<NoteData>(
              builder: (context, noteData, child) {
                return ListView.builder(
                  itemCount: noteData.notes.length,
                  itemBuilder: (context, index) {
                    final note = noteData.notes[index];
                    return Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text(note.title),
                        subtitle: Text(note.content),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NoteDetailScreen(note: note),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: GradientFloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNoteScreen()),
          );
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
