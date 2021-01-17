import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  String weekDayAndDayNumberTimeFormatBloc(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    var weekDay = weekDays[date.weekday];
    var dayNumber = date.day.toString();
    var localizedWeekDay;
    switch (weekDay) {
      case 'mon':
        localizedWeekDay = AppLocalizations.of(context).mon;
        break;
      case 'tue':
        localizedWeekDay = AppLocalizations.of(context).tue;
        break;
      case 'wed':
        localizedWeekDay = AppLocalizations.of(context).wed;
        break;
      case 'thu':
        localizedWeekDay = AppLocalizations.of(context).thu;
        break;
      case 'fri':
        localizedWeekDay = AppLocalizations.of(context).fri;
        break;
      case 'sat':
        localizedWeekDay = AppLocalizations.of(context).sat;
        break;
      case 'sun':
        localizedWeekDay = AppLocalizations.of(context).sun;
        break;
    }
    return localizedWeekDay + ' ' + dayNumber;
  }
}