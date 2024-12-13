import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/widgets/card_riwayat.dart';
import '../providers/dashboard_provider.dart';
import '../providers/riwayat_provider.dart';
import '../widgets/animate_fade.dart';

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
    int? userId = Provider.of<LoadDataUser>(context, listen: false).userId;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('History Page'),
      ),
      body: LiquidPullToRefresh(
        showChildOpacityTransition: false,
        backgroundColor: Colors.orange,
        animSpeedFactor: 3,
        springAnimationDurationInMilliseconds: 750,
        color: Colors.grey[200],
        onRefresh: () async =>
            await Provider.of<RiwayatProvider>(context, listen: false)
                .setRiwayat(userId),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * .05),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: availableHeight * .03),
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

                    if (provider.isLoading) {
                      return Padding(
                        padding: EdgeInsets.only(top: availableHeight * .03),
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (data.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(top: availableHeight * .03),
                        child: Center(
                          child: Text('Data riwayat kosong.',
                              style: GoogleFonts.poppins(color: Colors.red)),
                        ),
                      );
                    }

                    if (data[0]['error'] != null) {
                      return Center(
                        child: Text(data[0]['error'],
                            style: GoogleFonts.poppins(color: Colors.red)),
                      );
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
                            if (!isSameDate)
                              Padding(
                                padding: EdgeInsets.only(
                                    top: availableHeight * .04,
                                    bottom: availableHeight * .01,
                                    left: screenSize.width * .02),
                                child: Text(
                                  formattedDate,
                                  style: GoogleFonts.poppins(
                                      fontSize: screenSize.width * .0475,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            CardRiwayat(
                              data: data[index],
                              height: availableHeight,
                              width: screenSize.width,
                              provider: provider,
                              routeFrom: HistoryPage.routeName,
                            ),
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
      ),
    );
  }
}
