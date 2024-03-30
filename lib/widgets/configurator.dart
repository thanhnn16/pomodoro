import 'package:flutter/material.dart';

class DurationConfigurator {
  final BuildContext context;
  final int pomodoroDuration;
  final int shortBreakDuration;
  final int longBreakDuration;
  final int cyclesUntilLongBreak;
  final Function(int, int, int, int) onDurationsUpdated;
  final Function(String) onBackgroundImageUpdated;
  final Function(String) onNotificationSoundUpdated;

  DurationConfigurator({
    required this.context,
    required this.pomodoroDuration,
    required this.shortBreakDuration,
    required this.longBreakDuration,
    required this.cyclesUntilLongBreak,
    required this.onDurationsUpdated,
    required this.onBackgroundImageUpdated,
    required this.onNotificationSoundUpdated,
  });

  void configureDurations() {
    TextEditingController pomodoroController =
        TextEditingController(text: '$pomodoroDuration');
    TextEditingController shortBreakController =
        TextEditingController(text: '$shortBreakDuration');
    TextEditingController longBreakController =
        TextEditingController(text: '$longBreakDuration');
    TextEditingController cyclesUntilLongBreakController =
    TextEditingController(text: '$cyclesUntilLongBreak');


    ValueNotifier<String> selectedNotificationSoundNotifier =
        ValueNotifier<String>('Bell');

    List<String> imageList = [
      'bg_1.jpg',
      'bg_2.jpg',
      'bg_3.jpg',
      'bg_4.jpg',
      'bg_5.jpg'
    ];

    List<String> imageLabels = [
      'Sweet bedroom',
      'House in the forest',
      'Sunset in the city',
      'Sunset on the beach',
      'Working space'
    ];

    ValueNotifier<String> selectedBackgroundImageNotifier =
        ValueNotifier<String>(imageList[0]);

    // String selectedBackgroundImage = imageList[0];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Configure Durations'),
          content: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: pomodoroController,
                    decoration: const InputDecoration(
                      labelText: "Pomodoro Duration (minutes)",
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                  ),
                  TextField(
                    controller: shortBreakController,
                    decoration: const InputDecoration(
                      labelText: "Short Break Duration (minutes)",
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                  ),
                  TextField(
                    controller: longBreakController,
                    decoration: const InputDecoration(
                      labelText: "Long Break Duration (minutes)",
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                  ),
                  TextField(
                    controller: cyclesUntilLongBreakController,
                    decoration: const InputDecoration(
                      labelText: "Cycles Until Long Break",
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                  ),
                  const Text(
                    'Choose notification sound',
                    style: TextStyle(fontSize: 14),
                  ),
                  ValueListenableBuilder<String>(
                    valueListenable: selectedNotificationSoundNotifier,
                    builder: (context, selectedNotificationSound, child) {
                      return DropdownButton<String>(
                        value: selectedNotificationSound,
                        items: <String>[
                          'Bell',
                          'Flute',
                          'Piano',
                          'Relax',
                          'Water'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          selectedNotificationSoundNotifier.value = newValue!;
                          onNotificationSoundUpdated(newValue);
                        },
                        isExpanded: true,
                      );
                    },
                  ),
                  const Text(
                    'Choose background image',
                    style: TextStyle(fontSize: 14),
                  ),
                  ValueListenableBuilder<String>(
                    valueListenable: selectedBackgroundImageNotifier,
                    builder: (context, selectedBackgroundImage, child) {
                      return DropdownButton<String>(
                        value: selectedBackgroundImage,
                        items: imageList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(imageLabels[imageList.indexOf(value)]),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          selectedBackgroundImageNotifier.value = newValue!;
                          onBackgroundImageUpdated(newValue);
                        },
                        isExpanded: true,
                      );
                    },
                  ),
                ],
              )),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                int updatedPomodoroDuration =
                    int.tryParse(pomodoroController.text) ?? pomodoroDuration;
                int updatedShortBreakDuration =
                    int.tryParse(shortBreakController.text) ??
                        shortBreakDuration;
                int updatedLongBreakDuration =
                    int.tryParse(longBreakController.text) ?? longBreakDuration;
                int updatedCyclesUntilLongBreak =
                    int.tryParse(cyclesUntilLongBreakController.text) ?? cyclesUntilLongBreak;

                onDurationsUpdated(
                  updatedPomodoroDuration,
                  updatedShortBreakDuration,
                  updatedLongBreakDuration,
                  updatedCyclesUntilLongBreak,
                );

                Navigator.of(context).pop();
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'))
          ],
        );
      },
    );
  }
}
