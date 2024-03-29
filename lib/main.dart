import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/pomodoro_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const PomodoroApp());
}

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.playpenSansTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
        dialogBackgroundColor: Colors.white,
      ),
      home: const PomodoroScreen(),
    );
  }
}
