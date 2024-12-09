import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/widgets/animate_fade.dart';
import '../pages/detail_dokter_page.dart';
import '../providers/dokter_provider.dart';
import '../widgets/build_text_field.dart';
import '../widgets/card_dokter.dart';
import '../providers/tab_bar_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static const routeName = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controllerSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    final availableHeight = screenSize.height - appBarHeight;
    final TabBarProvider tabBarProvider =
        Provider.of<TabBarProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const AnimatedFade(delay: 50, child: Text('search page')),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<DokterProvider>(context, listen: false).setDokter();
            },
          )
        ],
      ),
      body: LiquidPullToRefresh(
        showChildOpacityTransition: false,
        backgroundColor: Colors.green,
        animSpeedFactor: 3,
        springAnimationDurationInMilliseconds: 750,
        color: Colors.grey[200],
        onRefresh: () async => await Provider.of<DokterProvider>(context, listen: false).setDokter(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * .05),
          child: ListView(children: [
            Padding(
              padding: EdgeInsets.only(top: availableHeight * .03),
              child: AnimatedFade(
                delay: 100,
                child: Text(
                  'Cari Dokter',
                  style: GoogleFonts.poppins(
                      fontSize: screenSize.width * .06,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: availableHeight * .025),
            AnimatedFade(
              delay: 200,
              child: BuildTextField(
                controller: controllerSearch,
                label: 'Pencarian',
                hintText: 'Masukan nama dokter atau spesialis dokter',
              ),
            ),
            SizedBox(height: availableHeight * .035),
            Consumer<DokterProvider>(
              builder: (context, value, child) {
                final dokter = value.dokter;
                final dokterFilter = value.filterDokter;
        
                if (value.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (dokter.isEmpty) {
                  return Center(
                    child: Text('Data dokter tidak tersedia.',
                        style: GoogleFonts.poppins(color: Colors.red)),
                  );
                }
        
                if (dokter[0]['error'] != null) {
                  return Center(
                    child: Text(dokter[0]['error'],
                        style: GoogleFonts.poppins(color: Colors.red)),
                  );
                }
        
                if (dokterFilter.isEmpty && controllerSearch.text != '') {
                  return Center(
                    child: Text(
                      'Tidak ada dokter yang cocok bro',
                      style:
                          GoogleFonts.poppins(fontSize: screenSize.width * .04),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controllerSearch.text != ''
                      ? dokterFilter.length
                      : dokter.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return DokterCard(
                      dataDokter: controllerSearch.text != ''
                          ? dokterFilter[index]
                          : dokter[index],
                      routeName: SearchPage.routeName,
                      radius: screenSize.width * 0.09,
                      onTap: () {
                        tabBarProvider.setTabIndex(1);
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: DetailDokterPage(
                              dataDokter: controllerSearch.text != ''
                                  ? dokterFilter[index]
                                  : dokter[index],
                              routeFrom: SearchPage.routeName),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
