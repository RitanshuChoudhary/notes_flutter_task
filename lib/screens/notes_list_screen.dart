import 'package:flutter/material.dart';
import 'package:notes_app/screens/widgets/notes_tile.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../utils/theme_provider.dart';
import 'note_editor_screen.dart';

class NotesListScreen extends StatelessWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NoteProvider>();
    final notes = provider.notes;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Consumer<ThemeProvider>(
            builder: (_, provider, __) {
              return Switch(
                value: provider.isDark,
                onChanged: (_) => provider.toggleTheme(),
              );
            },
          ),
        ],
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.teal,
      ),
      body: notes.isEmpty
          ? const Center(child: Text("No notes yet"))
          : Padding(
              padding: EdgeInsetsGeometry.only(top: 12),

              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 12),
                    child: NotesTile(
                      note: note,
                      index: index,
                      onDelete: () {
                        provider.delete(index);
                      },
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                NoteEditorScreen(note: note, index: index),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NoteEditorScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
