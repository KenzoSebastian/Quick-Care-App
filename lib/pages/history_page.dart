import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/utils/formatter.dart';
import '../providers/riwayat_provider.dart';
import '../widgets/animate_fade.dart';
import '../widgets/button.dart';
import '../widgets/key_value_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});
  static const routeName = '/history';

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    final availableHeight = screenSize.height - appBarHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('History Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await Provider.of<RiwayatProvider>(context, listen: false)
                  .setRiwayat();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * .05),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: availableHeight * .03),
              child: AnimatedFade(
                delay: 100,
                child: Text(
                  'Riwayat Pembayaran',
                  style: GoogleFonts.poppins(
                      fontSize: screenSize.width * .06,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            AnimatedFade(
              delay: 200,
              child: Consumer<RiwayatProvider>(
                builder: (context, provider, child) {
                  final data = provider.riwayat;
                  if (data.isEmpty) {
                    return Center(
                      child: Text('Data riwayat kosong.',
                          style: GoogleFonts.poppins(color: Colors.red)),
                    );
                  }

                  if (data[0]['error'] != null) {
                    return Center(
                      child: Text(data[0]['error'],
                          style: GoogleFonts.poppins(color: Colors.red)),
                    );
                  }

                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  String? previousDate;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      String date = data[index]['created_at'];
                      String formattedDate = DateFormat('dd MMMM yyyy')
                          .format(DateTime.parse(date));
                      bool isSameDate = previousDate == formattedDate;
                      previousDate = formattedDate;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: availableHeight * .025),
                          if (!isSameDate)
                            Text(
                              formattedDate,
                              style: GoogleFonts.poppins(
                                  fontSize: screenSize.width * .04,
                                  fontWeight: FontWeight.bold),
                            ),
                          Card(
                              elevation: 5,
                              child: GestureDetector(
                                onTap: () => _modalBottom(context,
                                    width: screenSize.width,
                                    height: availableHeight,
                                    data: data[index]),
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  width: double.infinity,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Konsultasi dengan',
                                              style: GoogleFonts.poppins(
                                                fontSize:
                                                    screenSize.width * .035,
                                              ),
                                            ),
                                            Text(
                                                DateFormat('Hm').format(
                                                    DateTime.parse(date)),
                                                style: GoogleFonts.poppins(
                                                    fontSize: screenSize.width *
                                                        .035))
                                          ],
                                        ),
                                        SizedBox(
                                            height: availableHeight * .012),
                                        Text(
                                          data[index]['Dokter']['nama'] ??
                                              'Nama Dokter',
                                          style: GoogleFonts.poppins(
                                              fontSize: screenSize.width * .04,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data[index]['Dokter']['spesialis'] ??
                                              'Spesialis Dokter',
                                          style: GoogleFonts.poppins(
                                            fontSize: screenSize.width * .04,
                                          ),
                                        ),
                                        SizedBox(
                                            height: availableHeight * .012),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Pada',
                                                    style: GoogleFonts.poppins(
                                                      fontSize:
                                                          screenSize.width *
                                                              .035,
                                                    ),
                                                  ),
                                                  Text(
                                                    DateFormat('dd MMMM yyyy')
                                                        .format(DateTime.parse(
                                                            data[index][
                                                                'tanggal_konsultasi'])),
                                                    style: GoogleFonts.poppins(
                                                      fontSize:
                                                          screenSize.width *
                                                              .035,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ]),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: data[index]['is_done']
                                                    ? Colors.lightGreen
                                                    : Colors.redAccent,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              child: Text(
                                                data[index]['is_done']
                                                    ? 'Selesai'
                                                    : 'Belum Selesai',
                                                style: GoogleFonts.poppins(
                                                  fontSize:
                                                      screenSize.width * .04,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                              )),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _modalBottom(BuildContext context,
      {required double width,
      required double height,
      required Map<String, dynamic> data}) {
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
                    MyButton(
                      onPressed: () {
                        
                      },
                      text: 'Edit Pesanan',
                    ),
                  ],
                )
              : _detailDataRiwayat(width, height, data),
        );
      },
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
