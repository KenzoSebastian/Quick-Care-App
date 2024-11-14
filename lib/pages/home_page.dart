import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/providers/dashboard_provider.dart';
import 'package:quickcare_app/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (args.isNotEmpty) {
      final data = Provider.of<LoadDataUser>(context, listen: false);
      data.setData(args);
      // _isDataSet = true; // ini nanti diset ya
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Care - Dashboard'),
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: Consumer<LoadDataUser>(builder: (context, provider, child) {
          final data = provider.data;
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(data['nama'] ?? 'erorr'),
                Text(data['email'] ?? 'erorr'),
                // Text(data['nik'] ?? 'erorr'),
                // Text(data['no_hp'].toString() ?? 'erorr'),
              ]);
        }),
      ),
    );
  }
}
