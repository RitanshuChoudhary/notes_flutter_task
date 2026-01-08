import 'package:flutter/material.dart';
import 'package:notes_app/screens/widgets/common_textfield.dart';
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
      floatingActionButton: _button(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          widget.index == null ? 'Add Note' : 'Edit Note',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CommonTextfield(
                controller: titleCtrl,
                hintText: "Enter title",
                title: "Title",
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? "Title is required"
                    : null,
              ),
              const SizedBox(height: 12),
              CommonTextfield(
                controller: descCtrl,
                hintText: "Enter description",
                title: "Description",
                maxLines: 10,
                minLines: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button() {
    return InkWell(
      onTap: _save,
      child: Container(
        margin: EdgeInsets.only(bottom: 20, left: 16, right: 16),
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          widget.index == null ? 'Add' : 'Edit',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
