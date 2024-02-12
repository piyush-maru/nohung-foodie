import 'package:flutter/material.dart';

class VoiceSearchProvider extends ChangeNotifier {
  bool _isListening = false;
  bool get getIsListening => _isListening;
  String _words = "";
  String get getWords => _words;
  void updateIsListening() {
    _isListening = !_isListening;
    notifyListeners();
  }

  void updateWords(String newWords) {
    _words = newWords;
    notifyListeners();
  }
}
