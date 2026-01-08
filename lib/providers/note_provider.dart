import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NoteProvider extends ChangeNotifier {
  final List<NoteModel> _notes = [];

  List<NoteModel> get notes => List.unmodifiable(_notes);

  void add(NoteModel note) {
    _notes.add(note);
    notifyListeners();
  }

  void update(int index, NoteModel note) {
    _notes[index] = note;
    notifyListeners();
  }

  void delete(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }
}
