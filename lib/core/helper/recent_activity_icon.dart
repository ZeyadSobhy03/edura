import 'package:flutter/cupertino.dart';

IconData getRecentActivityIcon(String activityType) {
  if (activityType.contains('book')) {
    return CupertinoIcons.book;
  } else if (activityType.contains('assignment')) {
    return CupertinoIcons.doc_text;
  } else if (activityType.contains('quiz')) {
    return CupertinoIcons.question_circle;
  } else if (activityType.contains('announcement')) {
    return CupertinoIcons.bell;
  } else {
    return CupertinoIcons.circle;
  }
}
