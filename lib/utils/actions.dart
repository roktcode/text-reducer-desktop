import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_desktop/providers/text_case_provider.dart';
import 'package:hello_desktop/utils/text.dart';
import 'package:hello_desktop/widgets/SettingsDialog.dart';
import 'package:provider/provider.dart';

void copy(BuildContext context, String text, FocusNode focusNode) {
  if (text.isEmpty) {
    showToast('Enter some text!',
        context: context, animDuration: const Duration(milliseconds: 2));

    focusNode.requestFocus();
  } else {
    final textCase = context.read<TextCaseProvider>().textCase;
    FlutterClipboard.copy(formatText(textCase, text));

    // show toast notification
    showToast('Copied!',
        context: context,
        animDuration: const Duration(milliseconds: 2),
        backgroundColor: Colors.black87);
  }
}

showSettingsDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return SettingsDialog();
    },
  );
}

showHelpDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("About Text Reducer v1"),
        content: Text(
          'This app is aimed to take a piece of text, then convert it to the first letter of every word.\n\nFor example, hello should give h, Hello World should give HW, and so on.',
          style: GoogleFonts.lato(),
        ),
      );
    },
  );
}
