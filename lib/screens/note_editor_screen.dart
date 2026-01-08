import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note_model.dart';
import '../providers/note_provider.dart';

class NoteEditorScreen extends StatefulWidget {
  final NoteModel? note;
  final int? index;

  const NoteEditorScreen({super.key, this.note, this.index});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final _key = GlobalKey<FormState>();
  late TextEditingController titleCtrl;
  late TextEditingController descCtrl;

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(text: widget.note?.title ?? "");
    descCtrl = TextEditingController(text: widget.note?.description ?? "");
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_key.currentState!.validate()) {
      final newNote = NoteModel(
        title: titleCtrl.text.trim(),
        description: descCtrl.text.trim(),
      );

      final provider = context.read<NoteProvider>();

      if (widget.index == null) {
        provider.add(newNote);
      } else {
        provider.update(widget.index!, newNote);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.index == null ? 'Add Note' : 'Edit Note',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _save,
            icon: const Icon(Icons.check, color: Colors.white),
          ),
        ],
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: titleCtrl,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? "Title required" : null,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: TextFormField(
                  controller: descCtrl,
                  decoration: const InputDecoration(labelText: "Description"),
                  expands: true,
                  maxLines: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
