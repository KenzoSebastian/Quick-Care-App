import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RiwayatProvider with ChangeNotifier {
  final supabase = Supabase.instance.client;

  final Map<String, dynamic> _responsePayment = {};
  Map<String, dynamic> get responsePayment => _responsePayment;

  Future<void> payment(Map<String, dynamic> data) async {
    try {
      var response = await supabase
          .from('Riwayat')
          .insert({
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
      notifyListeners();
    } on PostgrestException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }

  }
}
