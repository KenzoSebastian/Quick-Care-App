import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

class Location {
  const Location();
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<Weather?> getWeather() async {
    await dotenv.load(fileName: ".env");
    String key = '${dotenv.env['WEATHER_API_KEY']}';
    WeatherFactory wf = WeatherFactory(key);
    try {
      Position position = await _determinePosition();
      double latitude = position.latitude;
      double longitude = position.longitude;
      return await wf.currentWeatherByLocation(latitude, longitude);
    } catch (e) {
      // return await wf.currentWeatherByLocation(51.507351, -0.127758);
      return null;
    }
  }
}
