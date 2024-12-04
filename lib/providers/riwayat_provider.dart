import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../utils/update_riwayat.dart';

class RiwayatProvider with ChangeNotifier {
  final supabase = Supabase.instance.client;

  final Map<String, dynamic> _responsePayment = {};
  Map<String, dynamic> get responsePayment => _responsePayment;

  Future<void> payment(Map<String, dynamic> data) async {
    try {
      var response = await supabase
          .from('Riwayat')
          .insert({
            'created_at': DateTime.now().toString(),
            'id_dokter': data['id_dokter'],
            'id_users': data['id_users'],
            'tanggal_konsultasi': data['tanggal_konsultasi'],
            'waktu_konsultasi': data['waktu_konsultasi'],
            'biaya_penanganan': data['biaya_penanganan'],
            'total_biaya': data['total_biaya'],
            'metode_pembayaran': data['metode_pembayaran'],
          })
          .select()
          .single();
      _responsePayment.clear();
      _responsePayment.addAll(response);
    } on PostgrestException catch (e) {
      _responsePayment.clear();
      _responsePayment.addAll({'error': e.message});
    } catch (e) {
      _responsePayment.clear();
      _responsePayment.addAll({'error': e});
    }
    notifyListeners();
  }

  final List<Map<String, dynamic>> _riwayat = [];
  List<Map<String, dynamic>> get riwayat => _riwayat;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> setRiwayat() async {
    _isLoading = true;
    notifyListeners();
    try {
      var response = await supabase
          .from('Riwayat')
          .select(
              'id, created_at, tanggal_konsultasi, waktu_konsultasi, biaya_penanganan, total_biaya, metode_pembayaran, is_done, Dokter(nama, spesialis, harga)')
          .eq('id_users', 37)
          .order('id', ascending: false);

      await UpdateRiwayat().updateRiwayat(response);

      var updatedResponse = await supabase
          .from('Riwayat')
          .select(
              'id, created_at, tanggal_konsultasi, waktu_konsultasi, biaya_penanganan, total_biaya, metode_pembayaran, is_done, Dokter(nama, spesialis, harga)')
          .eq('id_users', 37)
          .order('id', ascending: false);

      _riwayat.clear();
      _riwayat.addAll(updatedResponse);
    } on PostgrestException catch (e) {
      _riwayat.clear();
      _riwayat.addAll([
        {'error': e.message}
      ]);
    } catch (e) {
      _riwayat.clear();
      _riwayat.addAll([
        {'error': e}
      ]);
    }
    _isLoading = false;
    notifyListeners();
  }
}
