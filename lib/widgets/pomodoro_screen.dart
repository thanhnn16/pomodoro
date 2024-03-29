import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import '../services/notifications.dart';
import 'configurator.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});
  @override
  PomodoroScreenState createState() => PomodoroScreenState();
}

class PomodoroScreenState extends State<PomodoroScreen> {
  bool _isTimerRunning = false;

  int _pomodoroDuration = 25;
  int _shortBreakDuration = 5;
  int _longBreakDuration = 10;
  String _currentMode = 'pomodoro';

  int _remainingTime = 0;

  bool _isWorking = true;

  int _completedCycles = 0;
  final int _cyclesUntilLongBreak = 4;

  late Notifications _notifications;

  late FlutterSoundPlayer? _soundPlayer;

  String _backgroundImage = 'assets/images/bg_1.jpg';
  String _notificationSound = 'assets/sounds/bell.mp3';

  @override
  void initState() {
    super.initState();
    _soundPlayer = FlutterSoundPlayer();
    _initializePlayer();
    _notifications = Notifications();
    if (kDebugMode) {
      print('Notification plugin has been initialized');
      print('Player has been initialized');
    }
    _remainingTime = _pomodoroDuration * 60;
  }

  Timer? _timer;

  int _getRemainingTime(String mode) {
    switch (mode) {
      case 'pomodoro':
        return _pomodoroDuration * 60;
      case 'short break':
        return _shortBreakDuration * 60;
      case 'long break':
        return _longBreakDuration * 60;
      default:
        return 0;
    }
  }

  Future<void> _showNotification(String title, String body) async {
    await _notifications.showNotification(title, body);
  }

  void _startTimer() {
    if (_isTimerRunning) {
      if (_timer != null) {
        _timer!.cancel();
        _timer = null;
      }
      setState(() {
        _isTimerRunning = false;
      });
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_remainingTime > 0) {
          setState(() {
            _remainingTime--;
          });
        } else {
          _timer!.cancel();
          _timer = null;
          _isTimerRunning = false;

          if (_currentMode == 'pomodoro' && _remainingTime == 0) {
            _completedCycles++;
            _playSound(_notificationSound);
            _showNotification('Cycle Completed',
                'The cycle has completed $_completedCycles times');
            if (_completedCycles >= _cyclesUntilLongBreak) {
              _currentMode = 'long break';
            } else {
              _currentMode = 'short break';
            }
          } else if (_currentMode == 'short break' ||
              _currentMode == 'long break') {
            _currentMode = 'pomodoro';
          }

          _remainingTime = _getRemainingTime(_currentMode);
          _startTimer();

          setState(() {
            _isTimerRunning = true;
          });
        }
      });
      setState(() {
        _isTimerRunning = true;
      });
      if (_currentMode == 'pomodoro') {
        _isWorking = true;
      } else if (_currentMode == 'short break' ||
          _currentMode == 'long break') {
        _isWorking = false;
      }
    }
  }

  void _resetTimer() {
    _playSound(_notificationSound);

    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }

    setState(() {
      _isWorking = true;
      _completedCycles = 0;
      _isTimerRunning = false;
      _currentMode = 'pomodoro';
      _remainingTime = _getRemainingTime(_currentMode);
    });
  }

  void _configureDurations() {
    DurationConfigurator(
      context: context,
      pomodoroDuration: _pomodoroDuration,
      shortBreakDuration: _shortBreakDuration,
      longBreakDuration: _longBreakDuration,
      onDurationsUpdated: (int updatedPomodoroDuration,
          int updatedShortBreakDuration, int updatedLongBreakDuration) {
        setState(() {
          _pomodoroDuration = updatedPomodoroDuration;
          _shortBreakDuration = updatedShortBreakDuration;
          _longBreakDuration = updatedLongBreakDuration;
          _remainingTime = _getRemainingTime(_currentMode);
        });
      },
      onBackgroundImageUpdated: (String updatedBackgroundImage) {
        setState(() {
          _backgroundImage = 'assets/images/$updatedBackgroundImage';
        });
      },
    ).configureDurations();
  }

  Future<void> _initializePlayer() async {
    await _soundPlayer?.openAudioSession();
  }

  @override
  void dispose() {
    _soundPlayer?.closeAudioSession();
    _soundPlayer = null;
    super.dispose();
  }

  Future<void> _playSound(String soundPath) async {
    await _soundPlayer?.startPlayer(
      fromURI: 'assets/sounds/$soundPath',
    );
  }

  Future<void> stopPlayer() async {
    if (_soundPlayer != null) {
      await _soundPlayer?.stopPlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_backgroundImage),
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
                  _buildButton('pomodoro'),
                  const SizedBox(width: 10),
                  _buildButton('short break'),
                  const SizedBox(width: 10),
                  _buildButton('long break'),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                _formatTime(_remainingTime),
                style: const TextStyle(
                  fontSize: 80,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Completed Cycles: $_completedCycles',
                style: const TextStyle(
                  fontSize: 20,
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
                child: Text(_isTimerRunning ? 'pause' : 'start'),
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

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Widget _buildButton(String text) {
    bool isSelected = _currentMode == text;

    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (_timer != null) {
            _timer!.cancel();
            _timer = null;
          }
          _currentMode = text;
          _remainingTime = _getRemainingTime(text);
          _isTimerRunning = false;
          _startTimer();
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
