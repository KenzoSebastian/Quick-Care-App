import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/pages/detail_dokter_page.dart';
import 'package:quickcare_app/providers/dashboard_provider.dart';
import 'package:quickcare_app/providers/dokter_provider.dart';
import 'package:quickcare_app/providers/tab_bar_provider.dart';
import 'package:quickcare_app/widgets/card_dokter.dart';
import 'package:quickcare_app/widgets/weather_widget.dart';
import '../widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final InfiniteScrollController _controller =
      InfiniteScrollController(initialItem: 0);
  // ignore: unused_field
  Timer? _timer;

  GestureDetector _itemList({
    required Icon icon,
    required String title,
    required double width,
    required double height,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: width * .065,
            backgroundColor: Colors.red[100],
            child: icon,
          ),
          SizedBox(height: height * .015),
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: width * .029),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  List<Widget> _menuList(double width, double height) => [
        _itemList(
            icon: const Icon(Icons.chat),
            title: "Chat dengan dokter",
            width: width,
            height: height,
            onTap: () {}),
        _itemList(
            icon: const Icon(Icons.local_pharmacy),
            title: "Toko Obat",
            width: width,
            height: height,
            onTap: () {}),
        _itemList(
            icon: const Icon(Icons.medical_services),
            title: "HomeLab & Vaksinasi",
            width: width,
            height: height,
            onTap: () {}),
        _itemList(
            icon: const Icon(Icons.hearing),
            title: "THT",
            width: width,
            height: height,
            onTap: () {}),
        _itemList(
            icon: const Icon(Icons.emoji_emotions),
            title: "Kesehatan Mental",
            width: width,
            height: height,
            onTap: () {}),
        _itemList(
            icon: const Icon(Icons.face),
            title: "HaloSkin",
            width: width,
            height: height,
            onTap: () {}),
        _itemList(
            icon: const Icon(Icons.favorite),
            title: "Kesehatan Seksual",
            width: width,
            height: height,
            onTap: () {}),
        _itemList(
            icon: const Icon(Icons.remove_red_eye),
            title: "Kesehatan Mata",
            width: width,
            height: height,
            onTap: () {}),
      ];

  List<Widget> _bannerList(height) => [
        SizedBox(
            height: height,
            width: double.infinity,
            child:
                Image.asset('assets/banners/banner1.png', fit: BoxFit.cover)),
        SizedBox(
            height: height,
            width: double.infinity,
            child:
                Image.asset('assets/banners/banner2.png', fit: BoxFit.cover)),
        SizedBox(
            height: height,
            width: double.infinity,
            child:
                Image.asset('assets/banners/banner3.png', fit: BoxFit.cover)),
        SizedBox(
            height: height,
            width: double.infinity,
            child:
                Image.asset('assets/banners/banner4.png', fit: BoxFit.cover)),
        SizedBox(
            height: height,
            width: double.infinity,
            child:
                Image.asset('assets/banners/banner5.png', fit: BoxFit.cover)),
      ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _controller.nextItem();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    final availableHeight = screenSize.height - appBarHeight;
    final TabBarProvider tabBarProvider =
        Provider.of<TabBarProvider>(context, listen: false);

    final hour = DateTime.now().hour;
    String greeting;

    if (hour < 12) {
      greeting = "Selamat Pagi,";
    } else if (hour < 18) {
      greeting = "Selamat Siang,";
    } else {
      greeting = "Selamat Malam,";
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Beranda'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<DokterProvider>(context, listen: false).setDokter();
            },
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * .05),
        child: ListView(
          children: [
            Consumer<LoadDataUser>(builder: (context, dataUser, child) {
              final data = dataUser.data;
              return Padding(
                padding: EdgeInsets.only(top: availableHeight * .05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          greeting,
                          style: GoogleFonts.poppins(
                              fontSize: screenSize.width * .04,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${data['nama'] ?? 'Unknown'}",
                          style: GoogleFonts.poppins(
                              fontSize: screenSize.width * .06,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    WeatherWidget(width: screenSize.width),
                  ],
                ),
              );
            }),
            SizedBox(height: availableHeight * .035),
            Text(
              'Pilih layanan',
              style: GoogleFonts.poppins(
                  fontSize: screenSize.width * .035,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: availableHeight * .025),
            SizedBox(
              height: availableHeight * .33,
              width: double.infinity,
              child: GridView.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 1,
                crossAxisCount: 4,
                childAspectRatio: 3 / 4,
                physics: const NeverScrollableScrollPhysics(),
                children: _menuList(screenSize.width, availableHeight),
              ),
            ),
            Text(
              'Promo Untukmu',
              style: GoogleFonts.poppins(
                  fontSize: screenSize.width * .035,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: availableHeight * .025),
            SizedBox(
              height: availableHeight * .275,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: InfiniteCarousel.builder(
                  controller: _controller,
                  itemCount: _bannerList(availableHeight * .275).length,
                  itemExtent: screenSize.width * .9,
                  itemBuilder: (context, index, realIndex) {
                    return _bannerList(availableHeight * .275)[index];
                  },
                ),
              ),
            ),
            SizedBox(height: availableHeight * .035),
            Text(
              'Rekomendasi Dokter',
              style: GoogleFonts.poppins(
                  fontSize: screenSize.width * .035,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: availableHeight * .025),
            Consumer<DokterProvider>(
              builder: (context, value, child) {
                var dataDokter = value.dokter;
                return value.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return DokterCard(
                                dataDokter: dataDokter[index],
                                routeName: HomePage.routeName,
                                radius: screenSize.width * .09,
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: DetailDokterPage(
                                        dataDokter: dataDokter[index],
                                        routeFrom: HomePage.routeName),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.fade,
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(height: availableHeight * .025),
                          TextButton(
                              onPressed: () {
                                tabBarProvider.setTabIndex(1);
                              },
                              child: const Text('Lihat Semua Dokter')),
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
