import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class EaseXLoader {
  static final EaseXLoader _instance = EaseXLoader._internal();

  factory EaseXLoader() => _instance;

  EaseXLoader._internal();

  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  static OverlayEntry? _overlayEntry;

  /// Determines the color based on system theme
  static Color get _loaderColor {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark
        ? Colors.white
        : Colors.black;
  }

  /// Show Loader
  static void show() {
    if (_overlayEntry != null) return; // Prevent duplicate loaders

    _overlayEntry = OverlayEntry(
      builder: (context) => AbsorbPointer(
        absorbing: true, // Prevent user interactions
        child: Stack(
          children: [
            const Opacity(
              opacity: 0.5,
              child: ModalBarrier(color: Colors.black, dismissible: false),
            ),
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
                color: _loaderColor, // Dynamically change color
              ),
            ),
          ],
        ),
      ),
    );

    _navigatorKey.currentState?.overlay?.insert(_overlayEntry!);
  }

  /// Hide Loader
  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
