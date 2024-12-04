import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quickcare_app/utils/validate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterProvider with ChangeNotifier {
  final supabase = Supabase.instance.client;
  final Map<String, dynamic> _user = {};

  Map<String, dynamic> get user => _user;

  Future createUser(
      {required String nama,
      required String nik,
      required String noHandphone,
      required String tglLahir,
      required String email,
      required String password}) async {
    try {
      await Validate.validationregister(
        nama: nama,
        nik: nik,
        noHandphone: noHandphone,
        tglLahir: tglLahir,
        email: email,
        password: password,
      );
      // encode password
      var passwordEncode = base64.encode(password.codeUnits);
      var response = await supabase
          .from('Users')
          .insert({
            'nama': nama,
            'nik': nik,
            'no_handphone': noHandphone,
            'tanggal_lahir': tglLahir,
            'email': email,
            'password': passwordEncode,
          })
          .select()
          .single();
      _user.clear();
      _user.addAll(response);
    } on PostgrestException catch (e) {
      _user.clear();
      _user.addAll({'error': e.message});
    } catch (e) {
      _user.clear();
      _user.addAll({'error': e});
    }
    notifyListeners();
  }
}
