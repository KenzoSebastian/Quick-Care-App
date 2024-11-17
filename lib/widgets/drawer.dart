import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final heightFull = screenSize.height;
    return Drawer(
      child: Column(
        children: <Widget>[
          Consumer<LoadDataUser>(
            builder: (context, provider, child) {
              final data = provider.data;
              return Container(
                  padding: const EdgeInsets.all(16.0),
                  color: const Color.fromARGB(255, 1, 163, 199),
                  width: double.infinity,
                  height: heightFull * .25,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CircleAvatar(
                          radius: 45,
                          backgroundImage:
                              NetworkImage('https://i.pravatar.cc/300'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data['nama'] ?? 'erorr',
                                  style: GoogleFonts.lato(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )),
                              Text(data['email'] ?? 'erorr',
                                  style: GoogleFonts.lato(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ),
                      ]));
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
                    _aboutDialog(context);
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

  void _aboutDialog(BuildContext context) {
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
