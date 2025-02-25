import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  /// Navigate to a new screen.
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
  }

  /// Navigate to a new screen and remove all previous screens from the stack.
  Future<T?> pushAndRemoveUntil<T>(Widget page,
      {bool Function(Route<dynamic>)? predicate}) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      predicate ?? (route) => false,
    );
  }

  /// Replace the current screen with a new one.
  Future<T?> pushReplacement<T, R>(Widget page, {R? result}) {
    return Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
      result: result,
    );
  }

  /// Pop the current screen and return to the previous one.
  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// Pop all screens until the predicate matches.
  void popUntil(bool Function(Route<dynamic>) predicate) {
    Navigator.of(this).popUntil(predicate);
  }

  /// Check if the navigator can pop.
  bool canPop() {
    return Navigator.of(this).canPop();
  }

  /// Push a named route.
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  /// Push a named route and remove all previous screens from the stack.
  Future<T?> pushNamedAndRemoveUntil<T>(String routeName,
      {bool Function(Route<dynamic>)? predicate, Object? arguments}) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
        routeName, predicate ?? (route) => false,
        arguments: arguments);
  }

  /// Replace the current screen with a named route.
  Future<T?> pushReplacementNamed<T, R>(String routeName,
      {R? result, Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments, result: result);
  }

  /// Pop the current screen with a named route.
  void popNamed<T>(T? result) {
    Navigator.of(this).pop(result);
  }

  bool get isDarkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }
}
