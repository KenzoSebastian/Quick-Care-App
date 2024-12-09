import 'package:flutter/material.dart';

class AboutDialogCustom{
  static void aboutDialog(BuildContext context) {
    return showAboutDialog(
      context: context,
      applicationName: 'Quick Care',
      applicationVersion: '1.0.0',
      applicationIcon: Image.asset(
        'assets/images/icon.png',
        width: 50,
        height: 50,
      ),
      children: [
        const Text(
            'Quick Care adalah aplikasi booking dokter online yang memudahkan Anda untuk membuat janji temu dengan dokter spesialis.'),
        const SizedBox(height: 10),
        const Text('Dengan Quick Care, Anda dapat:'),
        const Text('- Mendaftar dan masuk dengan mudah.'),
        const Text('- Memilih dokter spesialis sesuai kebutuhan.'),
        const Text('- Menentukan tanggal dan waktu konsultasi.'),
        const Text('- Melakukan pembayaran secara aman.'),
        const Text('- Melihat riwayat janji temu Anda.'),
        const SizedBox(height: 10),
        const Text(
            'Aplikasi ini dikembangkan oleh tim profesional yang berkomitmen untuk memberikan kemudahan akses layanan kesehatan bagi masyarakat.'),
        const SizedBox(height: 10),
        const Text('Terima kasih telah menggunakan Quick Care!'),
      ],
    );
  }
}