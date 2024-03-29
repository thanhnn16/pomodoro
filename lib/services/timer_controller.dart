import 'dart:async';

class TimerController {
  late int _remainingTime = 0;
  final String _currentState = 'Pomodoro';
  final int _completedCycles = 0;
  final int _cyclesUntilLongBreak = 4;

  int _pomodoroDuration = 25;
  int _shortBreakDuration = 5;
  int _longBreakDuration = 10;
  final bool _isWorking = true;

  void startTimer(time) {
    // TODO: Implement the logic to start the timer
    Timer.periodic(time, (timer) {
      if (_remainingTime == 0) {
        timer.cancel();
        // Show notification
      } else {
        _remainingTime--;
      }
    });
  }

  void pauseTimer() {
    // TODO: Implement the logic to pause the timer
  }

  void resetTimer() {
    // TODO: Implement the logic to reset the timer
  }

  void configureDurations(
      int pomodoroDuration, int shortBreakDuration, int longBreakDuration) {
    _pomodoroDuration = pomodoroDuration;
    _shortBreakDuration = shortBreakDuration;
    _longBreakDuration = longBreakDuration;
  }
}
