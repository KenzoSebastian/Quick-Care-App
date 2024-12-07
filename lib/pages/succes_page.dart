import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/providers/tab_bar_provider.dart';
import 'package:quickcare_app/widgets/button.dart';

import '../widgets/bottom_navbar.dart';

class SuccesPage extends StatelessWidget {
  const SuccesPage({super.key});
  static const routeName = '/succes';
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final TabBarProvider tabBarProvider =
        Provider.of<TabBarProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: screenSize.width * .6,
                        width: screenSize.width * .6,
                        child: Image.asset('assets/payments/success.png',
                            fit: BoxFit.cover)),
                    SizedBox(height: screenSize.height * .03),
                    Text('Pembayaran Berhasil',
                        style: GoogleFonts.poppins(
                            fontSize: screenSize.width * .05,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              MyButton(
                  text: 'Kembali',
                  margin: EdgeInsets.only(
                      left: screenSize.width * .05,
                      right: screenSize.width * .05,
                      bottom: screenSize.height * .03),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(
                      context,
                      BottomNavbar.routeName,
                    );
                    tabBarProvider.setTabIndex(0);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
