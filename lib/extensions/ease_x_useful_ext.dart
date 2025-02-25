extension EaseXDuration on num {
  /// Convert to seconds duration
  Duration get seconds => Duration(seconds: toInt());

  /// Convert to milliseconds duration
  Duration get milliseconds => Duration(milliseconds: toInt());

  /// Convert to microseconds duration
  Duration get microseconds => Duration(microseconds: toInt());

  /// Convert to minutes duration
  Duration get minutes => Duration(minutes: toInt());

  /// Convert to hours duration
  Duration get hours => Duration(hours: toInt());

  /// Convert to days duration
  Duration get days => Duration(days: toInt());
}
