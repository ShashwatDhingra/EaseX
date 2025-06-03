
class EaseXTimeAgo {
  /// Formats [date] into a relative time string
  static String format(DateTime date, {DateTime? clock, String? locale}) {
    final now = clock ?? DateTime.now();
    final elapsed = now.millisecondsSinceEpoch - date.millisecondsSinceEpoch;
    
    final num seconds = elapsed / 1000;
    final num minutes = seconds / 60;
    final num hours = minutes / 60;
    final num days = hours / 24;
    final num months = days / 30;
    final num years = days / 365;

    final lookupMessages = locale != null 
      ? _lookupMessages(locale) 
      : EnMessages();

    if (seconds < 45) return lookupMessages.lessThanOneMinute(seconds.round());
    if (seconds < 90) return lookupMessages.aboutAMinute(minutes.round());
    if (minutes < 45) return lookupMessages.minutes(minutes.round());
    if (minutes < 90) return lookupMessages.aboutAnHour(minutes.round());
    if (hours < 24) return lookupMessages.hours(hours.round());
    if (hours < 48) return lookupMessages.aDay(hours.round());
    if (days < 30) return lookupMessages.days(days.round());
    if (days < 60) return lookupMessages.aboutAMonth(days.round());
    if (days < 365) return lookupMessages.months(months.round());
    if (years < 2) return lookupMessages.aboutAYear(years.round());
    return lookupMessages.years(years.round());
  }

  /// Sets a new default locale
  static void setLocaleMessages(String locale, TimeAgoMessages messages) {
    _messages[locale] = messages;
  }

  static final Map<String, TimeAgoMessages> _messages = {
    'en': EnMessages(),
    'es' : EsMessages()
  };
  

  static TimeAgoMessages _lookupMessages(String locale) {
    return _messages[locale] ?? EnMessages();
  }
}

abstract class TimeAgoMessages {
  String prefixAgo();
  String prefixFromNow();
  String suffixAgo();
  String suffixFromNow();
  String lessThanOneMinute(int seconds);
  String aboutAMinute(int minutes);
  String minutes(int minutes);
  String aboutAnHour(int minutes);
  String hours(int hours);
  String aDay(int hours);
  String days(int days);
  String aboutAMonth(int days);
  String months(int months);
  String aboutAYear(int year);
  String years(int years);
  String wordSeparator() => ' ';
}

class EnMessages implements TimeAgoMessages {
  @override String prefixAgo() => '';
  @override String prefixFromNow() => '';
  @override String suffixAgo() => 'ago';
  @override String suffixFromNow() => 'from now';
  @override String lessThanOneMinute(int seconds) => 'just now';
  @override String aboutAMinute(int minutes) => 'a minute ago';
  @override String minutes(int minutes) => '$minutes minutes ago';
  @override String aboutAnHour(int minutes) => 'about an hour ago';
  @override String hours(int hours) => '$hours hours ago';
  @override String aDay(int hours) => 'a day ago';
  @override String days(int days) => '$days days ago';
  @override String aboutAMonth(int days) => 'about a month ago';
  @override String months(int months) => '$months months ago';
  @override String aboutAYear(int year) => 'about a year ago';
  @override String years(int years) => '$years years ago';
  @override String wordSeparator() => ' ';
}

class EsMessages implements TimeAgoMessages {
  @override String prefixAgo() => 'hace';
  @override String prefixFromNow() => 'dentro de';
  @override String suffixAgo() => '';
  @override String suffixFromNow() => '';
  @override String lessThanOneMinute(int seconds) => 'ahora mismo';
  @override String aboutAMinute(int minutes) => 'un minuto';
  @override String minutes(int minutes) => '$minutes minutos';
  @override String aboutAnHour(int minutes) => 'una hora';
  @override String hours(int hours) => '$hours horas';
  @override String aDay(int hours) => 'un día';
  @override String days(int days) => '$days días';
  @override String aboutAMonth(int days) => 'un mes';
  @override String months(int months) => '$months meses';
  @override String aboutAYear(int year) => 'un año';
  @override String years(int years) => '$years años';
  @override String wordSeparator() => ' ';
}