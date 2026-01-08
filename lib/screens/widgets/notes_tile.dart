import 'package:flutter/material.dart';
import 'package:notes_app/models/note_model.dart';

import '../note_editor_screen.dart';

class NotesTile extends StatelessWidget {
  final NoteModel note;
  final int index;
  const NotesTile({super.key, required this.note, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: EdgeInsets.all(9),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F000000),
            blurRadius: 23,
            spreadRadius: 3,
            offset: const Offset(0, 0),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            note.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Text(
            note.description.length > 40
                ? note.description.substring(0, 40)
                : note.description,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
