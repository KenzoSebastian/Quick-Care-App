import 'package:flutter/material.dart';
import 'package:quickcare_app/widgets/bottom_navbar.dart';

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
        title: const Text('Account page'),
      ),
      // drawer: const MyDrawer(),
      body: const Center(child: Text('Account')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.logout),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const BottomNavbar()));
        },
      ),
    );
  }
}
