import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/providers/weather_provider.dart';
import 'package:weather_animation/weather_animation.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key, required this.width});
  final double width;

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, provider, child) {
      var weather = provider.dataWeather;
      if (weather.isEmpty) {
        return const SizedBox.shrink();
      } else {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            weather['weatherDescription'].toLowerCase().contains('rain')
                ? _Rainy()
                : weather['weatherDescription'].toLowerCase().contains('cloud')
                    ? _CloudySunny()
                    : _Sunny(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  weather['areaName'],
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: width * .035,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '${weather['temperature'].toString().split(" ")[0]}°C',
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: width * .03,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        );
      }
    });
  }

  WrapperScene _Rainy() {
    return const WrapperScene(
      sizeCanvas: Size(75, 75),
      isLeftCornerGradient: true,
      colors: [],
      children: [
        RainWidget(
          rainConfig: RainConfig(
              count: 30,
              lengthDrop: 4,
              widthDrop: 3,
              color: Color(0xff9e9e9e),
              isRoundedEndsDrop: true,
              widgetRainDrop: null,
              fallRangeMinDurMill: 234,
              fallRangeMaxDurMill: 1500,
              areaXStart: -52.6,
              areaXEnd: 135,
              areaYStart: 27,
              areaYEnd: 89,
              slideX: 2,
              slideY: 0,
              slideDurMill: 2000,
              slideCurve: Cubic(0.40, 0.00, 0.20, 1.00),
              fallCurve: Cubic(0.55, 0.09, 0.68, 0.53),
              fadeCurve: Cubic(0.95, 0.05, 0.80, 0.04)),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
              size: 47,
              color: Color(0xcdbdbdbd),
              icon: IconData(63056, fontFamily: 'MaterialIcons'),
              widgetCloud: null,
              x: 20,
              y: -7,
              scaleBegin: 1,
              scaleEnd: 1.1,
              scaleCurve: Cubic(0.40, 0.00, 0.20, 1.00),
              slideX: 11,
              slideY: 13,
              slideDurMill: 4000,
              slideCurve: Cubic(0.40, 0.00, 0.20, 1.00)),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
              size: 34,
              color: Color.fromARGB(161, 154, 145, 145),
              icon: IconData(63056, fontFamily: 'MaterialIcons'),
              widgetCloud: null,
              x: 0,
              y: 0,
              scaleBegin: 1,
              scaleEnd: 1.08,
              scaleCurve: Cubic(0.40, 0.00, 0.20, 1.00),
              slideX: 20,
              slideY: 0,
              slideDurMill: 3000,
              slideCurve: Cubic(0.40, 0.00, 0.20, 1.00)),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
              size: 40,
              color: Color.fromARGB(205, 178, 176, 176),
              icon: IconData(63056, fontFamily: 'MaterialIcons'),
              widgetCloud: null,
              x: 0,
              y: 0,
              scaleBegin: 1,
              scaleEnd: 1.1,
              scaleCurve: Cubic(0.40, 0.00, 0.20, 1.00),
              slideX: 20,
              slideY: 4,
              slideDurMill: 2000,
              slideCurve: Cubic(0.40, 0.00, 0.20, 1.00)),
        ),
      ],
    );
  }

  WrapperScene _Sunny() {
    return const WrapperScene(
      sizeCanvas: Size(75, 75),
      isLeftCornerGradient: false,
      colors: [],
      children: [
        SunWidget(
          sunConfig: SunConfig(
              width: 80,
              blurSigma: 17,
              blurStyle: BlurStyle.solid,
              isLeftLocation: false,
              coreColor: Color(0xfff57c00),
              midColor: Color(0xffffee58),
              outColor: Color(0xffffa726),
              animMidMill: 3958,
              animOutMill: 1749),
        ),
      ],
    );
  }

  WrapperScene _CloudySunny() {
    return const WrapperScene(
      sizeCanvas: Size(75, 75),
      colors: [],
      children: [
        SunWidget(
          sunConfig: SunConfig(
              width: 80,
              blurSigma: 5,
              blurStyle: BlurStyle.solid,
              isLeftLocation: false,
              coreColor: Color(0xffffa726),
              midColor: Color(0xd6ffee58),
              outColor: Color(0xffff9800),
              animMidMill: 1400,
              animOutMill: 2000),
        ),
        WindWidget(
          windConfig: WindConfig(
              width: 1,
              y: 0,
              windGap: 10,
              blurSigma: 9,
              color: Color(0xff607d8b),
              slideXStart: 0,
              slideXEnd: 350,
              pauseStartMill: 50,
              pauseEndMill: 6000,
              slideDurMill: 1000,
              blurStyle: BlurStyle.solid),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
              size: 42,
              color: Color(0x5c212121),
              icon: IconData(63056, fontFamily: 'MaterialIcons'),
              widgetCloud: null,
              x: 0,
              y: 20,
              scaleBegin: 1,
              scaleEnd: 1.3,
              scaleCurve: Cubic(0.40, 0.00, 0.20, 1.00),
              slideX: 20,
              slideY: 0,
              slideDurMill: 4000,
              slideCurve: Cubic(0.40, 0.00, 0.20, 1.00)),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
              size: 42,
              color: Color(0x5e212121),
              icon: IconData(63056, fontFamily: 'MaterialIcons'),
              widgetCloud: null,
              x: 11,
              y: -5,
              scaleBegin: 1,
              scaleEnd: 1.2,
              scaleCurve: Cubic(0.40, 0.00, 0.20, 1.00),
              slideX: 20,
              slideY: 4,
              slideDurMill: 3000,
              slideCurve: Cubic(0.40, 0.00, 0.20, 1.00)),
        ),
        WindWidget(
          windConfig: WindConfig(
              width: 2,
              y: 13,
              windGap: 15,
              blurSigma: 7,
              color: Color(0xff607d8b),
              slideXStart: 0,
              slideXEnd: 350,
              pauseStartMill: 50,
              pauseEndMill: 6000,
              slideDurMill: 1000,
              blurStyle: BlurStyle.solid),
        ),
      ],
    );
  }
}
