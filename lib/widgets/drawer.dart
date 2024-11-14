import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Consumer<LoadDataUser>(
            builder: (context, provider, child) {
              final data = provider.data;
              print(data);
              return UserAccountsDrawerHeader(
                accountName: Text(data['nama'] ?? ''),
                accountEmail: Text(data['email'] ?? ''),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                ),
              );
            },
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Book Appointment'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About'),
                  onTap: () {
                    Navigator.pop(context);
                    showAboutDialog(
                      context: context,
                      applicationName: 'Quick Care',
                      applicationVersion: '1.0.0',
                      applicationIcon:
                          const Icon(Icons.local_hospital, size: 40),
                      children: [
                        const Text(
                            'Quick Care adalah aplikasi booking dokter online yang memudahkan Anda untuk membuat janji temu dengan dokter spesialis.'),
                        const SizedBox(height: 10),
                        const Text('Dengan Quick Care, Anda dapat:'),
                        const Text('- Mendaftar dan masuk dengan mudah.'),
                        const Text(
                            '- Memilih dokter spesialis sesuai kebutuhan.'),
                        const Text(
                            '- Menentukan tanggal dan waktu konsultasi.'),
                        const Text('- Melakukan pembayaran secara aman.'),
                        const Text('- Melihat riwayat janji temu Anda.'),
                        const SizedBox(height: 10),
                        const Text(
                            'Aplikasi ini dikembangkan oleh tim profesional yang berkomitmen untuk memberikan kemudahan akses layanan kesehatan bagi masyarakat.'),
                        const SizedBox(height: 10),
                        const Text(
                            'Terima kasih telah menggunakan Quick Care!'),
                      ],
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Logout'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Version 1.0.0'),
          ),
        ],
      ),
    );
  }
}
