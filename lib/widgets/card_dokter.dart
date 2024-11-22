import 'package:flutter/material.dart';
import '../utils/formatter.dart';

class DokterCard extends StatelessWidget {
  const DokterCard({
    super.key,
    required this.dataDokter,
    required this.index,
    required this.radius,
  });

  final List<Map<String, dynamic>> dataDokter;
  final int index;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: ListTile(
          leading: CircleAvatar(
            radius: radius,
            child: Image.network(dataDokter[index]['url_foto'] ?? ''),
          ),
          title: Text(dataDokter[index]['nama'] ?? 'nama dokter'),
          subtitle: Text(dataDokter[index]['spesialis'] ?? 'spesialis dokter'),
          trailing: Text(Formatter.rupiah(dataDokter[index]['harga'] ?? 0)),
        ));
  }
}
