import 'package:ease_x/ease_x.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EaseXExampleApp());
}

/// The main app widuget
class EaseXExampleApp extends StatelessWidget {
  const EaseXExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: EaseXLoader.navigatorKey, // Required for EaseXLoader
      home: const ExampleHomeScreen(), // Initial screen
    );
  }
}

/// Home screen demonstrating EaseX features
class ExampleHomeScreen extends StatefulWidget {
  const ExampleHomeScreen({super.key});

  @override
  State<ExampleHomeScreen> createState() => _ExampleHomeScreenState();
}

class _ExampleHomeScreenState extends State<ExampleHomeScreen> {
  final TextEditingController _emailController =
      TextEditingController(); // Controller for email input
  String internetStatus = "Checking..."; // Stores internet connection status
  bool isLoading = false; // Tracks whether the loader is visible
  bool showExtraContent = false; // Controls visibility for showIf example

  @override
  void initState() {
    super.initState();
    _checkInternet(); // Check internet status on startup
  }

  /// Checks if the device has an internet connection
  Future<void> _checkInternet() async {
    bool hasInternet = await EaseXDevice.hasInternetConnection();
    setState(() {
      internetStatus = hasInternet ? "Connected" : "No Internet";
    });
  }

  /// Toggles the visibility of the EaseXLoader
  void _toggleLoader() {
    setState(() {
      isLoading = !isLoading;
    });
    isLoading ? EaseXLoader.show() : EaseXLoader.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EaseX Example')), // App bar with title
      body: Padding(
        padding: const EdgeInsets.all(
            Sizes.md), // Padding using EaseX predefined sizes
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display device and network information using EaseXDevice utilities
            Text('Screen Width: ${EaseXDevice.getScreenWidth(context)}'),
            Text('Keyboard Visible: ${EaseXDevice.isKeyboardVisible(context)}'),
            Text(
                'Device: ${EaseXDevice.isAndroid ? "Android" : EaseXDevice.isIOS ? "iOS" : "Unknown"}'),
            Text(
              'Internet: $internetStatus',
              style: TextStyle(
                  color: internetStatus == "Connected"
                      ? Colors.green
                      : Colors.red),
            ),

            // EaseXBox Example - Adds vertical spacing of 20 pixels
            20.vBox,

            // EaseX Navigation Example
            ElevatedButton(
              onPressed: () => context
                  .push(const SecondScreen()), // Navigates to SecondScreen
              child: const Text("Go to Second Screen"),
            ),

            // EaseXWidgetExtensions Examples

            // Hide keyboard when button is tapped
            ElevatedButton(
              onPressed: () => EaseXDevice.hideKeyboard(context),
              child: const Text("Hide Keyboard"),
            )
                .pad(all: Sizes.md)
                .centered(), // Adds padding and centers the button

            // Show toast message on button tap
            ElevatedButton(
              onPressed: () => "Hello from EaseXToast".showToast(),
              child: const Text("Show Toast"),
            ).onTap(() => print("Button tapped")), // Adds onTap extension

            // Adjusting widget opacity
            const Icon(Icons.star, size: 50).opacity(0.5),

            // Rotating a widget
            const Text("Rotated Text").rotate(15),

            // EaseXTextStyle Example
            const Text("Styled Text")
                .bold()
                .italic(), // Applying predefined H1 text style

            // EaseXDuration Example
            Text("Delay: 1 Second").onTap(() async {
              await Future.delayed(1.seconds);
              "Showing Toast after delay".showSuccessToast();
            }), // Displaying short duration in milliseconds

            // EaseXValidator Example for email validation
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
              validator: EaseXValidator.validateEmail, // Validates email input
            ),

            // EaseXLoader Example - Show and hide loader
            ElevatedButton(
              onPressed: _toggleLoader,
              child: Text(isLoading ? "Hide Loader" : "Show Loader"),
            ),

            // EaseXWidgetExtensions: showIf Example
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showExtraContent = !showExtraContent;
                });
              },
              child: const Text("Toggle Extra Content"),
            ),

            // Show extra content only if showExtraContent is true
            const Text("This is extra content!").showIf(
                showExtraContent), // showIf will conditionally display the widget
          ],
        ),
      ),
    );
  }
}

/// Second screen to demonstrate EaseX navigation
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Second Screen")), // App bar with title
      body: Center(
        child: ElevatedButton(
          onPressed: () =>
              context.pop(), // Navigates back to the previous screen
          child: const Text("Go Back"),
        ),
      ),
    );
  }
}
