import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class AppBarTitleBloc extends BlocBase{

  List<String> modes;

  final _currentMode = BehaviorSubject<String>();

  Function(String) get setMode => _currentMode.sink.add;
  Stream<String> get getMode => _currentMode.stream;

  void createModes(List<String> modesList) {
    modes = modesList;
    _currentMode.sink.add(modes.first);
  }

  @override
  void dispose() {
    super.dispose();
    _currentMode.close();
  }
}