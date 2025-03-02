import 'dart:ui';
import 'package:ease_x/ease_x.dart';
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
  static BuildContext? _dialogContext;

  /// Determines the loader color based on system theme
  static Color get _loaderColor {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark
        ? Colors.white
        : Colors.black;
  }

  /// Show Loader
  static void show() {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => AbsorbPointer(
        absorbing: true,
        child: Stack(
          children: [
            const Opacity(
              opacity: 0.3,
              child: ModalBarrier(color: Colors.black, dismissible: false),
            ),
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: _loaderColor,
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

  /// Show an information alert
  static void showAlert({String? title, String? message}) {
    _showDialog(
      title: title ?? "Note",
      content: message,
      icon: Icons.info_outline_rounded,
      color: Colors.blueAccent,
    );
  }

  /// Show an error alert
  static void showErrorAlert({String? title, String? message}) {
    _showDialog(
      title: title ?? "Error",
      content: message,
      icon: Icons.error_outline_rounded,
      color: Colors.redAccent,
    );
  }

  /// Show a success alert
  static void showSuccessAlert({String? title, String? message}) {
    _showDialog(
      title: title ?? "Success",
      content: message,
      icon: Icons.check_circle_outline_rounded,
      color: Colors.green,
    );
  }

  /// Dismiss an active alert
  static void dismissAlert() {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!).pop();
      _dialogContext = null;
    }
  }

  /// Minimalist & Premium
  static void _showDialog({
    required String title,
    required String? content,
    required IconData icon,
    required Color color,
  }) {
    if (_navigatorKey.currentContext == null) return;

    showGeneralDialog(
      context: _navigatorKey.currentContext!,
      barrierDismissible: true,
      barrierLabel: "",
      pageBuilder: (context, _, __) {
        _dialogContext = context;
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        return Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15), // Stronger blur
            child: Material(
              color: Colors.transparent,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.85, end: 1.0),
                duration: const Duration(milliseconds: 400),
                curve: Curves.elasticOut, // iOS-style elastic effect
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  padding:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.black.withOpacity(0.75)
                        : Colors.white.withOpacity(0.92),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: 48, color: color),
                      const SizedBox(height: 14),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        content ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode ? Colors.grey[300] : Colors.black54,
                        ),
                      ).showIf(content != null && content.isNotEmpty),
                      const SizedBox(height: 22),
                      GestureDetector(
                        onTap: dismissAlert,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 30),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: color.withOpacity(0.4),
                                blurRadius: 6,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: const Text(
                            "Okay",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(anim1),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.9, end: 1.0).animate(
              CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
