import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../../blocs/main_screen_blocs/city_name_bloc.dart';

class CityName extends StatelessWidget {
  final _cityNameBloc = BlocProvider.getBloc<CityNameBloc>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _cityNameBloc.getCity,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data);
        }
        return Text('');
      },
    );
  }
}