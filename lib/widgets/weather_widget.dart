import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const WrapperScene(
      sizeCanvas: Size(75, 75),
      colors: [],
      children: [
        SunWidget(
          sunConfig: SunConfig(
              width: 57,
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
              size: 45,
              color: Color(0x5c212121),
              icon: IconData(63056, fontFamily: 'MaterialIcons'),
              widgetCloud: null,
              x: 0,
              y: 11,
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
              size: 42,
              color: Color(0x5e212121),
              icon: IconData(63056, fontFamily: 'MaterialIcons'),
              widgetCloud: null,
              x: 11,
              y: 26,
              scaleBegin: 1,
              scaleEnd: 1.1,
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
