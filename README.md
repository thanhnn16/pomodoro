# calculator

A Simple Pomodoro App for Flutter Learning Practice.
Tested on: Chrome, Android Emulator (34), MacOS (Sonoma 14.4), iPhone XS (iOS 17.4)

## Learning Sources:
1. [Dart Language](https://dart.dev/language)
2. [Dartpad](https://dartpad.dev/?)
3. [Flutter UI](https://docs.flutter.dev/ui)
4. [Flutter Interaction](https://docs.flutter.dev/ui/interactivity)
5. [Flutter Timer](https://pub.dev/packages/flutter_timer)
6. [Flutter Notification](https://pub.dev/packages/flutter_local_notifications)
7. [Flutter Shared Preferences](https://pub.dev/packages/shared_preferences)
8. [Flutter Audio Player](https://pub.dev/packages/audioplayers)

Other resources:
1. Fonts: https://pub.dev/packages/google_fonts
2. Sounds, Images: https://pixabay.com/

## PLANNING
1. Read documentation on Flutter Timer, Notification, Shared Preferences, Audio Player
2. Refraction of the code structure
3. Implement the functionality for the Pomodoro Timer app based on the provided code structure.
4. Test the app on Chrome and Android Emulator
5. Test the app on MacOS, iOS

## WORKING PROCESS
1. Day 1: 28/03/2024:
- Start the project
- Read the documentation on Flutter Timer, Notification, Sound, Shared Preferences, Audio Player
2. Day 2: 29/03/2024:
- Refraction of the code structure
- Implement the functionality for the Pomodoro Timer app based on the provided code structure.
- Test the app on Chrome and Android Emulator
- Commit the code to GitHub
3. Day 3: 30/03/2024
- Init Notification for macOS and iOS
- Test the app on MacOS, iOS
- Update the README.md file
- Submit the project

## CODE STRUCTURE
1. `main.dart`: Main file to run the app
2. `/widgets/configurator.dart`: Configurator widget to set the Pomodoro, Short Break, Long Break time
3. `/widgets/pomodoro_screen.dart`: PomodoroScreen widget to display the Pomodoro Timer
4. `/services/notification.dart`: NotificationService to show the notification
5. `/assets/`: Contains assets for the app

## THINGS I LEARNED FROM THIS PROJECT
1. Basic Flutter UI design
2. Basic Dart Language
3. Basic State Management
4. Flutter Timer
5. Flutter Notification (Local Notification)
6. TextEditingController
7. AlertDialog
8. Flutter Audio Player
9. ValueNotifier
10. ValueListenableBuilder

## ISSUES
1. Responsive UI
2. Testing...

## TOOLS USED
1. Android Studio
2. Github Copilot
3. Flutter Inspector
4. Dartpad

## TODOs:

Implement the functionality for the Pomodoro Timer app based on the provided code structure. The app should allow users to start, and reset the timer, as well as switch between Pomodoro, Short Break, and Long Break modes. The app should also keep track of the number of completed Pomodoro cycles and display notifications when each interval is completed.

To envision how this app should work, please visit a similar app here: https://studywithme.io/aesthetic-pomodoro-timer/

## Pomodoro / Short Break / Long Break Mechanism:

The Pomodoro Technique is a time management method that uses a timer to break work into intervals, typically 25 minutes in length, separated by short breaks. Here's how the mechanism works:

1. Pomodoro: The Pomodoro interval is the core working period, usually lasting 25 minutes. During this time, the user focuses on a specific task without interruptions. When the Pomodoro interval is completed, the app should start a Short Break interval automatically.

2. Short Break: The Short Break interval is a brief rest period, typically lasting 5 minutes. It allows the user to relax, stretch, or perform any quick tasks. After the Short Break, the app should start the next Pomodoro interval. After completing a set number of Pomodoro intervals (e.g., 4), the app should start a Long Break instead of a Short Break.

3. Long Break: The Long Break interval is an extended rest period, usually lasting 15-30 minutes. It provides a longer break after completing a set of Pomodoro intervals. The Long Break allows the user to recharge and prepare for the next set of Pomodoro intervals. After the Long Break, the app should start a new set of Pomodoro intervals.
The app should keep track of the number of completed Pomodoro cycles (1 cycle = Pomodoro + Short Break or Pomodoro + Long Break) and display it to the user.

## SCREEN SHOTS
![](/screenshots/macOs.png)
![](/screenshots/macOs_noti.png)
![](/screenshots/config.png)
![](/screenshots/ios.jpg)
![](/screenshots/web.png)