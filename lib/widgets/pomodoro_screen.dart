import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PomodoroScreen(),
    );
  }
}

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  // These are suggested initial values for the Pomodoro timer.
  final int _pomodoroDuration = 25;
  final int _shortBreakDuration = 5;
  final int _longBreakDuration = 10;

  final int _remainingTime = 0;

  final bool _isWorking = true;

  final int _completedCycles = 0;
  final int _cyclesUntilLongBreak = 4;

  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    // TODO: Initialize FlutterLocalNotificationsPlugin
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  void _startTimer() {
    // TODO: Implement the logic to start the timer
    // Start the timer based on the selected mode (Pomodoro, Short Break, or Long Break).
    // Use a timer or a periodic function to update the remaining time and trigger
    // the appropriate actions when each interval is completed.
    final pomodoroTimer = PomodoroTimer();
  }

  void _resetTimer() {
    // TODO: Implement the logic to reset the timer
    // Reset the timer to its initial state, clearing any ongoing intervals and
    // resetting the completed cycles count.
  }

  void _configureDurations() {
    // TODO: Implement the logic to show dialog to configure durations
  }

  void _showNotification(String title, String body) {
    // TODO: Implement the logic to show a local notification
    // Display a local notification when each interval is completed, informing
    // the user about the end of the Pomodoro, Short Break, or Long Break.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro Timer'),
      ),
      body: Container(
        color: Colors.blue.shade200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Pomodoro, Short Break, and Long Break buttons
                  // ----------------------------------------------
                  // When user taps Pomodoro, it should be selected and pomodoro
                  // counter should start.
                  //
                  // When counter reaches 0, a notification should be shown,
                  //
                  // If completed cycles is less than cycles until long break,
                  // short break counter should start.
                  // Otherwise, long break counter should start.
                  _buildButton('pomodoro', isSelected: true),
                  const SizedBox(width: 10),
                  // When user taps Short Break, it should be selected and short break counter should start.
                  //
                  // When counter reaches 0, a notification should be shown,
                  // and pomodoro counter should start again.
                  _buildButton('short break'),
                  // When user taps Long Break, it should be selected and long break counter should start.
                  // When counter reaches 0, a notification should be shown,
                  // and pomodoro counter should start again.
                  const SizedBox(width: 10),
                  _buildButton('long break'),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                '25:00',
                style: TextStyle(
                  fontSize: 80,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _startTimer,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('start'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _resetTimer,
                    icon: const Icon(Icons.refresh),
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: _configureDurations,
                    icon: const Icon(Icons.settings),
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, {bool isSelected = false}) {
    return ElevatedButton(
      onPressed: () {
        // TODO: Implement button functionality
        // Implement the functionality for the "pomodoro", "short break", and
        // "long break" buttons to switch between the different modes and
        // update the timer accordingly.
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.red : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}
