# SimpleX - Simplify Flutter Development

SimpleX is a feature-rich Flutter package that enhances development by providing a collection of powerful extensions and utilities. It simplifies UI styling, navigation, validation, device information handling, and much more.

## Features

✅ **Text Styling Extensions** - Easily apply `bold`, `italic`, `underlined`, `colored`, and `size` styles to `Text` widgets.

✅ **Navigation Simplifications** - Use `.push()` and `.pop()` to navigate between screens effortlessly.

✅ **Device Utilities** - Get device information like screen size, platform type (Android/iOS), and keyboard visibility.

✅ **Validation Helpers** - Built-in validators for common form inputs such as email, phone number, and password strength.

✅ **Toast Notifications** - Display toast messages easily using `showBlackToast()` and `showSuccessToast()`.

✅ **Spacing & Padding Extensions** - Use `.vBox` and `.pad()` to manage spacing between widgets.

✅ **Keyboard Management** - Hide the keyboard programmatically with `SimpleXDevice.hideKeyboard()`.

✅ **Rotation & Visibility** - Rotate widgets with `.rotate()` and conditionally show them with `.showIf()`.

✅ **Asynchronous Handling** - Delay actions using `Future.delayed(1.seconds)` instead of manually defining durations.

✅ **Loading Indicator** - Show and hide a global loader using `SimpleXLoader.show()` and `SimpleXLoader.hide()`.

✅ **Expandable Widgets** - Wrap widgets in `.expanded()` for better layout management.

And much more! Explore the complete package to discover all utilities. 📦

## Getting Started

1. **Install the package:**
   ```sh
   flutter pub add simple_x
   ```
2. **Import it into your project:**
   ```dart
   import 'package:simple_x/simple_x.dart';
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
bool hasInternet = await SimpleXDevice.hasInternetConnection();
double screenWidth = SimpleXDevice.getScreenWidth(context);
```

### Toast Messages
```dart
"Hello from SimpleX!".showBlackToast();
"Success!".showSuccessToast();
```

### Show/Hide Loader
```dart
SimpleXLoader.show();
await Future.delayed(2.seconds);
SimpleXLoader.hide();
```

### Conditional Visibility
```dart
Text('Visible Text').showIf(condition == true);
```

## Additional Information
SimpleX is designed to make Flutter development easier and faster by reducing boilerplate code. There is **so much more** to explore! Check out the **package code** for a deep dive into all available features.

Happy coding! 🚀



## Contributors  

This package is actively maintained by:  

<table style="border: none; border-collapse: collapse; margin-left: 18px;">  <tr style="border: none;">
    <td align="center" width="60" style="border: none; padding: 0;">
      <img src="https://media.licdn.com/dms/image/v2/D4D03AQGssdGx3xV14Q/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1690176959048?e=1746057600&v=beta&t=YdgkWknRB3Tja4gMSqVUoUssoBU8LIETZXzSLxAMbig" width="45" height="45" style="border-radius: 50%;" />
      <br>
      <b><a href="https://www.linkedin.com/in/shashwat-dhingra-0792b1236/">Shashwat</a></b>
    </td>
    <td align="center" width="60" style="border: none; padding: 0;">
      <img src="https://media.licdn.com/dms/image/v2/D5603AQGbkAN9B6H3zQ/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1718278370898?e=1746057600&v=beta&t=usPfXblFapjuk3VIgp3HtOkUWx6GaOuHFW8uAg5HwGY" width="45" height="45" style="border-radius: 50%;" />
      <br>
      <b><a href="https://www.linkedin.com/in/ajjujaihind/">Ajay</a></b>
    </td>
  </tr>
</table>



Feel free to connect with us on LinkedIn! 🚀  