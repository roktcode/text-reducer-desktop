import 'package:hello_desktop/enums/text_case.dart';

String formatText(TextCase? textCase, String text) {
  switch (textCase) {
    case TextCase.original:
      return text;
    case TextCase.uppercase:
      return text.toUpperCase();
    case TextCase.lowercase:
      return text.toLowerCase();
    default:
      return text;
  }
}
