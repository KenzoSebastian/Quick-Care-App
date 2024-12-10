import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import '../utils/formatter.dart';
import './key_value_widget.dart';
import './overlay_message.dart';
import '../pages/edit_order_page.dart';
import '../pages/history_page.dart';
import '../providers/riwayat_provider.dart';
import '../providers/tab_bar_provider.dart';
import './bottom_navbar.dart';
import './button.dart';

class CardRiwayat extends StatelessWidget {
  const CardRiwayat({
    super.key,
    required this.data,
    required this.height,
    required this.width,
    required this.provider,
    required this.routeFrom,
  });
  final Map<String, dynamic> data;
  final double height;
  final double width;
  final RiwayatProvider provider;
  final String routeFrom;

  @override
  Widget build(BuildContext context) {
    String date = data['created_at'];
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(bottom: height * .02),
      color: data['is_done'] ? Colors.green[100] : Colors.red[100],
      child: GestureDetector(
        onTap: () => _modalBottom(context,
            width: width,
            height: height,
            data: data,
            riwayatProvider: provider,
            routeFrom: routeFrom),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Konsultasi dengan',
                  style: GoogleFonts.poppins(
                    fontSize: width * .035,
                  ),
                ),
                Text(DateFormat('Hm').format(DateTime.parse(date)),
                    style: GoogleFonts.poppins(fontSize: width * .035))
              ],
            ),
            SizedBox(height: height * .012),
            Text(
              data['Dokter']['nama'] ?? 'Nama Dokter',
              style: GoogleFonts.poppins(
                  fontSize: width * .04, fontWeight: FontWeight.bold),
            ),
            Text(
              data['Dokter']['spesialis'] ?? 'Spesialis Dokter',
              style: GoogleFonts.poppins(
                fontSize: width * .04,
              ),
            ),
            SizedBox(height: height * .012),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    'Pada',
                    style: GoogleFonts.poppins(
                      fontSize: width * .035,
                    ),
                  ),
                  Text(
                    DateFormat('dd MMMM yyyy')
                        .format(DateTime.parse(data['tanggal_konsultasi'])),
                    style: GoogleFonts.poppins(
                      fontSize: width * .035,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ]),
                Container(
                  decoration: BoxDecoration(
                    color:
                        data['is_done'] ? Colors.lightGreen : Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    data['is_done'] ? 'Selesai' : 'Belum Selesai',
                    style: GoogleFonts.poppins(
                      fontSize: width * .04,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Future<dynamic> _modalBottom(BuildContext context,
      {required double width,
      required double height,
      required Map<String, dynamic> data,
      required RiwayatProvider riwayatProvider,
      required String routeFrom}) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        // Parsing tanggal dan waktu konsultasi
        final DateTime tanggalKonsultasi =
            DateTime.parse(data['tanggal_konsultasi']);
        final List<String> waktuKonsultasi =
            data['waktu_konsultasi'].split(':');
        final DateTime waktuKonsultasiDateTime = DateTime(
          tanggalKonsultasi.year,
          tanggalKonsultasi.month,
          tanggalKonsultasi.day,
          int.parse(waktuKonsultasi[0]),
          int.parse(waktuKonsultasi[1]),
        );

        // Mendapatkan waktu sekarang
        final DateTime now = DateTime.now();

        // Menghitung batas waktu edit
        final DateTime batasEdit =
            waktuKonsultasiDateTime.subtract(const Duration(hours: 1));

        // Menentukan apakah tombol edit harus ditampilkan
        final bool canEdit =
            now.isBefore(batasEdit) || tanggalKonsultasi.isAfter(now);

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * .05,
            vertical: height * .02,
          ),
          width: double.infinity,
          child: canEdit
              ? Column(
                  children: [
                    Expanded(
                      child: _detailDataRiwayat(width, height, data),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * .44,
                          child: MyButton(
                            onPressed: () {
                              (routeFrom == HistoryPage.routeName)
                                  ? Provider.of<TabBarProvider>(context,
                                          listen: false)
                                      .setTabIndex(2)
                                  : Provider.of<TabBarProvider>(context,
                                          listen: false)
                                      .setTabIndex(0);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return _alertBatalPesan(
                                        context, riwayatProvider, data);
                                  });
                            },
                            text: 'Batal Pesan',
                            color: Colors.redAccent,
                          ),
                        ),
                        SizedBox(
                          width: width * .44,
                          child: MyButton(
                            onPressed: () {
                              (routeFrom == HistoryPage.routeName)
                                  ? Provider.of<TabBarProvider>(context,
                                          listen: false)
                                      .setTabIndex(2)
                                  : Provider.of<TabBarProvider>(context,
                                          listen: false)
                                      .setTabIndex(0);
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: EditOrder(
                                  dataDokter: data['Dokter'],
                                  routeFrom: routeFrom,
                                  tanggal_konsultasi:
                                      data['tanggal_konsultasi'],
                                  waktu_konsultasi: data['waktu_konsultasi'],
                                  id_riwayat: data['id'],
                                ),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade,
                              );
                            },
                            text: 'Edit Pesanan',
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : _detailDataRiwayat(width, height, data),
        );
      },
    );
  }

  AlertDialog _alertBatalPesan(BuildContext context,
      RiwayatProvider riwayatProvider, Map<String, dynamic> data) {
    return AlertDialog(
      title: const Text('Batalkan Pesanan'),
      content: const Text('Apakah anda yakin ingin membatalkan pesanan ini?'),
      actions: [
        TextButton(
          child: const Text('Batal'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text('Iya'),
          onPressed: () async {
            await riwayatProvider.deleteRiwayat(id: data['id']);
            Navigator.pop(context);
            Navigator.pushReplacementNamed(
              context,
              BottomNavbar.routeName,
            );
            if (riwayatProvider.statusDelete['message'] == 'Success') {
              OverlayMessage().showOverlayMessage(
                  context, 'Pesanan berhasil dibatalkan',
                  color: Colors.green);
              return;
            }
            OverlayMessage().showOverlayMessage(
                context, 'Pesanan gagal dibatalkan, silahkan coba lagi',
                color: Colors.red);
          },
        ),
      ],
    );
  }

  SingleChildScrollView _detailDataRiwayat(
      double width, double height, Map<String, dynamic> data) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            'Detail Riwayat',
            style: GoogleFonts.poppins(
              fontSize: width * .05,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Divider(
          height: height * .03,
          color: Colors.black,
        ),
        KeyValue(
            width: width,
            keyword: "Nama Dokter",
            value: data['Dokter']['nama'] ?? 'Nama Dokter'),
        SizedBox(height: height * .005),
        KeyValue(
            width: width,
            keyword: "Tanggal Konsultasi",
            value: DateFormat('dd-MMM-yyyy')
                .format(DateTime.parse(data['tanggal_konsultasi']))),
        SizedBox(height: height * .005),
        KeyValue(
            width: width,
            keyword: "Waktu Konsultasi",
            value: data['waktu_konsultasi'] ?? 'Waktu Konsultasi'),
        Divider(
          height: height * .025,
          color: Colors.black,
        ),
        KeyValue(
            width: width,
            keyword: "Biaya Konsultasi",
            value: Formatter.rupiah(data['Dokter']['harga'] ?? 0)),
        SizedBox(height: height * .005),
        KeyValue(
            width: width,
            keyword: "Biaya Penanganan",
            value: Formatter.rupiah(data['biaya_penanganan'] ?? 0)),
        Row(
          children: [
            SizedBox(
              width: width * .7,
              child: const Divider(
                height: 0,
                color: Colors.black,
              ),
            ),
            SizedBox(width: width * .02),
            Text(
              "+",
              style: GoogleFonts.ptSans(
                fontSize: width * .06,
              ),
            ),
          ],
        ),
        KeyValue(
            width: width,
            keyword: "Total Biaya",
            value: Formatter.rupiah(data['total_biaya'] ?? 0)),
        Divider(
          height: height * .025,
          color: Colors.black,
        ),
        KeyValue(
            width: width,
            keyword: "Metode Pembayaran",
            value: data['metode_pembayaran'] ?? 'cash'),
      ]),
    );
  }
}
