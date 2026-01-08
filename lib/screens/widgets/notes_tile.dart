import 'package:flutter/material.dart';
import 'package:notes_app/models/note_model.dart';

class NotesTile extends StatelessWidget {
  final NoteModel notes;
  const NotesTile({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(boxShadow: [BoxShadow()]),
    );
  }
}
