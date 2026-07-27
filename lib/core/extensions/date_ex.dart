extension DateEx on DateTime {
  String get period {
    return hour < 12 ? 'AM' : 'PM';
  }
}
