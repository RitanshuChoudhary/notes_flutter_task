
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/note_provider.dart';
import 'screens/notes_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NoteProvider(),
      child: const StudentNotesApp(),
    ),
  );
}

class StudentNotesApp extends StatelessWidget {
  const StudentNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Notes',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const NotesListScreen(),
    );
  }
}
