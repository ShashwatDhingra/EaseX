# EaseX - Simplify Flutter Development

EaseX is a feature-rich Flutter package that enhances development by providing a collection of powerful extensions and utilities. It simplifies UI styling, navigation, validation, device information handling, and much more.

## Features

✅ **Text Styling Extensions** - Easily apply `bold`, `italic`, `underlined`, `colored`, and `size` styles to `Text` widgets.

✅ **Navigation Simplifications** - Use `.push()` ,`.pushNamed()`, `.pop()` etc to navigate between screens effortlessly.

✅ **Device Utilities** - Get device information like screen size, platform type (Android/iOS), and keyboard visibility.

✅ **Validation Helpers** - Built-in validators for common form inputs such as email, phone number, and password strength.

✅ **Toast Notifications** - Display toast messages easily using `showBlackToast()` and `showSuccessToast()`.

✅ **Spacing & Padding Extensions** - Use `.vBox` and `.pad()` to manage spacing between widgets.

✅ **Keyboard Management** - Hide the keyboard programmatically with `EaseXDevice.hideKeyboard()`.

✅ **Rotation & Visibility** - Rotate widgets with `.rotate()` and conditionally show them with `.showIf()`.

✅ **Asynchronous Handling** - Delay actions using `Future.delayed(1.seconds)` instead of manually defining durations.

✅ **Loading Indicator** - Show and hide a global loader using `EaseXLoader.show()` and `EaseXLoader.hide()`.

✅ **Expandable Widgets** - Wrap widgets in `.expanded()` for better layout management.

And much more! Explore the complete package to discover all utilities. 📦

## Getting Started

1. **Install the package:**
   ```sh
   flutter pub add ease_x
   ```
2. **Import it into your project:**
   ```dart
   import 'package:ease_x/ease_x.dart';
   ```

## Usage

### Text Styling Extensions
```dart
Text('Bold Text').bold();
Text('Colored Text').colored(Colors.deepPurple);
Text('Sized Text').size(20);
Text('Underlined Text').underlined();
```

### Navigation Simplification
```dart
context.push(SecondScreen()); // Navigate to another screen
context.pop(); // Go back
```

### Device Utilities
```dart
bool hasInternet = await EaseXDevice.hasInternetConnection();
double screenWidth = EaseXDevice.getScreenWidth(context);
```

### Toast Messages
```dart
"Hello from EaseX!".showBlackToast();
"Success!".showSuccessToast();
```

### Show/Hide Loader
```dart
EaseXLoader.show();
await Future.delayed(2.seconds);
EaseXLoader.hide();
```

### Conditional Visibility
```dart
Text('Visible Text').showIf(condition == true);
```

## Additional Information
EaseX is designed to make Flutter development easier and faster by reducing boilerplate code. There is **so much more** to explore! Check out the **package code** for a deep dive into all available features.

Happy coding! 🚀

