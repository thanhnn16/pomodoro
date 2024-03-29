import 'package:flutter/material.dart';

class DurationConfigurator {
  final BuildContext context;
  final int pomodoroDuration;
  final int shortBreakDuration;
  final int longBreakDuration;
  final Function(int, int, int) onDurationsUpdated;
  final Function(String) onBackgroundImageUpdated;

  DurationConfigurator({
    required this.context,
    required this.pomodoroDuration,
    required this.shortBreakDuration,
    required this.longBreakDuration,
    required this.onDurationsUpdated,
    required this.onBackgroundImageUpdated,
  });

  void configureDurations() {
    TextEditingController pomodoroController =
        TextEditingController(text: '$pomodoroDuration');
    TextEditingController shortBreakController =
        TextEditingController(text: '$shortBreakDuration');
    TextEditingController longBreakController =
        TextEditingController(text: '$longBreakDuration');

    String selectedNotificationSound = 'Sound 1';

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

    String selectedBackgroundImage = imageList[0];

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
                  const Text(
                    'Choose notification sound',
                    style: TextStyle(fontSize: 14),
                  ),
                  DropdownButton<String>(
                    value: selectedNotificationSound,
                    items: <String>['Sound 1', 'Sound 2', 'Sound 3', 'Sound 4']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      selectedNotificationSound = newValue!;
                    },
                    isExpanded: true,
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

                onDurationsUpdated(
                  updatedPomodoroDuration,
                  updatedShortBreakDuration,
                  updatedLongBreakDuration,
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
