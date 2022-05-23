import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamic_plus/screens/doa_screen.dart';
import 'package:islamic_plus/screens/main_screen.dart';
import 'package:islamic_plus/screens/quran_screen.dart';
import 'package:islamic_plus/themes/islamic_theme.dart';

void main() {
  runApp(const IslamicApp());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}

class IslamicApp extends StatelessWidget {
  const IslamicApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Islamic Plus',
      theme: IslamicTheme.whiteTheme,
      initialRoute: "/",
      routes: {
        "/": (context) => const MainMenuScreen(),
        "/quran": (context) => const QuranScreen(),
        "/doa": (context) => const DoaScreen(),
      },
    );
  }
}
