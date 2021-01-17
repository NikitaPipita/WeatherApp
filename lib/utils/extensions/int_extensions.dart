import '../../constants/week_days.dart';

extension IntExtension on int {
  String hourMinuteTimeFormat() {
    var date = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    var hour = date.hour > 9
        ? date.hour.toString()
        : '0' + date.hour.toString();
    var minute = date.minute > 9
        ? date.minute.toString()
        : '0' + date.minute.toString();
    return hour + ':' + minute;
  }

  String weekDayAndDayNumberTimeFormatBloc() {
    var date = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    var weekDay = weekDays[date.weekday];
    var dayNumber = date.day.toString();
    return weekDay + ' ' + dayNumber;
  }
}