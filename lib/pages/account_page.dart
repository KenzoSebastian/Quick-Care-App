import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/providers/riwayat_provider.dart';
import 'package:quickcare_app/utils/load_all_data.dart';
import 'package:quickcare_app/widgets/button.dart';
import 'package:quickcare_app/widgets/overlay_message.dart';

import '../providers/dashboard_provider.dart';
import '../widgets/about_dialog.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String? selectedProfilePicture;
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
        onRefresh: () async => await LoadAllData.loadProfilePage(context),
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
                    return Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: screenSize.width * .13,
                          backgroundImage: AssetImage(
                              'assets/profiles/${provider.data['photo_profile'] ?? "default.png"}'),
                        ),
                        Positioned(
                          bottom: -8,
                          right: 0,
                          child: Container(
                            width: screenSize.width * .08,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white),
                            ),
                            child: IconButton(
                              onPressed: () => _changePhoto(
                                context,
                                width: screenSize.width,
                                height: availableHeight,
                              ),
                              icon: Icon(
                                Icons.edit,
                                size: screenSize.width * .045,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
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
                      icon: const Icon(Icons.phone,
                          color: Color.fromARGB(255, 132, 132, 132)),
                      data:
                          '+62 ${provider.data['no_handphone'] ?? '812xxxxxxx'}',
                      width: screenSize.width),
                  _listTileProfile(
                      icon: const Icon(Icons.cake,
                          color: Color.fromARGB(255, 132, 132, 132)),
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
                    icon: const Icon(
                      Icons.edit_document,
                      color: Colors.black,
                    ),
                    data: 'Edit Profile',
                    color: Colors.black,
                    width: screenSize.width,
                    onTap: () {},
                    trailing: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                    )),
                _listTileProfile(
                    icon: const Icon(
                      Icons.message,
                      color: Colors.black,
                    ),
                    data: 'Inbox',
                    color: Colors.black,
                    width: screenSize.width,
                    onTap: () {},
                    trailing: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                    )),
                _listTileProfile(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                    data: 'Pengaturan',
                    color: Colors.black,
                    width: screenSize.width,
                    onTap: () {},
                    trailing: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                    )),
                _listTileProfile(
                    icon: const Icon(
                      Icons.info,
                      color: Colors.black,
                    ),
                    data: 'Tentang',
                    color: Colors.black,
                    width: screenSize.width,
                    onTap: () => AboutDialogCustom.aboutDialog(context),
                    trailing: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                    )),
                _listTileProfile(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    data: 'Keluar',
                    color: Colors.red,
                    width: screenSize.width,
                    onTap: () {},
                    trailing: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.red,
                    )),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  List<Widget> _photoList({required StateSetter setState}) => [
        _wrapItemPhoto(setState: setState, value: 'pp1.png'),
        _wrapItemPhoto(setState: setState, value: 'pp2.png'),
        _wrapItemPhoto(setState: setState, value: 'pp3.png'),
        _wrapItemPhoto(setState: setState, value: 'pp4.png'),
        _wrapItemPhoto(setState: setState, value: 'pp5.png'),
        _wrapItemPhoto(setState: setState, value: 'pp6.png'),
        _wrapItemPhoto(setState: setState, value: 'pp7.png'),
        _wrapItemPhoto(setState: setState, value: 'pp8.png'),
        _wrapItemPhoto(setState: setState, value: 'pp9.png'),
        _wrapItemPhoto(setState: setState, value: 'pp10.png'),
        _wrapItemPhoto(setState: setState, value: 'pp11.png'),
        _wrapItemPhoto(setState: setState, value: 'pp12.png'),
      ];

  GestureDetector _wrapItemPhoto(
      {required StateSetter setState, required String value}) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedProfilePicture = value);
      },
      onForcePressStart: (details) {
        print("ini detail $details");
      },
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            border: selectedProfilePicture == value
                ? Border.all(color: Colors.black, width: 2)
                : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset('assets/profiles/$value', fit: BoxFit.cover)),
    );
  }

  Future<dynamic> _changePhoto(BuildContext context,
      {required double width, required double height}) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return GestureDetector(
          onTap: () => setState(() => selectedProfilePicture = null),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * .05,
              vertical: height * .02,
            ),
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Ganti Foto Profil',
                            style: GoogleFonts.poppins(
                              fontSize: width * .05,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(height: height * .02),
                      SizedBox(
                        height: height * .4,
                        width: double.infinity,
                        child: GridView.count(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 4,
                          physics: const NeverScrollableScrollPhysics(),
                          children: _photoList(setState: setState),
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<LoadDataUser>(builder: (context, provider, child) {
                  return MyButton(
                    text: "Simpan Perubahan",
                    onPressed: () async {
                      if (selectedProfilePicture == null) {
                        Navigator.pop(context);
                        return;
                      }
                      await provider.changePhoto(selectedProfilePicture!);
                      if (provider.statusChangePhoto['status'] == 404) {
                        OverlayMessage().showOverlayMessage(context,
                            'Gagal mengubah foto profil, silakan coba lagi');
                        return;
                      }
                      Navigator.pop(context);
                      await LoadAllData.loadProfilePage(context);
                    },
                  );
                })
              ],
            ),
          ),
        );
      }),
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
      Color color = const Color.fromARGB(255, 132, 132, 132),
      required String data,
      required double width,
      GestureTapCallback? onTap,
      Widget? trailing}) {
    return ListTile(
      onTap: onTap,
      leading: icon,
      title: Text(
        data,
        style: GoogleFonts.poppins(fontSize: width * .04, color: color),
      ),
      trailing: trailing,
    );
  }
}
