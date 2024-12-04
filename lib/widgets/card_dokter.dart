import 'package:flutter/material.dart';
import 'package:quickcare_app/widgets/animate_fade.dart';
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
    return AnimatedFade(
      child: Card(
          elevation: 5,
          child: ListTile(
            leading: CircleAvatar(
              radius: radius,
              child: Hero(
                tag: '${dataDokter['id']} $routeName',
                child: Image.network(
                  dataDokter['url_foto'] ?? '',
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
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
            title: Text(dataDokter['nama'] ?? 'nama dokter'),
            subtitle: Text(dataDokter['spesialis'] ?? 'spesialis dokter'),
            trailing: Text(Formatter.rupiah(dataDokter['harga'] ?? 0)),
            onTap: onTap,
          )),
    );
  }
}
