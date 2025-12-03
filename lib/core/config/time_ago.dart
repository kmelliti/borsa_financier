import 'package:get/get.dart';

class TimeAgo {
  static String since(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 5) {
      return "just_now".tr;
    }
    else if (diff.inSeconds < 60) {
      return "seconds_ago".trParams({
        "n": diff.inSeconds.toString(),
      });
    }
    else if (diff.inMinutes < 60) {
      return "minutes_ago".trParams({
        "n": diff.inMinutes.toString(),
      });
    }
    else if (diff.inHours < 24) {
      return "hours_ago".trParams({
        "n": diff.inHours.toString(),
      });
    }
    else if (diff.inDays < 30) {
      return "days_ago".trParams({
        "n": diff.inDays.toString(),
      });
    }
    else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return "months_ago".trParams({
        "n": months.toString(),
      });
    }
    else {
      final years = (diff.inDays / 365).floor();
      return "years_ago".trParams({
        "n": years.toString(),
      });
    }
  }
}
