import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../constants/cities_coordinates.dart';

Future<Position> determineCurrentPosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  Position kievPosition =
      Position(longitude: Kiev.longitude, latitude: Kiev.latitude);
  if (!serviceEnabled) {
    return kievPosition;
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return kievPosition;
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return kievPosition;
    }
  }

  return await Geolocator.getCurrentPosition();
}

Future<String> determineCityByCoordinates(
    double latitude, double longitude, String languageAndCountryCode) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude, longitude,
      localeIdentifier: languageAndCountryCode);
  return placemarks.last.locality;
}