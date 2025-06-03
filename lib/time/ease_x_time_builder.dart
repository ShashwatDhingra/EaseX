import 'dart:async';

import 'package:ease_x/time/ease_x_time_ago.dart';
import 'package:flutter/material.dart';

class EaseXTimeBuilder extends StatefulWidget {
  final DateTime date;
  final String? locale;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int maxLines;
  final TextDirection? textDirection;
  final Widget Function(String value) builder;

  const EaseXTimeBuilder({
    super.key,
    required this.date,
    required this.builder,
    this.locale,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines = 1,
    this.textDirection,
  });

  @override
  _EaseXTimeBuilderState createState() => _EaseXTimeBuilderState();
}

class _EaseXTimeBuilderState extends State<EaseXTimeBuilder> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scheduleTimer();
  }

  @override
  void didUpdateWidget(EaseXTimeBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.date != oldWidget.date) {
      _scheduleTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _scheduleTimer() {
    _timer?.cancel();
    
    final now = DateTime.now();
    final difference = now.difference(widget.date);
    Duration refreshDuration;
    
    if (difference.inSeconds < 60) {
      refreshDuration = const Duration(seconds: 1);
    } else if (difference.inMinutes < 60) {
      refreshDuration = const Duration(minutes: 1);
    } else if (difference.inHours < 24) {
      refreshDuration = const Duration(hours: 1);
    } else {
      refreshDuration = const Duration(days: 1);
    }

    _timer = Timer(refreshDuration, () {
      if (mounted) {
        setState(() => _scheduleTimer());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final timeAgo = EaseXTimeAgo.format(widget.date, locale: widget.locale);
    return widget.builder(timeAgo);
  }
}