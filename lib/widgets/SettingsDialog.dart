import 'package:flutter/material.dart';
import 'package:hello_desktop/enums/text_case.dart';
import 'package:hello_desktop/providers/text_case_provider.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatefulWidget {
  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  

  @override
  Widget build(BuildContext context) {
    final _textCase = context.watch<TextCaseProvider>().textCase;

    return SimpleDialog(
      title: const Text("Choose text case:"),
      children: [
        RadioListTile<TextCase>(
          value: TextCase.original,
          title: const Text('Original'),
          groupValue: _textCase,
          onChanged: (value) {
            context.read<TextCaseProvider>().changeCase(value);
          },
        ),
        RadioListTile<TextCase>(
          value: TextCase.uppercase,
          groupValue: _textCase,
          title: const Text('UPPERCASE'),
          onChanged: (value) {
            context.read<TextCaseProvider>().changeCase(value);
          },
        ),
        RadioListTile<TextCase>(
          value: TextCase.lowercase,
          title: const Text('lowercase'),
          groupValue: _textCase,
          onChanged: (value) {
            context.read<TextCaseProvider>().changeCase(value);
          },
        ),
      ],
    );
  }
}
