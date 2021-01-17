
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: unnecessary_brace_in_string_interps

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get languageCode => 'ru';

  @override
  String get languageAndCountryCode => 'ru_RU';

  @override
  String get showHourlyWeather => 'Показать почасовую погоду';

  @override
  String get showDailyWeather => 'Показать ежедневную погоду';

  @override
  String get feelsLike => 'Ощущается как';

  @override
  String get dayFeelsLike => 'Днём ощущается как';

  @override
  String get nightFeelsLike => 'Ночью ощущается как';

  @override
  String get cloudiness => 'Облачность';

  @override
  String get wind => 'Ветер';

  @override
  String get humidity => 'Влажность';

  @override
  String get uvIndex => 'УФ-индекс';

  @override
  String get sunrise => 'Восход';

  @override
  String get sunset => 'Закат';

  @override
  String get kmPerHour => 'км/ч';

  @override
  String get mon => 'пн';

  @override
  String get tue => 'вт';

  @override
  String get wed => 'ср';

  @override
  String get thu => 'чт';

  @override
  String get fri => 'пт';

  @override
  String get sat => 'сб';

  @override
  String get sun => 'вс';
}
