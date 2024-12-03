import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:quickcare_app/widgets/animate_scale.dart';
import './login_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});
  static const routeName = '/intro';
  static final List<PageViewModel> _slidesList = [
    _pageSlide(
        title: 'Selamat Datang di QuickCare',
        body: 'Booking Dokter dengan Mudah dan Cepat',
        image: 'assets/images/intro1.jpg'),
    _pageSlide(
        title: 'Pilih Dokter Spesialis',
        body: 'Temukan Dokter Berkualitas Sesuai Kebutuhan Kesehatan Anda',
        image: 'assets/images/intro2.jpg'),
    _pageSlide(
        title: 'Jadwalkan Konsultasi Kapan Saja',
        body: 'Atur Jadwal Konsultasi Sesuai Pilihan Anda',
        image: 'assets/images/intro3.png'),
    _pageSlide(
        title: 'Pembayaran yang Praktis',
        body: 'Lakukan Pembayaran dengan Mudah Sebelum Konsultasi',
        image: 'assets/images/intro4.png'),
    _pageSlide(
        title: 'Rekam Medis yang Aman',
        body: 'Simpan Riwayat Kesehatan Anda dengan Aman dan Terorganisir',
        image: 'assets/images/intro5.png'),
  ];
  static PageViewModel _pageSlide(
      {required String title, required String body, required String image}) {
    return PageViewModel(
      image: AnimatedScaleCustom(delay: 300, child: Image.asset(image)),
      titleWidget: AnimatedScaleCustom(
          delay: 500,
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )),
      bodyWidget: AnimatedScaleCustom(
          delay: 700,
          child: Text(
            body,
            style: GoogleFonts.poppins(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: IntroductionScreen(
            pages: _slidesList,
            showBackButton: false,
            showNextButton: true,
            showSkipButton: true,
            skip: Text('Skip',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            next: const Icon(Icons.arrow_forward),
            done: Text("Done",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            onDone: () {
              Navigator.pushReplacementNamed(context, LoginPage.routeName);
            },
            dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              activeColor: const Color(0xFF388E3C),
              color: Colors.black26,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
            ),
            baseBtnStyle: TextButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0),
            ),
            skipStyle: TextButton.styleFrom(foregroundColor: Colors.red),
            doneStyle: TextButton.styleFrom(foregroundColor: Colors.green),
            nextStyle: TextButton.styleFrom(foregroundColor: Colors.blue),
          ),
        ));
  }
}
