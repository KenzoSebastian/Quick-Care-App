import 'package:flutter/material.dart';
import 'package:quickcare_app/utils/shuffle.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DokterProvider with ChangeNotifier {
  final supabase = Supabase.instance.client;

  final List<Map<String, dynamic>> _dokter = [];
  List<Map<String, dynamic>> get dokter => _dokter;

  final List<Map<String, dynamic>> _filterDokter = [];
  List<Map<String, dynamic>> get filterDokter => _filterDokter;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> setDokter() async {
    _isLoading = true;
    notifyListeners();
    final response = await supabase.from('Dokter').select('*');
    var shuffleData = RandomData.shuffle(response);
    _dokter.clear();
    _dokter.addAll(shuffleData);
    _isLoading = false;
    notifyListeners();
  }

  void searchDokter(String query) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    if (query.isEmpty) {
      _filterDokter.clear();
    } else {
      var dataFilter = _dokter
          .where((dokter) =>
              dokter['nama'].toLowerCase().contains(query.toLowerCase()) ||
              dokter['spesialis'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      _filterDokter.clear();
      _filterDokter.addAll(dataFilter);
    }
    _isLoading = false;
    notifyListeners();
  }
}
