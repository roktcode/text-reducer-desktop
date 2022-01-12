import 'package:flutter/foundation.dart';

class ReducedTextProvider with ChangeNotifier {
  var _text = "";

  String get text => _text;

  set text(String value) {
    _text = value;
    notifyListeners();
  }
}
