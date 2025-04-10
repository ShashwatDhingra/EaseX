import 'dart:io';

import 'package:ease_x/ease_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:image_picker/image_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for EaseXStorage.init()
  await EaseXStorage.init(); // Initialize storage
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

  // Variables for images, video and files to show example of EaseXMedia
  File? _pickedImage;
  File? _pickedVideo;
  File? _pickedFile;
  List<File>? _pickedMultipleFiles;

  // Storage Demo Variables
  final TextEditingController _storageKeyController = TextEditingController();
  final TextEditingController _storageValueController = TextEditingController();
  String? _storedValue;

  // ========================
  // 🗄️ EaseXStorage Examples
  // ========================
  Future<void> _loadStoredValue() async {
    final value = EaseXStorage.getString(_storageKeyController.text);
    setState(() => _storedValue = value);
  }

  Future<void> _saveToStorage() async {
    if (_storageKeyController.text.isEmpty) return;
    await EaseXStorage.setString(
      _storageKeyController.text,
      _storageValueController.text,
    );
    _loadStoredValue(); // Refresh displayed value
    "Saved successfully!".showSuccessToast();
  }

  Future<void> _clearStorage() async {
    await EaseXStorage.remove(_storageKeyController.text);
    _loadStoredValue();
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
                ]),
                // ========================
                // 🗄️ Storage Demo Section
                // ========================
                const Divider(),
                const Text('Storage Demo',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                16.vBox,

                // Key-Value Input
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _storageKeyController,
                        decoration:
                            const InputDecoration(labelText: 'Storage Key'),
                      ),
                    ),
                    8.hBox,
                    Expanded(
                      child: TextFormField(
                        controller: _storageValueController,
                        decoration: const InputDecoration(labelText: 'Value'),
                      ),
                    ),
                  ],
                ),
                12.vBox,

                // Action Buttons
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _saveToStorage,
                      child: const Text('Save'),
                    ).expanded(),
                    8.hBox,
                    ElevatedButton(
                      onPressed: _clearStorage,
                      child: const Text('Clear'),
                    ).expanded(),
                  ],
                ),
                12.vBox,

                // Display Stored Value
                Text(
                  _storedValue != null
                      ? 'Stored Value: $_storedValue'
                      : 'No value stored',
                  style: const TextStyle(fontSize: 16),
                ),

                // ========================
                // 🖼️ Media Picker Section
                // ========================
                const Divider(),
                const Text('Media Picking',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                16.vBox,

                // Image Picker
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final image = await EaseXMedia.pickImage();
                        setState(() => _pickedImage = image);
                      },
                      child: const Text('Pick Image'),
                    ).expanded(),
                    if (_pickedImage != null)
                      Image.file(_pickedImage!, width: 60, height: 60)
                          .pad(left: 8),
                  ],
                ),
                8.vBox,

                // Video Picker
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final video = await EaseXMedia.pickVideo();
                        setState(() => _pickedVideo = video);
                      },
                      child: const Text('Pick Video'),
                    ).expanded(),
                    if (_pickedVideo != null)
                      const Icon(Icons.videocam, size: 30).pad(left: 8),
                  ],
                ),
                8.vBox,

                // File Picker
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final file = await EaseXMedia.pickFile(
                          allowedExtensions: ['pdf', 'docx'],
                          maxSizeInBytes: 5 * 1024 * 1024,
                        );
                        setState(() => _pickedFile = file);
                      },
                      child: const Text('Pick File'),
                    ).expanded(),
                    if (_pickedFile != null)
                      const Icon(Icons.insert_drive_file, size: 30)
                          .pad(left: 8),
                  ],
                ),
                8.vBox,

                // Multiple Files
                ElevatedButton(
                  onPressed: () async {
                    final files = await EaseXMedia.pickMultipleFiles();
                    setState(() => _pickedMultipleFiles = files);
                  },
                  child: const Text('Pick Multiple Files'),
                ),
                if (_pickedMultipleFiles != null)
                  Text('Selected: ${_pickedMultipleFiles!.length} files')
                      .pad(top: 8),

                // ==============
                // 🖼️ File Saver
                // ===============
                ElevatedButton(
                    onPressed: () async {
                      await EaseXFileSaver.saveFile(
                        fileName: 'note',
                        type: FileType.text,
                        content:
                            'EaseX is an Utility package for helping Flutter Developers.',
                      );
                    },
                    child: const Text("Save File")),

                /// Shimmer Effect
                Container(
                  width: 200,
                  height: 120,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
                ).shimmer().pad(all: 12.0)
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
