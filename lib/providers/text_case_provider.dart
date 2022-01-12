import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hello_desktop/enums/text_case.dart';
import 'package:shared_preferences_windows/shared_preferences_windows.dart';

class TextCaseProvider with ChangeNotifier {
  TextCase? _textCase = TextCase.original;

  TextCase? get textCase => _textCase;

  void changeCase(TextCase? value) async {
    _textCase = value;
    await saveSettings();
    notifyListeners();
  }

  Future<void> saveSettings() async {
    final prefs = SharedPreferencesWindows.instance;
    await prefs.setValue('Int', 'textCase', toInt());
  }

  Future<void> loadSettings() async {
    final sharedPrefsInstance = SharedPreferencesWindows.instance;
    final prefs = await sharedPrefsInstance.getAll();
    final int caseInt = prefs['textCase'] as int? ?? 0;
    _textCase = fromInt(caseInt);
  }

  Future<void> init() async {
    await loadSettings();
  }

  int toInt() {
    switch (textCase) {
      case TextCase.original:
        return 0;
      case TextCase.uppercase:
        return 1;
      case TextCase.lowercase:
        return 2;
      default:
        return 0;
    }
  }

  TextCase fromInt(int value) {
    switch (value) {
      case 0:
        return TextCase.original;
      case 1:
        return TextCase.uppercase;
      case 2:
        return TextCase.lowercase;
      default:
        return TextCase.original;
    }
  }
}
