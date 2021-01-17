import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../../blocs/main_screen_blocs/app_bar_title_bloc.dart';

class WeatherDisplayModeDropdownButton extends StatelessWidget {
  final _titleBloc = BlocProvider.getBloc<AppBarTitleBloc>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _titleBloc.getMode,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DropdownButton<String>(
            value: snapshot.data,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16.0,
            ),
            selectedItemBuilder: (context) {
              return _titleBloc.modes.map((String value) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    snapshot.data,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                );
              }).toList();
            },
            items: _titleBloc.modes.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: _titleBloc.setMode,
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.grey[300],
            ),
          );
        }
        return Container();
      },
    );
  }
}