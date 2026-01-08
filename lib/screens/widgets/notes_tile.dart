import 'package:flutter/material.dart';
import 'package:notes_app/models/note_model.dart';

class NotesTile extends StatelessWidget {
  final NoteModel note;
  final int index;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const NotesTile({
    super.key,
    required this.note,
    required this.index,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onLongPress: () => _showDeleteDialog(context, theme),
      onTap: onEdit,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 18,
                spreadRadius: 1,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              note.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, ThemeData theme) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: theme.dialogBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Delete Note",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            "Are you sure you want to delete this note?",
            style: theme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                onDelete();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
