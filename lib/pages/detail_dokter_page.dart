import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:quickcare_app/pages/order_dokter_page.dart';
import 'package:quickcare_app/utils/formatter.dart';

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
        title: const Text('Detail Dokter'),
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
                        tag: '$routeFrom ${dataDokter!['id']}',
                        child: SizedBox(
                          height: availableHeight * .3,
                          child: Image.network(
                            dataDokter!['url_foto'] ?? '',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: availableHeight * .025),
                    Text(
                      dataDokter!['nama'] ?? 'nama dokter',
                      style: GoogleFonts.poppins(
                          fontSize: screenSize.width * .06,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: availableHeight * .007),
                    Text(
                      dataDokter!['spesialis'] ?? 'spesialis dokter',
                      style: GoogleFonts.poppins(
                        fontSize: screenSize.width * .04,
                      ),
                    ),
                    SizedBox(height: availableHeight * .025),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Formatter.rupiah(dataDokter!['harga'] ?? 0),
                            style: GoogleFonts.poppins(
                              fontSize: screenSize.width * .05,
                              fontWeight: FontWeight.bold,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                              screen: OrderDokter(
                                dataDokter: dataDokter!,
                                routeFrom: routeFrom,
                              ),
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade,
                                withNavBar: true,
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
                      ],
                    ),
                    Divider(
                      height: availableHeight * .04,
                      color: Colors.black,
                    ),
                    _deskripsiDokter(
                        screenSize: screenSize,
                        icon: const Icon(Icons.school),
                        title: 'Alumni',
                        dataDokter: dataDokter!['alumni'] ?? ''),
                    SizedBox(height: availableHeight * .025),
                    _deskripsiDokter(
                        screenSize: screenSize,
                        icon: const Icon(Icons.location_on),
                        title: 'Tempat Praktek',
                        dataDokter: dataDokter!['tempat_praktek'] ?? ''),
                    SizedBox(height: availableHeight * .025),
                    _deskripsiDokter(
                        screenSize: screenSize,
                        icon: const Icon(Icons.work),
                        title: 'Pengalaman',
                        dataDokter: '${dataDokter!['pengalaman']} Tahun'),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Row _deskripsiDokter(
      {required Size screenSize,
      required Icon icon,
      required String title,
      required String dataDokter}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: screenSize.width * .05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenSize.height * .01),
            Text(
              dataDokter,
              style: GoogleFonts.poppins(
                fontSize: screenSize.width * .04,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
