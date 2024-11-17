import 'package:flutter/material.dart';
import 'package:quickcare_app/widgets/bottom_navbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static const routeName = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> { 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('search page'),
      ),
      // drawer: const MyDrawer(),
      body: const Center(child: Text('search')),
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
