import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class CityNameBloc extends BlocBase{

  final _currentCity = BehaviorSubject<String>();

  Function(String) get setCity => _currentCity.sink.add;
  Stream<String> get getCity => _currentCity.stream;

  CityNameBloc() {
    _currentCity.sink.add('');
  }

  @override
  void dispose() {
    super.dispose();
    _currentCity.close();
  }
}