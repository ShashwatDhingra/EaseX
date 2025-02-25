import 'package:flutter/material.dart';
import 'package:ease_x/ease_x.dart';

void main() {
  runApp(const EaseXExampleApp());
}

/// The main app widget
class EaseXExampleApp extends StatelessWidget {
  const EaseXExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: EaseXTheme.light,
      darkTheme: EaseXTheme.dark,
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
  final formKey = GlobalKey<FormState>();

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
        appBar:
            AppBar(title: const Text('EaseX Example')), // App bar with title
        body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display device and network information using EaseXDevice utilities
              Text('Screen Width: ${EaseXDevice.getScreenWidth(context)}')
                  .bold()
                  .size(20),
              Text('Keyboard Visible: ${EaseXDevice.isKeyboardVisible(context)}')
                  .bold()
                  .size(20),
              Text('Device: ${EaseXDevice.isAndroid ? "Android" : EaseXDevice.isIOS ? "iOS" : "Unknown"}')
                  .bold()
                  .size(20),
              Text(
                'Internet: $internetStatus',
                style: TextStyle(
                    color: internetStatus == "Connected"
                        ? Colors.green
                        : Colors.red),
              )..bold().size(20),

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
                onPressed: () => "Hello from EaseXToast".showBlackToast(),
                child: const Text("Show Toast"),
              ),

              18.vBox,

              // Rotating a widget
              const Text("Rotated Text").rotate(50),

              18.vBox,

              // EaseXTextStyle Example
              const Text("Styled Text")
                  .bold()
                  .colored(Colors.deepPurple.shade300)
                  .italic()
                  .underlined(),
              // .bold()
              // .italic(), // Applying predefined H1 text style

              // EaseXDuration Example
              const Text("Delay: 1 Second [Click Me]").onTap(() async {
                await Future.delayed(1.seconds); // Duration extension
                "Showing Toast after delay".showSuccessToast();
              }), // Displaying short duration in milliseconds

              // EaseXValidator Example for email validation
              Row(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                    validator:
                        EaseXValidator.validateEmail, // Validates email input
                  ).expanded(
                      flex:
                          3), // Use .expanded() on any Widget | Shortcut for wrapping with Expanded()
                  ElevatedButton(
                          onPressed: () {
                            formKey.currentState!.validate();
                          },
                          child: const Text('Validate'))
                      .expanded(flex: 2)
                ],
              ),

              12.vBox,

              // EaseXLoader Example - Show and hide loader
              ElevatedButton(
                onPressed: () async {
                  _toggleLoader();
                  await Future.delayed(2.seconds);
                  _toggleLoader();
                },
                child: const Text("Show Loader"),
              ),

              12.vBox,

              // EaseXWidgetExtensions: showIf Example
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showExtraContent = !showExtraContent;
                  });
                },
                child: const Text("Toggle Extra Content"),
              ),

              12.vBox,

              // Show extra content only if showExtraContent is true
              const Text(
                      "There is so much more to explore! Check out the package code for a deep dive into all available features.")
                  .bold()
                  .showIf(
                      showExtraContent), // showIf will conditionally display the widget
            ],
          ).pad(all: 24),
        ) // Ease Padding to any Widget,
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
