import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tab_bar_provider.dart';
import '../widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
  final TabBarProvider tabBarProvider = Provider.of<TabBarProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Care - Dashboard'),
      ),
      drawer: const MyDrawer(),
      body: const Center(child: Text('Dashboard')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () {
          tabBarProvider.setTabIndex(2);
        },
      ),
    );
  }
}
