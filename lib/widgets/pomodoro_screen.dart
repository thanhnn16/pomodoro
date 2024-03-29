import 'package:flutter/material.dart';
import 'package:pomodoro/services/timer_controller.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  final TimerController _timerController = TimerController();
  String _selectedButton = 'pomodoro';

  // @override
  // void initState() {
  //   super.initState();
  //   // Get the default values from TimerController
  //   _timerController.getDefaultValues().then((durations) {
  //     setState(() {
  //       _timerController.configureDurations(
  //         durations.pomodoroDuration,
  //         durations.shortBreakDuration,
  //         durations.longBreakDuration,
  //       );
  //     });
  //   });
  // }

  void _startTimer() {
    _timerController.startTimer(25);
  }

  void _resetTimer() {
    _timerController.resetTimer();
  }

  void _configureDurations() {
    _timerController.configureDurations(
      5,
      5,
      10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('../assets/images/bg.jpg'),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
          color: Colors.black,
        ),
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
                  _buildButton('pomodoro'),
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
              Text(
                // '${_timerController.getCurrentDuration()}:00',
                '25:00',
                style: const TextStyle(
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
    bool isSelected = _selectedButton == text;
    return ElevatedButton(
      onPressed: () {
        // TODO: Implement button functionality
        // Implement the functionality for the "pomodoro", "short break", and
        // "long break" buttons to switch between the different modes and
        // update the timer accordingly.
        setState(() {
          _selectedButton = text;
          switch (text) {
            case 'pomodoro':
              _timerController.configureDurations(25, 5, 15);
              break;
            case 'short break':
              _timerController.configureDurations(5, 5, 15);
              break;
            case 'long break':
              _timerController.configureDurations(15, 5, 15);
              break;
          }
        });
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
