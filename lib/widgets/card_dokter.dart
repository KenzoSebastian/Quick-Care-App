import 'package:flutter/material.dart';
import '../utils/formatter.dart';

class DokterCard extends StatelessWidget {
  const DokterCard({
    super.key,
    required this.dataDokter,
    required this.routeName,
    required this.radius,
    this.onTap,
  });

  final Map<String, dynamic> dataDokter;
  final String routeName;
  final double radius;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: ListTile(
          leading: CircleAvatar(
            radius: radius,
            child: Hero(
                tag: '$routeName ${dataDokter['id']}',
                child: Image.network(dataDokter['url_foto'] ?? '')),
          ),
          title: Text(dataDokter['nama'] ?? 'nama dokter'),
          subtitle: Text(dataDokter['spesialis'] ?? 'spesialis dokter'),
          trailing: Text(Formatter.rupiah(dataDokter['harga'] ?? 0)),
          onTap: onTap,
        ));
  }
}
