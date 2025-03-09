import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ease_x/ease_x.dart';
import 'package:image_picker/image_picker.dart';

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
      theme: EaseXTheme.light, // EaseX Light Theme
      darkTheme: EaseXTheme.dark, // EaseX Dark
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
          child: SingleChildScrollView(
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
                const Text("Delay: 2 Second [Click Me]").onTap(() async {
                  await 2.seconds.delay;
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
                    await 2.seconds.delay;
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

                ElevatedButton(
                  onPressed: () async {
                    EaseXLoader.showSuccessAlert(
                        title: 'Thanks from EaseX',
                        message: 'Hope you Liked it.');
                    await 3.seconds.delay;
                    EaseXLoader.dismissAlert();
                  },
                  child: const Text('Show Alert'),
                ),

                12.vBox,

                // Show extra content only if showExtraContent is true
                const Text(
                        "There is so much more to explore! Check out the package code for a deep dive into all available features.")
                    .bold()
                    .showIf(
                        showExtraContent), // showIf will conditionally display the widget

                // Sharing Utils Examples
                const Text('Sharing is Caring ;)'),
                8.vBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        EaseXShare.shareText(
                            "Hello, check out this amazing app!");
                      },
                      child: const Text("Share Text"),
                    ),
                    // Share Single image
                    ElevatedButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          File imageFile = File(image.path);
                          EaseXShare.shareSingleImage(imageFile,
                              text: "Single image sharing");
                        }
                      },
                      child: const Text("Share Image"),
                    ),
                    // Share Multiple image
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ElevatedButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final image = await picker.pickMultiImage();
                      if (image.isNotEmpty) {
                        final images =
                            image.map((file) => File(file.path)).toList();
                        EaseXShare.shareMultipleImages(images, text: "Hello");
                      }
                    },
                    child: const Text("Share Multiple Image"),
                  ),
                  // Open WhatsApp chat with specific number.
                  ElevatedButton(
                    onPressed: () async {
                      EaseXShare.openWhatsAppChat('+91', '8920119443',
                          message: "Flutter Developer.");
                    },
                    child: const Text("Open Whatsapp"),
                  )
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ElevatedButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final video =
                          await picker.pickVideo(source: ImageSource.gallery);
                      if (video != null) {
                        final videoFile = File(video.path);
                        EaseXShare.shareVideo(videoFile);
                      }
                    },
                    child: const Text("Share Video"),
                  ),
                  // Open WhatsApp chat with specific number.
                  ElevatedButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final pickedFile = await picker.pickMedia();
                      if (pickedFile != null) {
                        final file = File(pickedFile.path);
                        EaseXShare.shareFile(file);
                      }
                    },
                    child: const Text("Share File"),
                  )
                ])
              ],
            ).pad(all: 24),
          ),
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
        onPressed: () => context.pop(), // Navigates back to the previous screen
        child: const Text("Go Back"),
      )),
    );
  }
}
