import 'package:timeago/timeago.dart' as timeago;
//-----------------------------------------------

class TimeAgoUtil {
  TimeAgoUtil({bool shortFormat = false}) {
    if (shortFormat) {
      timeago.setLocaleMessages("en", timeago.EnShortMessages());
      timeago.setLocaleMessages("ar", timeago.ArShortMessages());
    } else {
      timeago.setLocaleMessages("en", timeago.EnMessages());
      timeago.setLocaleMessages("ar", timeago.ArMessages());
    }
  }

  String formatTime(DateTime dateTime, String langCode) {
    return timeago.format(dateTime, locale: langCode);
  }
}
