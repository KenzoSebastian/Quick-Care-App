import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/providers/riwayat_provider.dart';
import 'package:quickcare_app/utils/load_all_data.dart';
// import 'package:quickcare_app/widgets/bottom_navbar.dart';

import '../providers/dashboard_provider.dart';
import '../widgets/about_dialog.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double appBarHeight = AppBar().preferredSize.height;
    final double availableHeight = screenSize.height - appBarHeight;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.purple,
      ),
      // drawer: const MyDrawer(),
      body: LiquidPullToRefresh(
        backgroundColor: Colors.purple,
        showChildOpacityTransition: false,
        animSpeedFactor: 3,
        springAnimationDurationInMilliseconds: 750,
        color: Colors.grey[200],
        onRefresh: () async => LoadAllData.loadProfilePage(context),
        child: ListView(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * .05),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 1, 163, 199),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: availableHeight * .05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Consumer<LoadDataUser>(builder: (context, provider, child) {
                    return CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(
                          'assets/profiles/${provider.data['photo_profile'] ?? 'pp1.png'}'),
                      radius: screenSize.width * .13,
                    );
                  }),
                  SizedBox(width: screenSize.width * .05),
                  Expanded(
                    child: Consumer<LoadDataUser>(
                        builder: (context, provider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.data['nama'] ?? 'Nama user',
                            style: GoogleFonts.poppins(
                                fontSize: screenSize.width * .06,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            provider.data['email'] ?? 'user@gmail.com',
                            style: GoogleFonts.poppins(
                                fontSize: screenSize.width * .04,
                                color: const Color(0xFFDEDEDE)),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: SvgPicture.asset(
              'assets/profiles/wave.svg',
              height: availableHeight * .1,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * .03),
            child: Consumer<LoadDataUser>(builder: (context, provider, child) {
              return Column(
                children: [
                  _listTileProfile(
                      icon: const Icon(Icons.phone),
                      data:
                          '+62 ${provider.data['no_handphone'] ?? '812xxxxxxx'}',
                      width: screenSize.width),
                  _listTileProfile(
                      icon: const Icon(Icons.cake),
                      data: DateFormat('dd MMMM yyyy').format(DateTime.parse(
                          provider.data['tanggal_lahir'] ?? '2000-01-01')),
                      width: screenSize.width),
                ],
              );
            }),
          ),
          const Divider(
            thickness: 2,
            color: Colors.grey,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _jumlahKonsultasi(
                    title: 'Belum Selesai',
                    width: screenSize.width,
                    height: availableHeight),
                Container(
                  width: 0,
                  height: availableHeight * .1,
                  decoration: const BoxDecoration(
                      border: Border.symmetric(
                          vertical: BorderSide(color: Colors.grey))),
                ),
                _jumlahKonsultasi(
                    title: 'Total',
                    width: screenSize.width,
                    height: availableHeight),
              ]),
          const Divider(
            thickness: 2,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * .03),
            child: Column(
              children: [
                _listTileProfile(
                    icon: const Icon(Icons.message),
                    data: 'Inbox',
                    width: screenSize.width,
                    onTap: () {}),
                _listTileProfile(
                    icon: const Icon(Icons.settings),
                    data: 'Pengaturan',
                    width: screenSize.width,
                    onTap: () {}),
                _listTileProfile(
                    icon: const Icon(Icons.info),
                    data: 'Tentang',
                    width: screenSize.width,
                    onTap: () => AboutDialogCustom.aboutDialog(context)),
                _listTileProfile(
                    icon: const Icon(Icons.logout),
                    data: 'Keluar',
                    width: screenSize.width,
                    onTap: () {}),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  SizedBox _jumlahKonsultasi(
      {required String title, required double width, required double height}) {
    return SizedBox(
      width: width * .3,
      height: height * .1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<RiwayatProvider>(builder: (context, provider, child) {
            List<Map<String, dynamic>> data;
            title == 'Belum Selesai'
                ? data = provider.riwayatProgress
                : data = provider.riwayat;
            return Text('${data.length} Pesanan',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: width * .045, fontWeight: FontWeight.bold));
          }),
          Text(title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: width * .04))
        ],
      ),
    );
  }

  ListTile _listTileProfile(
      {required Icon icon,
      required String data,
      required double width,
      GestureTapCallback? onTap}) {
    return ListTile(
      onTap: onTap,
      leading: icon,
      title: Text(
        data,
        style: GoogleFonts.poppins(
          fontSize: width * .04,
        ),
      ),
    );
  }
}
