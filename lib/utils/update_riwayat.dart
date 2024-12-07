import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateRiwayat {
  final supabase = Supabase.instance.client;

  Future<void> updateRiwayat(List<Map<String, dynamic>> data) async {
    for (int i = 0; i < data.length; i++) {
      // Parsing tanggal konsultasi
      final DateTime tanggalKonsultasi =
          DateTime.parse(data[i]['tanggal_konsultasi']);
      final List<String> waktuKonsultasi =
          data[i]['waktu_konsultasi'].split(':');
      int hour = int.parse(waktuKonsultasi[0]);
      int minute = int.parse(waktuKonsultasi[1]);

      // Membuat DateTime untuk waktu konsultasi
      final DateTime waktuKonsultasiDateTime = DateTime(
        tanggalKonsultasi.year,
        tanggalKonsultasi.month,
        tanggalKonsultasi.day,
        hour,
        minute,
      );

      // Mendapatkan waktu sekarang
      final DateTime now = DateTime.now();
      // Memeriksa apakah waktu konsultasi sudah lewat
      if (waktuKonsultasiDateTime.isBefore(now)) {
        try {
          await supabase
              .from('Riwayat')
              .update({'is_done': true}).eq('id', data[i]['id']);
        } on PostgrestException catch (e) {
          print(e.message);
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
