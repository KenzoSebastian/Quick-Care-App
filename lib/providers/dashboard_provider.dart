import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/validate.dart';

class LoadDataUser with ChangeNotifier {
  final supabase = Supabase.instance.client;
  int? _userId;
  int? get userId => _userId;

  void setUserId(int id) {
    _userId = id;
    notifyListeners();
  }

  final Map<String, dynamic> _data = {};
  Map<String, dynamic> get data => _data;

  void setData() async {
    if (_userId != null) {
      try {
        var response =
            await supabase.from('Users').select().eq('id', _userId!).single();
        _data.clear();
        _data.addAll(response);
      } on PostgrestException catch (e) {
        _data.clear();
        _data.addAll({'error': e.message});
      } catch (e) {
        _data.clear();
        _data.addAll({'error': e});
      }
      notifyListeners();
    }
  }

  final Map<String, dynamic> _statusChangePhoto = {};
  Map<String, dynamic> get statusChangePhoto => _statusChangePhoto;

  Future<void> changePhoto(String photo) async {
    if (_userId != null) {
      try {
        var result = await supabase
            .from('Users')
            .update({'photo_profile': photo}).eq('id', _userId!);
        if (result == null) {
          _statusChangePhoto.clear();
          _statusChangePhoto.addAll({'status': 200});
        }
      } on PostgrestException catch (e) {
        _statusChangePhoto.clear();
        _statusChangePhoto.addAll({'status': int.parse(e.code!)});
      } catch (e) {
        _statusChangePhoto.clear();
        _statusChangePhoto.addAll({'status': 404});
      }
      notifyListeners();
    }
  }

  final Map<String, dynamic> _statusEditUser = {};
  Map<String, dynamic> get statusEditUser => _statusEditUser;

  Future editUser(
      {required String nama,
      required String nik,
      required String noHandphone,
      required String tglLahir}) async {
    try {
      await Validate.validationEditUser(
          nama: nama, nik: nik, noHandphone: noHandphone, tglLahir: tglLahir);
      var result = await supabase.from('Users').update({
        'nama': nama,
        'nik': nik,
        'no_handphone': noHandphone,
        'tanggal_lahir': tglLahir
      }).eq('id', _userId!);
      if (result == null) {
        _statusEditUser.clear();
        _statusEditUser.addAll({'status': 200});
      }
    } on PostgrestException catch (e) {
      print(e);
      _statusEditUser.clear();
      _statusEditUser.addAll({
        'status': int.parse(e.code!),
        'error': 'Terjadi kesalahan tak terduga pada server'
      });
    } catch (e) {
      _statusEditUser.clear();
      _statusEditUser.addAll({'status': 404, 'error': e});
    }
    notifyListeners();
  }
}
