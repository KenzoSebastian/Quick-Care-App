import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/providers/riwayat_provider.dart';
import 'package:quickcare_app/widgets/animate_scale.dart';
import 'package:quickcare_app/widgets/bottom_navbar.dart';
import 'package:quickcare_app/widgets/button.dart';
import 'package:quickcare_app/widgets/card_dokter.dart';
import 'package:quickcare_app/widgets/overlay_message.dart';
import '../widgets/animate_fade.dart';
import '../widgets/item_select.dart';

class EditOrder extends StatefulWidget {
  const EditOrder(
      {super.key,
      this.dataDokter,
      this.routeFrom,
      this.tanggal_konsultasi,
      this.waktu_konsultasi,
      this.id_riwayat});
  static const routeName = '/edit-order';
  final Map<String, dynamic>? dataDokter;
  final String? routeFrom;
  final String? tanggal_konsultasi;
  final String? waktu_konsultasi;
  final int? id_riwayat;

  @override
  State<EditOrder> createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {
  late DateTime dateOrder;
  late String? selectedTime;

  @override
  void initState() {
    super.initState();
    dateOrder = DateTime.parse(widget.tanggal_konsultasi ?? '');
    selectedTime = widget.waktu_konsultasi ?? '';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateOrder,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        dateOrder = pickedDate;
        if (!pickedDate.isAtSameMomentAs(
            DateTime.parse(widget.tanggal_konsultasi ?? ''))) {
          selectedTime = null;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    final availableHeight = screenSize.height - appBarHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        title: const AnimatedFade(delay: 50, child: Text('Edit Order Page')),
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
                                        child: ItemSelect(
                                          child: Text(
                                            dateOrder.isAtSameMomentAs(
                                                    DateTime.now()
                                                        .toLocal()
                                                        .copyWith(
                                                            hour: 0,
                                                            minute: 0,
                                                            second: 0,
                                                            millisecond: 0,
                                                            microsecond: 0))
                                                ? 'Hari ini'
                                                : DateFormat('dd-MMM-yyyy')
                                                    .format(dateOrder),
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
                                        child: const AnimatedScaleCustom(
                                          delay: 200,
                                          duration: 300,
                                          child: ItemSelect(
                                            child: Icon(Icons.calendar_today),
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
            Consumer<RiwayatProvider>(builder: (context, provider, child) {
              return MyButton(
                  margin: EdgeInsets.only(bottom: availableHeight * .03),
                  text: 'Konfirmasi',
                  onPressed: () async {
                    if (selectedTime == null) {
                      OverlayMessage().showOverlayMessage(
                          context, 'Pilih waktu konsultasi terlebih dahulu!');
                    } else {
                      await provider.editRiwayat(
                          tanggal_konsultasi: dateOrder,
                          waktu_konsultasi: selectedTime!,
                          id: widget.id_riwayat!);
                      if (provider.statusEdit['status'] == 404) {
                        OverlayMessage().showOverlayMessage(context,
                            'Gagal edit riwayat konsultasi, silahkan coba lagi');
                        return;
                      }
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                        context,
                        BottomNavbar.routeName,
                      );
                      OverlayMessage().showOverlayMessage(
                          context, 'Berhasil edit riwayat konsultasi!',
                          color: Colors.green);
                    }
                  });
            }),
          ],
        ),
      ),
    );
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

    bool isDisabled = (dateOrder.isAtSameMomentAs(DateTime.now()
            .toLocal()
            .copyWith(
                hour: 0,
                minute: 0,
                second: 0,
                millisecond: 0,
                microsecond: 0))) &&
        (hour < hourNow || (hour == hourNow && minute < minuteNow));

    return GestureDetector(
      onTap: () {
        if (!isDisabled) {
          setState(() {
            selectedTime = time;
          });
        }
      },
      child: ItemSelect(
        color: isDisabled
            ? Colors.grey.withOpacity(0.5)
            : (selectedTime == time
                ? const Color(0xFFFF5722)
                : const Color(0xFFBBDEFB)),
        isDisabled: isDisabled,
        child: Text(
          time,
          style: GoogleFonts.poppins(
            fontSize: width * .03,
            fontWeight: FontWeight.w500,
            color: selectedTime == time ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
