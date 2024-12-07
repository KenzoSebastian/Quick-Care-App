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

  Future<void> setRiwayat(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      var response = await supabase
          .from('Riwayat')
          .select('id, tanggal_konsultasi, waktu_konsultasi, is_done')
          .eq('id_users', id);
      await UpdateRiwayat().updateRiwayat(response);

      var updatedResponse = await supabase
          .from('Riwayat')
          .select(
              'id, created_at, tanggal_konsultasi, waktu_konsultasi, biaya_penanganan, total_biaya, metode_pembayaran, is_done, Dokter(nama, spesialis, harga, url_foto)')
          .eq('id_users', id)
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

  final Map<String, dynamic> _statusEdit = {};
  Map<String, dynamic> get statusEdit => _statusEdit;

  Future<void> editRiwayat(
      {required DateTime tanggal_konsultasi,
      required String waktu_konsultasi,
      required int id}) async {
    try {
      var result = await supabase.from('Riwayat').update({
        'tanggal_konsultasi': tanggal_konsultasi.toString(),
        'waktu_konsultasi': waktu_konsultasi
      }).eq('id', id);
      if (result == null) {
        _statusEdit.clear();
        _statusEdit.addAll({'status': 200});
      }
    } on PostgrestException catch (e) {
      _statusEdit.clear();
      _statusEdit.addAll({'status': int.parse(e.code!)});
    } catch (e) {
      _statusEdit.clear();
      _statusEdit.addAll({'status': 404});
    }
    _isLoading = true;
    notifyListeners();
  }

  final Map<String, dynamic> _statusDelete = {};
  Map<String, dynamic> get statusDelete => _statusDelete;

  Future<void> deleteRiwayat({required int id}) async {
    try {
      var result = await supabase.from('Riwayat').delete().eq('id', id);
      print(result);
      if (result == null) {
        _statusDelete.clear();
        _statusDelete.addAll({'message': 'Success'});
      }
    } on PostgrestException catch (e) {
      _statusDelete.clear();
      _statusDelete.addAll({'message': e.message});
    } catch (e) {
      _statusDelete.clear();
      _statusDelete.addAll({'message': e});
    }
    _isLoading = true;
    notifyListeners();
  }
}
