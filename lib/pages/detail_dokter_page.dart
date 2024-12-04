import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:quickcare_app/pages/order_dokter_page.dart';
import 'package:quickcare_app/utils/formatter.dart';

import '../widgets/animate_fade.dart';

class DetailDokterPage extends StatelessWidget {
  const DetailDokterPage({super.key, this.dataDokter, this.routeFrom});
  static const routeName = '/detail-dokter';
  final Map<String, dynamic>? dataDokter;
  final String? routeFrom;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    final availableHeight = screenSize.height - appBarHeight;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        title: const AnimatedFade(delay: 50, child: Text('Detail Dokter')),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * .05,
        ),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: availableHeight * .03),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: Hero(
                        tag: '${dataDokter!['id']} $routeFrom',
                        child: Image.network(
                          dataDokter!['url_foto'] ?? '',
                          height: availableHeight * .3,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Image.asset('assets/images/dokter.png');
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: availableHeight * .025),
                    AnimatedFade(
                      delay: 100,
                      child: Text(
                        dataDokter!['nama'] ?? 'nama dokter',
                        style: GoogleFonts.poppins(
                            fontSize: screenSize.width * .06,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: availableHeight * .007),
                    AnimatedFade(
                      delay: 200,
                      child: Text(
                        dataDokter!['spesialis'] ?? 'spesialis dokter',
                        style: GoogleFonts.poppins(
                          fontSize: screenSize.width * .04,
                        ),
                      ),
                    ),
                    SizedBox(height: availableHeight * .025),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedFade(
                          delay: 300,
                          child: Text(Formatter.rupiah(dataDokter!['harga'] ?? 0),
                              style: GoogleFonts.poppins(
                                fontSize: screenSize.width * .05,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        AnimatedFade(
                          delay: 400,
                          child: ElevatedButton(
                              onPressed: () {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: OrderDokter(
                                    dataDokter: dataDokter!,
                                    routeFrom: routeFrom,
                                  ),
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                  withNavBar: false,
                                );
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.green),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                              ),
                              child: const Text('Pesan Sekarang',
                                  style: TextStyle(color: Colors.white))),
                        ),
                      ],
                    ),
                    Divider(
                      height: availableHeight * .04,
                      color: Colors.black,
                    ),
                    AnimatedFade(
                      delay: 500,
                      child: _deskripsiDokter(
                          screenSize: screenSize,
                          icon: const Icon(Icons.school),
                          title: 'Alumni',
                          dataDokter: dataDokter!['alumni'] ?? ''),
                    ),
                    SizedBox(height: availableHeight * .025),
                    AnimatedFade(
                      delay: 600,
                      child: _deskripsiDokter(
                          screenSize: screenSize,
                          icon: const Icon(Icons.location_on),
                          title: 'Tempat Praktek',
                          dataDokter: dataDokter!['tempat_praktek'] ?? ''),
                    ),
                    SizedBox(height: availableHeight * .025),
                    AnimatedFade(
                      delay: 700,
                      child: _deskripsiDokter(
                          screenSize: screenSize,
                          icon: const Icon(Icons.work),
                          title: 'Pengalaman',
                          dataDokter: '${dataDokter!['pengalaman']} Tahun'),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _deskripsiDokter(
      {required Size screenSize,
      required Icon icon,
      required String title,
      required String dataDokter}) {
    return ListTile(
      leading: icon,
      title: Text(title,
          style: GoogleFonts.poppins(
            fontSize: screenSize.width * .05,
            fontWeight: FontWeight.bold,
          )),
      subtitle: Text(
        dataDokter,
        style: GoogleFonts.poppins(
          fontSize: screenSize.width * .04,
        ),
      ),
    );
  }
}
