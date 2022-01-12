import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_desktop/providers/reduced_text.dart';
import 'package:hello_desktop/providers/text_case_provider.dart';
import 'package:hello_desktop/utils/text.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  Body({this.focusNode});
  final FocusNode? focusNode;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _controller = TextEditingController();
  // late FocusNode focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  var reducedText = '';

  void _clear() {
    setState(() {
      _controller.clear();
    });
  }

  void _reduce(BuildContext context) {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      showToast('Enter some text!',
          context: context, animDuration: const Duration(milliseconds: 2));

      widget.focusNode?.requestFocus();
      return;
    }

    // setState(() {
    context.read<ReducedTextProvider>().text =
        text.split(RegExp(r'\s+')).map((e) => e[0]).join();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final _textCase = context.watch<TextCaseProvider>().textCase;
    final _textProvider = context.watch<ReducedTextProvider>();

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                focusNode: widget.focusNode,
                autofocus: true,
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter text here',
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onPressed: _clear,
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
                onChanged: (value) {
                  _reduce(context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _reduce(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        "Reduce",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          textBaseline: TextBaseline.ideographic,
                        ),
                      ),
                    ),
                  ),
                  _textProvider.text.isNotEmpty
                      ? TextButton(
                          onPressed: () {
                            _textProvider.text = "";
                          },
                          child: const Text('Clear output'),
                        )
                      : Container(),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                formatText(_textCase, _textProvider.text),
                style: const TextStyle(fontSize: 24, color: Colors.indigo),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
