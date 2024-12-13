import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/providers/tab_bar_provider.dart';
import 'package:quickcare_app/widgets/about_dialog.dart';
import '../pages/login_page.dart';
import '../providers/dashboard_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final heightFull = screenSize.height;
    final TabBarProvider tabBarProvider =
        Provider.of<TabBarProvider>(context, listen: false);
    return Drawer(
      child: Column(
        children: <Widget>[
          Consumer<LoadDataUser>(
            builder: (context, loadData, child) {
              final data = loadData.data;
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  tabBarProvider.setTabIndex(3);
                },
                child: Container(
                    padding: const EdgeInsets.all(16.0),
                    color: const Color.fromARGB(255, 1, 163, 199),
                    width: double.infinity,
                    height: heightFull * .25,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(
                                'assets/profiles/${data['photo_profile'] ?? ''}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['nama'] ?? '',
                                    style: GoogleFonts.lato(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                Text(data['email'] ?? '',
                                    style: GoogleFonts.lato(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ),
                        ])),
              );
            },
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Beranda'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Booking Dokter'),
                  onTap: () {
                    Navigator.pop(context);
                    tabBarProvider.setTabIndex(1);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About'),
                  onTap: () {
                    Navigator.pop(context);
                    AboutDialogCustom.aboutDialog(context);
                    tabBarProvider.setTabIndex(0);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const LoginPage(),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  },
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Version 1.0.0'),
          ),
        ],
      ),
    );
  }
}
