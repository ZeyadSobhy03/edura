enum NotificationAudience {
  allStudents,
  activeOnly,
  individual;

  String get databaseValue => switch (this) {
    NotificationAudience.allStudents => 'all_students',
    NotificationAudience.activeOnly => 'active_only',
    NotificationAudience.individual => 'individual',
  };
}
