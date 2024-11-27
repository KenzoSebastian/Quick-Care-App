import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/providers/weather_provider.dart';
import 'package:quickcare_app/utils/location.dart';
import 'package:weather/weather.dart';
// import '../widgets/drawer.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});
  static const routeName = '/history';
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('history page'),
      ),
      // drawer: const MyDrawer(),
      body: const Center(child: Text('history')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.logout),
        onPressed: () {
          var data = Provider.of<WeatherProvider>(context, listen: false);
          print(data.dataWeather);
          // Location location = const Location();
          // Weather weather = await location.getWeather();
          // print(weather.temperature);
          //   Weather weather = await location.getWeather();
          //   print(weather.temperature);
          //   print(weather.weatherDescription);
          //   print(weather);
        },
      ),
    );
  }
}
