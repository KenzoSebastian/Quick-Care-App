import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/animate_fade.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});
  static const routeName = '/inbox';

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    final availableHeight = screenSize.height - appBarHeight;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Inbox'),
          backgroundColor: Colors.lightBlue,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * .05),
          child: ListView(children: [
            Padding(
              padding: EdgeInsets.only(top: availableHeight * .03, bottom: availableHeight * .03),
              child: AnimatedFade(
                delay: 100,
                child: Text(
                  'Inbox',
                  style: GoogleFonts.poppins(
                      fontSize: screenSize.width * .06,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Center(
              child: Text('Inbox belum ada.',
                  style: GoogleFonts.poppins(color: Colors.red)),
            )
          ]),
        ));
  }
}
