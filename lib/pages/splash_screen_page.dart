import 'package:loading_indicator/loading_indicator.dart';
import 'package:splash_view/splash_view.dart';
import './intro_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  static const String routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    return SplashView(
      logo: Image.asset('assets/images/splash.png'),
      backgroundImageDecoration: const BackgroundImageDecoration(
          image: AssetImage('assets/images/splashBackground.png')),
      done: Done(const IntroPage(),
          animationDuration: const Duration(seconds: 1),
          curve: Curves.linearToEaseOut),
      showStatusBar: true,
      bottomLoading: true,
      loadingIndicator: Container(
        margin: const EdgeInsets.only(bottom: 50),
        width: 75,
        height: 75,
        child: const LoadingIndicator(
          indicatorType: Indicator.lineScale,
          colors: [Colors.white],
        ),
      ),
    );
  }
}
