import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_desktop/body.dart';
import 'package:hello_desktop/providers/reduced_text.dart';
import 'package:hello_desktop/providers/text_case_provider.dart';
import 'package:hello_desktop/utils/actions.dart';
import 'package:provider/provider.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DesktopWindow.setMinWindowSize(const Size(400, 600));
  await DesktopWindow.setMaxWindowSize(const Size(400, 600));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TextCaseProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReducedTextProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );

  doWhenWindowReady(() {
    final win = appWindow;
    win.alignment = Alignment.centerLeft;
    // win.minSize = const Size(400, 600);
    // win.size = const Size(400, 600);

    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Text Reducer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FocusNode focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    context.read<ReducedTextProvider>().dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TitleBar(),
          AppBar(
            backgroundColor: Colors.indigoAccent,
            titleTextStyle: GoogleFonts.lato(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            actionsIconTheme: const IconThemeData(color: Colors.white),
            title: Text(widget.title),
            elevation: 0,
            actions: [
              IconButton(
                hoverColor: Colors.transparent,
                // splashColor: Colors.transparent,
                icon: const Icon(Icons.help),
                tooltip: 'About',
                onPressed: () {
                  showHelpDialog(context);
                },
              ),
              IconButton(
                hoverColor: Colors.transparent,
                icon: const Icon(Icons.settings),
                onPressed: () {
                  showSettingsDialog(context);
                },
                tooltip: 'Settings',
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<void>(
              future: context.read<TextCaseProvider>().init(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Body(
                    focusNode: focusNode,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          copy(context, context.read<ReducedTextProvider>().text, focusNode);
        },
        child: const Icon(Icons.copy),
        tooltip: 'Copy to clipboard',
        backgroundColor: Colors.black87,
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(
          colors: WindowButtonColors(iconNormal: Colors.white),
        ),
        CloseWindowButton(
          colors: WindowButtonColors(
              iconNormal: Colors.white, mouseOver: Colors.red),
        ),
      ],
    );
  }
}

class TitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Container(
        color: Colors.indigo,
        child: Row(
          children: [
            Expanded(
              child: MoveWindow(),
            ),
            WindowButtons(),
          ],
        ),
      ),
    );
  }
}
