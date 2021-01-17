import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class AppBarTitleBloc extends BlocBase{

  var modes = ['Show hourly weather', 'Show daily weather'];

  final _currentMode = BehaviorSubject<String>();

  Function(String) get setMode => _currentMode.sink.add;
  Stream<String> get getMode => _currentMode.stream;

  AppBarTitleBloc() {
    _currentMode.sink.add(modes[0]);
  }

  @override
  void dispose() {
    super.dispose();
    _currentMode.close();
  }
}