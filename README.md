
# 🚀 EaseX - Simplify Flutter Development 🏗️  

EaseX is a **feature-rich** Flutter package that enhances development by providing a collection of **powerful extensions and utilities**. It simplifies **UI styling**, **navigation**, **validation**, **device information handling**, and much more. ✨  

---

![EaseX Animation](https://imgur.com/AZ2pPHh.gif)


## 🎯 Features  

✅ **Text Styling Extensions** 🖌️ - Easily apply `bold`, `italic`, `underlined`, `colored`, and `size` styles to `Text` widgets.  

✅ **Navigation Simplifications** 🧭 - Use `.push()` and `.pop()` to navigate between screens effortlessly.  

✅ **Device Utilities** 📱 - Get device information like screen size, platform type (Android/iOS), and keyboard visibility.  

✅ **Validation Helpers** ✅ - Built-in validators for common form inputs such as email, phone number, and password strength.  

✅ **Toast Notifications** 🔔 - Display toast messages easily using `showToast()`, `showSuccessToast()`, etc.  

✅ **Spacing & Padding Extensions** 📏 - Use `.vBox` and `.pad()` to manage spacing between widgets.  

✅ **Keyboard Management** ⌨️ - Hide the keyboard programmatically with `EaseXDevice.hideKeyboard()`.  

✅ **Rotation & Visibility** 🔄 - Rotate widgets with `.rotate()` and conditionally show them with `.showIf()`.  

✅ **Asynchronous Handling** ⏳ - Delay actions using `Future.delayed(1.seconds)` instead of manually defining durations.  

✅ **Loading Indicator** 🔃 - Show and hide a global loader using `EaseXLoader.show()` and `EaseXLoader.hide()`.  

✅ **Expandable Widgets** 📐 - Wrap widgets in `.expanded()` for better layout management. 

✅ **Smooth Alert Dialog Animation** 🎭 - Animated alert dialogs with bounce effects!

✅ **Sharing Made Easy with EaseXShare Utils** 🎭 - Share text, images, videos, pdf and etc... files easily using EaseXShare Utils.

## 🆕 New Features in v1.4.0

✅ **EaseXMedia** - Powerful media picking utilities

✅ **EaseXStorage** - Simple key-value storage


And much more! 🚀 Explore the complete package to discover all utilities. 📦  

---

## 🚀 Getting Started  

### 📥 Install the package  
```sh
flutter pub add ease_x
```  

### 📌 Import it into your project  
```dart
import 'package:ease_x/ease_x.dart';
```  

---

## ⚡ Usage  

### 🎨 Text Styling Extensions  
```dart
Text('Bold Text').bold(); // 🔠 Make text bold
Text('Colored Text').colored(Colors.deepPurple); // 🎨 Apply color to text
Text('Sized Text').size(20); // 🔡 Change text size
Text('Underlined Text').underlined(); // ✍️ Underline text
```

### 🧭 Navigation Simplification  
```dart
context.push(SecondScreen()); // 🚀 Navigate to another screen
context.pop(); // 🔙 Go back to the previous screen
```

### 📱 Device Utilities  
```dart
bool hasInternet = await EaseXDevice.hasInternetConnection(); // 🌍 Check internet connection
double screenWidth = EaseXDevice.getScreenWidth(context); // 📏 Get screen width
```

### 🎨 Light and Dark Theme  
```dart
MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: EaseXTheme.light, // 🌞 Light Theme
  darkTheme: EaseXTheme.dark, // 🌙 Dark Theme
  navigatorKey: EaseXLoader.navigatorKey, // 🔄 Required for EaseXLoader
  home: const ExampleHomeScreen(), // 🏠 Initial Screen
);
```

### 🔔 Toast Messages  
```dart
"Hello from EaseX!".showBlackToast(); // 📢 Show black toast
"Success!".showSuccessToast(); // ✅ Show success toast
```

### ⏳ Show/Hide Loader  
```dart
EaseXLoader.show(); // 🔄 Show loading indicator
await Future.delayed(2.seconds);
EaseXLoader.hide(); // ❌ Hide loader
```

### 🎭 Animated Alert Dialogs**  
```dart
EaseXLoader.showAlert("This is an info alert!"); // ℹ️ Show an info alert
EaseXLoader.showErrorAlert("Oops! Something went wrong."); // ❌ Show an error alert
EaseXLoader.showSuccessAlert(); // ✅ Show a success alert
```


### 🔗 Share Utils
```dart
EaseXShare.shareSingleImage(imageFile, text: "Sample Text");
EaseXShare.shareFile(file);
EaseXShare.openWhatsAppChat('+91', '8920119443',message: "Flutter Developer.");
```


### 👁️ Conditional Visibility  
```dart
Text('Visible Text').showIf(condition == true); // 👀 Show text based on condition
```


### 🖼️ Media Utilities
```dart
// Pick single image
final image = await EaseXMedia.pickImage();
// Pick video
final video = await EaseXMedia.pickVideo();
```

### 💾 EaseX Storage
```dart
// Initialize (call once)
await EaseXStorage.init();

// Save data
await EaseXStorage.setString('token', 'abc123');

// Read data
final token = EaseXStorage.getString('token');

// Remove data
await EaseXStorage.remove('token');
```


---

## ℹ️ Additional Information  
EaseX is designed to **make Flutter development easier and faster** by reducing **boilerplate code**. 🚀  

There is **so much more** to explore! Check out the **package code** for a deep dive into all available features.  

Happy coding! 🎉🔥  

---

## 👨‍💻 Contributors  

This package is actively maintained by:  

<table style="border: none; border-collapse: collapse; margin-left: 18px;">  
  <tr style="border: none;">
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

📬 **Feel free to connect with us on LinkedIn!** 🚀  

---

Let me know if you need any modifications! 🚀🔥