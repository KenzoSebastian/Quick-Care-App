import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/providers/weather_provider.dart';
import './providers/dokter_provider.dart';
import './providers/tab_bar_provider.dart';
import './widgets/bottom_navbar.dart';
import './pages/splash_screen_page.dart';
import './providers/input_provider.dart';
import './providers/dashboard_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './pages/register_page.dart';
import './providers/login_provider.dart';
import './providers/register_provider.dart';
import './pages/login_page.dart';
import './pages/intro_page.dart';
import 'providers/riwayat_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: "${dotenv.env['SUPABASE_URL']}",
    anonKey: "${dotenv.env['SUPABASE_ANON_KEY']}",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LoginProvider()),
        ChangeNotifierProvider.value(value: RegisterProvider()),
        ChangeNotifierProvider.value(value: InputProvider()),
        ChangeNotifierProvider.value(value: LoadDataUser()),
        ChangeNotifierProvider.value(value: TabBarProvider()),
        ChangeNotifierProvider.value(value: DokterProvider()),
        ChangeNotifierProvider.value(value: WeatherProvider()),
        ChangeNotifierProvider.value(value: RiwayatProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quick Care App',
        theme: ThemeData(
          useMaterial3: true,
          secondaryHeaderColor: const Color(0xFF2196F3),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Color(0xFF666666),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF4CAF50)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF2196F3)),
            ),
            labelStyle: const TextStyle(color: Color(0xFF666666)),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xFF4CAF50),
            iconTheme: const IconThemeData(color: Colors.white),
            titleTextStyle: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            centerTitle: true,
          ),
        ),
        // initialRoute: SplashPage.routeName,
        initialRoute: BottomNavbar.routeName,
        routes: {
          SplashPage.routeName: (_) => const SplashPage(),
          IntroPage.routeName: (_) => const IntroPage(),
          LoginPage.routeName: (_) => const LoginPage(),
          RegisterPage.routeName: (_) => const RegisterPage(),
          BottomNavbar.routeName: (_) => const BottomNavbar(),
        },
      ),
    );
  }
}
