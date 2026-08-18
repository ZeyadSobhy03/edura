extension DateEx on DateTime {
  String get period {
    return hour < 12 ? 'AM' : 'PM';
  }

  String get formatDate {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/${year.toString()}';
  }

}
