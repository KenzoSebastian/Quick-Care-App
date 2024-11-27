import 'package:flutter/material.dart';

class WeatherProvider with ChangeNotifier {
  final Map<String, dynamic> _dataWeather = {};
  Map<String, dynamic> get dataWeather => _dataWeather;

  void setDataWeather(Map<String, dynamic> data) {
    if (data.isNotEmpty) {
      _dataWeather.clear();
      _dataWeather.addAll(data);
      notifyListeners();
    }
  }

}
