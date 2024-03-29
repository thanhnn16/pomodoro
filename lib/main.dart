// import 'package:flutter/material.dart';
// import 'package:pomodoro/widgets/pomodoro_screen.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// void main() {
//   runApp(const PomodoroApp());
// }
//
// class PomodoroApp extends StatelessWidget {
//   const PomodoroApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pomodoro Timer',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         textTheme: GoogleFonts.playpenSansTextTheme(
//           Theme.of(context).textTheme,
//         ),
//       ),
//       home: const PomodoroScreen(),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(PomodoroApp());
}

class PomodoroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PomodoroScreen(),
    );
  }
}

class PomodoroScreen extends StatefulWidget {
  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  // These are suggested initial values for the Pomodoro timer.
  bool _isTimerRunning = false;

  int _pomodoroDuration = 25;
  int _shortBreakDuration = 5;
  int _longBreakDuration = 10;
  String _currentMode = 'pomodoro';

  int _remainingTime = 0;

  bool _isWorking = true;

  int _completedCycles = 0;
  int _cyclesUntilLongBreak = 4;

  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _remainingTime = _pomodoroDuration * 60;
  }

  void _initializeNotifications() {
    // TODO: Initialize FlutterLocalNotificationsPlugin
  }

  Timer? _timer;

  void _startOrPauseTimer() {
    if (_isTimerRunning) {
      if (_timer != null) {
        _timer!.cancel();
        _timer = null;
      }
    } else {
      _startTimer();
    }

    setState(() {
      _isTimerRunning = !_isTimerRunning;
    });
  }

  void _startTimer() {
    // TODO: Implement the logic to start the timer
    // Start the timer based on the selected mode (Pomodoro, Short Break, or Long Break).
    // Use a timer or a periodic function to update the remaining time and trigger
    // the appropriate actions when each interval is completed.
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer!.cancel();
        _timer = null;
        _isTimerRunning = false;
        _isWorking = _currentMode == 'pomodoro';

        switch (_currentMode) {
          case 'pomodoro':
            _remainingTime = _pomodoroDuration * 60;
            break;
          case 'short break':
            _remainingTime = _shortBreakDuration * 60;
            break;
          case 'long break':
            _remainingTime = _longBreakDuration * 60;
            break;
        }

        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          setState(() {
            if (_remainingTime > 0) {
              _remainingTime--;
            } else {
              timer.cancel();
              _showNotification(
                _isWorking ? 'Pomodoro Finished' : 'Break Finished',
                _isWorking ? 'Time for a break!' : 'Time to get back to work!',
              );

              _isWorking = !_isWorking;

              if (_isWorking) {
                _completedCycles++;
                if (_completedCycles >= _cyclesUntilLongBreak) {
                  _completedCycles = 0;
                }
              }

              _startTimer();
            }
          });
        });

        setState(() {
          _isTimerRunning = true;
        });
      }
    });
  }

  void _resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }

    setState(() {
      _isWorking = true;
      _completedCycles = 0;
      _isTimerRunning = false;

      switch (_currentMode) {
        case 'pomodoro':
          _remainingTime = _pomodoroDuration * 60;
          break;
        case 'short break':
          _remainingTime = _shortBreakDuration * 60;
          break;
        case 'long break':
          _remainingTime = _longBreakDuration * 60;
          break;
      }
    });
  }

  void _configureDurations() {
    // TODO: Implement the logic to show dialog to configure durations
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Configure Durations'),
          content: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() {
                    _pomodoroDuration = int.parse(value);
                  });
                },
                decoration: InputDecoration(
                  labelText: "Pomodoro Duration (minutes)",
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _shortBreakDuration = int.parse(value);
                  });
                },
                decoration: InputDecoration(
                  labelText: "Short Break Duration (minutes)",
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _longBreakDuration = int.parse(value);
                  });
                },
                decoration: InputDecoration(
                  labelText: "Long Break Duration (minutes)",
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
        title: Text('Pomodoro Timer'),
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
                  _buildButton('pomodoro'),
                  SizedBox(width: 10),
                  // When user taps Short Break, it should be selected and short break counter should start.
                  //
                  // When counter reaches 0, a notification should be shown,
                  // and pomodoro counter should start again.
                  _buildButton('short break'),
                  // When user taps Long Break, it should be selected and long break counter should start.
                  // When counter reaches 0, a notification should be shown,
                  // and pomodoro counter should start again.
                  SizedBox(width: 10),
                  _buildButton('long break'),
                ],
              ),
              SizedBox(height: 20),
              Text(
                _formatTime(_remainingTime),
                style: TextStyle(
                  fontSize: 80,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _startOrPauseTimer,
                child: Text(_isTimerRunning ? 'pause' : 'start'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _resetTimer,
                    icon: Icon(Icons.refresh),
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: _configureDurations,
                    icon: Icon(Icons.settings),
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

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Widget _buildButton(String text, {bool isSelected = false}) {
    bool isSelected = _currentMode == text;

    return ElevatedButton(
      onPressed: () {
        // TODO: Implement button functionality
        // Implement the functionality for the "pomodoro", "short break", and
        // "long break" buttons to switch between the different modes and
        // update the timer accordingly.
        setState(() {
          _currentMode = text;
          _startTimer();
        });
      },
      child: Text(
        text,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.red : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
