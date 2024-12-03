import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/providers/riwayat_provider.dart';
import 'package:quickcare_app/widgets/animate_scale.dart';
import 'package:quickcare_app/widgets/button.dart';
import 'package:quickcare_app/widgets/card_dokter.dart';
import 'package:quickcare_app/widgets/overlay_message.dart';
import '../providers/dashboard_provider.dart';
import '../utils/formatter.dart';
import '../widgets/animate_fade.dart';

class OrderDokter extends StatefulWidget {
  const OrderDokter({super.key, this.dataDokter, this.routeFrom});
  static const routeName = '/order-dokter';
  final Map<String, dynamic>? dataDokter;
  final String? routeFrom;

  @override
  State<OrderDokter> createState() => _OrderDokterState();
}

class _OrderDokterState extends State<OrderDokter> {
  String dateOrder = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  String? selectedTime;
  String? selectedPaymentMethod;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MMM-yyyy').format(pickedDate);
      setState(() => dateOrder = formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    final availableHeight = screenSize.height - appBarHeight;
    const int biayaLayanan = 2000;

    LoadDataUser loadDataUser =
        Provider.of<LoadDataUser>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        title: const AnimatedFade(delay: 50, child: Text('Order Page')),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * .05,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: availableHeight * .03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DokterCard(
                          dataDokter: widget.dataDokter!,
                          routeName: widget.routeFrom!,
                          radius: screenSize.width * .09,
                        ),
                        SizedBox(height: availableHeight * .035),
                        GestureDetector(
                          onTap: () => setState(() => selectedTime = null),
                          child: Card(
                            color: const Color.fromARGB(255, 240, 233, 233),
                            elevation: 5,
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AnimatedFade(
                                    delay: 100,
                                    child: Text(
                                      "Pilih Tanggal & Waktu Konsultasi",
                                      style: GoogleFonts.poppins(
                                        fontSize: screenSize.width * .035,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: availableHeight * .02),
                                  Row(
                                    children: [
                                      AnimatedScaleCustom(
                                        delay: 100,
                                        duration: 300,
                                        child: _cardItems(
                                          child: Text(
                                            dateOrder ==
                                                    DateFormat('dd-MMM-yyyy')
                                                        .format(DateTime.now())
                                                ? 'Hari ini'
                                                : dateOrder,
                                            style: GoogleFonts.poppins(
                                              fontSize: screenSize.width * .03,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: screenSize.width * .02),
                                      GestureDetector(
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        child: AnimatedScaleCustom(
                                          delay: 200,
                                          duration: 300,
                                          child: _cardItems(
                                            child: const Icon(
                                                Icons.calendar_today),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: availableHeight * .030),
                                  _timeCardItems(
                                    height: availableHeight,
                                    width: screenSize.width,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            MyButton(
                margin: EdgeInsets.only(bottom: availableHeight * .03),
                text: 'Konfirmasi',
                onPressed: () {
                  selectedTime == null
                      ? OverlayMessage().showOverlayMessage(
                          context, 'Pilih waktu konsultasi terlebih dahulu!')
                      : _modalBottom(
                          context,
                          width: screenSize.width,
                          height: availableHeight,
                          biayaLayanan: biayaLayanan,
                          loadDataUser: loadDataUser,
                        );
                }),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _modalBottom(BuildContext context,
          {required double width,
          required double height,
          required int biayaLayanan,
          required LoadDataUser loadDataUser}) =>
      showModalBottomSheet(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedPaymentMethod = null;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .05,
                  vertical: height * .02,
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'Detail Pemesanan Konsultasi',
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
                              _itemDetailOrder(
                                  width: width,
                                  key: "Nama Dokter",
                                  value: widget.dataDokter!["nama"]!),
                              SizedBox(height: height * .005),
                              _itemDetailOrder(
                                  width: width,
                                  key: "Tanggal Konsultasi",
                                  value: dateOrder),
                              SizedBox(height: height * .005),
                              _itemDetailOrder(
                                  width: width,
                                  key: "Waktu Konsultasi",
                                  value: selectedTime!),
                              Divider(
                                height: height * .04,
                                color: Colors.black,
                              ),
                              _itemDetailOrder(
                                  width: width,
                                  key: "Biaya Konsultasi",
                                  value: Formatter.rupiah(
                                      widget.dataDokter!['harga'] ?? 0)),
                              SizedBox(height: height * .005),
                              _itemDetailOrder(
                                  width: width,
                                  key: "Biaya Penanganan",
                                  value: Formatter.rupiah(biayaLayanan)),
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
                              _itemDetailOrder(
                                  width: width,
                                  key: "Total Biaya",
                                  value: Formatter.rupiah(
                                      widget.dataDokter!['harga'] +
                                          biayaLayanan)),
                              Divider(
                                height: height * .025,
                                color: Colors.black,
                              ),
                              Text("Metode Pembayaran",
                                  style: GoogleFonts.ptSans(
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  )),
                              SizedBox(height: height * .005),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _itemsPayment(
                                      setState: setState,
                                      width: width,
                                      title: "Shopeepay"),
                                  _itemsPayment(
                                      setState: setState,
                                      width: width,
                                      title: "Gopay"),
                                  _itemsPayment(
                                      setState: setState,
                                      width: width,
                                      title: "Ovo"),
                                  _itemsPayment(
                                      setState: setState,
                                      width: width,
                                      title: "Dana"),
                                ],
                              )
                            ]),
                      ),
                    ),
                    Consumer<RiwayatProvider>(
                        builder: (context, riwayatProvider, child) {
                      return MyButton(
                          text: 'Konfirmasi Pembayaran',
                          onPressed: () async {
                            if (selectedPaymentMethod == null) {
                              OverlayMessage().showOverlayMessage(context,
                                  'Pilih metode pembayaran terlebih dahulu');
                            } else {
                              await riwayatProvider.payment({
                                'id_dokter': widget.dataDokter!['id'],
                                'id_users': loadDataUser.data['id'],
                                'tanggal_konsultasi': dateOrder,
                                'waktu_konsultasi': selectedTime,
                                'biaya_penanganan': biayaLayanan,
                                'total_biaya':
                                    widget.dataDokter!['harga'] + biayaLayanan,
                                'metode_pembayaran': selectedPaymentMethod,
                              });
                              riwayatProvider.responsePayment.isEmpty
                                  ? OverlayMessage().showOverlayMessage(
                                      context, 'Transaksi Pembayaran Gagal')
                                  : OverlayMessage().showOverlayMessage(
                                      context, 'Transaksi Pembayaran Berhasil');
                            }
                          });
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      );

  GestureDetector _itemsPayment(
      {required double width,
      required String title,
      required StateSetter setState}) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedPaymentMethod = title);
      },
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 55,
          height: 55,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: selectedPaymentMethod == title
                ? Border.all(color: Colors.black)
                : null,
          ),
          child: Image.asset("assets/payments/${title.toLowerCase()}.png")),
    );
  }

  Row _itemDetailOrder(
      {required double width, required String key, required String value}) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(
        width: width * .38,
        child: Text(
          key,
          style: GoogleFonts.ptSans(
            fontSize: width * .04,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Text(
        ':  ',
        style: GoogleFonts.ptSans(
          fontSize: width * .04,
          fontWeight: FontWeight.w500,
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: GoogleFonts.ptSans(
            fontSize: width * .04,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ]);
  }

  Widget _timeCardItems({required double height, required double width}) {
    return Card(
      color: Colors.white,
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedFade(
              delay: 300,
              child: Text(
                "Pagi",
                style: GoogleFonts.poppins(
                  fontSize: width * .035,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: height * .015),
            Row(
              children: [
                AnimatedScaleCustom(
                  delay: 400,
                  duration: 300,
                  child: _timeSlotCard('07:00', width),
                ),
                SizedBox(width: width * .02),
                AnimatedScaleCustom(
                  delay: 500,
                  duration: 300,
                  child: _timeSlotCard('08:00', width),
                ),
                SizedBox(width: width * .02),
                AnimatedScaleCustom(
                  delay: 600,
                  duration: 300,
                  child: _timeSlotCard('09:00', width),
                ),
                SizedBox(width: width * .02),
              ],
            ),
            SizedBox(height: height * .03),
            AnimatedFade(
              delay: 700,
              child: Text(
                "Siang",
                style: GoogleFonts.poppins(
                  fontSize: width * .035,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: height * .015),
            Row(
              children: [
                AnimatedScaleCustom(
                  delay: 800,
                  duration: 300,
                  child: _timeSlotCard('10:30', width),
                ),
                SizedBox(width: width * .02),
                AnimatedScaleCustom(
                  delay: 900,
                  duration: 300,
                  child: _timeSlotCard('12:00', width),
                ),
                SizedBox(width: width * .02),
                AnimatedScaleCustom(
                  delay: 1000,
                  duration: 300,
                  child: _timeSlotCard('13:30', width),
                ),
                SizedBox(width: width * .02),
              ],
            ),
            SizedBox(height: height * .03),
            AnimatedFade(
              delay: 1100,
              child: Text(
                "Sore",
                style: GoogleFonts.poppins(
                  fontSize: width * .035,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: height * .015),
            Row(
              children: [
                AnimatedScaleCustom(
                  delay: 1200,
                  duration: 300,
                  child: _timeSlotCard('15:00', width),
                ),
                SizedBox(width: width * .02),
                AnimatedScaleCustom(
                  delay: 1300,
                  duration: 300,
                  child: _timeSlotCard('16:30', width),
                ),
                SizedBox(width: width * .02),
                AnimatedScaleCustom(
                  delay: 1400,
                  duration: 300,
                  child: _timeSlotCard('18:00', width),
                ),
                SizedBox(width: width * .02),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _timeSlotCard(String time, double width) {
    int hourNow = DateTime.now().hour;
    int minuteNow = DateTime.now().minute;
    int hour = int.parse(time.split(':')[0]);
    int minute = int.parse(time.split(':')[1]);

    bool isDisabled =
        (dateOrder == DateFormat('dd-MMM-yyyy').format(DateTime.now())) &&
            (hour < hourNow || (hour == hourNow && minute < minuteNow));

    return GestureDetector(
      onTap: () {
        if (!isDisabled) {
          setState(() {
            selectedTime = time;
          });
        }
      },
      child: _cardItems(
        color: isDisabled
            ? Colors.grey.withOpacity(0.5)
            : (selectedTime == time
                ? const Color(0xFFFF5722)
                : const Color(0xFFBBDEFB)),
        child: Text(
          time,
          style: GoogleFonts.poppins(
            fontSize: width * .03,
            fontWeight: FontWeight.w500,
            color: selectedTime == time ? Colors.white : Colors.black,
          ),
        ),
        isDisabled: isDisabled,
      ),
    );
  }

  Card _cardItems({
    required Widget child,
    Color color = const Color.fromARGB(255, 209, 221, 239),
    bool isDisabled = false,
  }) {
    return Card(
      elevation: isDisabled ? 0 : 5,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: child,
      ),
    );
  }
}
