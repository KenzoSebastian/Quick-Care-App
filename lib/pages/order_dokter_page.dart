import 'package:flutter/material.dart';
import 'package:quickcare_app/widgets/card_dokter.dart';

class OrderDokter extends StatelessWidget {
  const OrderDokter({super.key, this.dataDokter, this.routeFrom});
  static const routeName = '/order-dokter';
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
        title: const Text('order page'),
      ),
      // drawer: const MyDrawer(),
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * .05,
          ),
          child: ListView(children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: availableHeight * .03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DokterCard(
                        dataDokter: dataDokter!,
                        routeName: routeFrom!,
                        radius: screenSize.width * .09
                        ),
                  ],
                )),
          ])),
    );
  }
}
