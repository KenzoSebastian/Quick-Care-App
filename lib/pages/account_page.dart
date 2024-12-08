import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/widgets/bottom_navbar.dart';

import '../providers/dashboard_provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.purple,
      ),
      // drawer: const MyDrawer(),
      body: LiquidPullToRefresh(
        backgroundColor: Colors.purple,
        showChildOpacityTransition: false,
        animSpeedFactor: 3,
        color: Colors.grey[200],
        onRefresh: () async => Provider.of<LoadDataUser>(context, listen: false).setData(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Stack(alignment: Alignment.center, children: [
                    Container(
                        width: double.infinity, height: 4, color: Colors.black),
                    const CircleAvatar(
                      radius: 40,
                      // backgroundImage: NetworkImage(
                      //     'https://via.placeholder.com/150'), // Ganti URL gambar dengan foto profil Anda
                    ),
                  ]),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Edit Profile'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  buildSectionHeader('Mini Headline'),
                  buildListTile('History', Icons.history),
                  buildListTile('Data Diri', Icons.person_sharp),
                  buildListTile('No Telepon', Icons.call),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.logout),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const BottomNavbar()));
        },
      ),
    );
  }

  Widget buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildListTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {},
    );
  }
}
