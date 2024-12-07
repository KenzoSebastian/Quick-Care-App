import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/utils/location.dart';
import 'package:weather/weather.dart';
import '../providers/dashboard_provider.dart';
import '../providers/dokter_provider.dart';
import '../providers/riwayat_provider.dart';
import '../providers/weather_provider.dart';

class LoadAllData {
  static Future<void> loadAllData(BuildContext context) async {
    int? userId = Provider.of<LoadDataUser>(context, listen: false).userId;
    Provider.of<LoadDataUser>(context, listen: false).setData();
    Weather? weather = await const Location().getWeather();
    weather == null
        ? null
        : Provider.of<WeatherProvider>(context, listen: false).setDataWeather({
            'areaName': weather.areaName,
            'cloudiness': weather.cloudiness,
            'country': weather.country,
            'date': weather.date,
            'humidity': weather.humidity,
            'latitude': weather.latitude,
            'longitude': weather.longitude,
            'temperature': weather.temperature,
            'weatherDescription': weather.weatherDescription,
          });
    await Provider.of<DokterProvider>(context, listen: false).setDokter();
    
    if (userId != null) {
      await Provider.of<RiwayatProvider>(context, listen: false)
          .setRiwayat(userId);
    }
  }
}
