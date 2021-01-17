import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class WeatherMainInfoWidget extends StatelessWidget {
  final String temperature;
  final String iconUrl;
  final String precipitationProbability;

  WeatherMainInfoWidget({
    @required this.temperature,
    @required this.iconUrl,
    @required this.precipitationProbability,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          temperature,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ),
        Image.network(
          iconUrl,
          height: 60.0,
        ),
        Row(
          children: [
            Icon(
              FontAwesome.tint,
              size: 15.0,
              color: Colors.blue[800],
            ),
            Text(
              precipitationProbability,
              style: TextStyle(
                  fontSize: 15.0
              ),
            )
          ],
        ),
      ],
    );
  }
}
