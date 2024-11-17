import 'package:flutter/material.dart';
import 'package:quickcare_app/widgets/bottom_navbar.dart';
// import '../widgets/drawer.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> { 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('history page'),
      ),
      // drawer: const MyDrawer(),
      body: const Center(child: Text('history')),
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
