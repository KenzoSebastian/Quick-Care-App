import 'dart:convert';

import 'package:string_validator/string_validator.dart';

class Validate {
  static Future? validationregister(
      {required String nama,
      required String nik,
      required String noHandphone,
      required String tglLahir,
      required String email,
      required String password}) async {
    // validation empty field
    if (nama.isEmpty ||
        nik.isEmpty ||
        noHandphone.isEmpty ||
        tglLahir.isEmpty ||
        email.isEmpty ||
        password.isEmpty) return Future.error('Semua field harus diisi');
    await namaValidation(nama: nama);
    await nikValidation(nik: nik);
    await noHandphoneValidation(noHandphone: noHandphone);
    await emailValidation(email: email);
    await passwordValidation(password: password);
    return null;
  }

  static Future? namaValidation({required String nama}) {
    try {
      final namaSplit = nama.split(' ');
      final namaJoin = namaSplit.join();
      final characterNama = namaJoin.split('');
      if (!isAlpha(namaJoin)) {
        return Future.error('Nama user harus berupa huruf');
      }
      if (characterNama.length < 5) {
        return Future.error('Nama user minimal 5 karakter');
      }
      for (int i = 0; i < namaSplit.length; i++) {
        final huruf = namaSplit[i].split('').first;
        if (isLowercase(huruf)) {
          return Future.error('Gunakan huruf kapital di awal setiap kata');
        }
      }
    } catch (e) {
      print(e);
      return Future.error('Nama tidak boleh berakhir dengan spasi');
    }
    return null;
  }

  static Future? nikValidation({required String nik}) {
    // validation nik
    final nikSplit = nik.split('');
    if (!isNumeric(nik)) {
      return Future.error('NIK harus berupa angka');
    }
    if (nikSplit.length != 16) {
      return Future.error('NIK harus terdiri dari 16 angka');
    }
    return null;
  }

  static Future? noHandphoneValidation({required String noHandphone}) {
    // validation no handphone
    final noHandphoneSplit = noHandphone.split('');
    final validPrefixes = ['081', '082', '083', '085', '087'];
    if (!isNumeric(noHandphone)) {
      return Future.error('No. Handphone harus berupa angka');
    }
    if (noHandphoneSplit.length < 10) {
      return Future.error('No. Handphone harus terdiri dari 10 angka');
    }
    if (!validPrefixes.any((prefix) => noHandphone.startsWith(prefix))) {
      return Future.error('No. Handphone tidak valid');
    }
    return null;
  }

  static Future? emailValidation({required String email}) {
    // validation email
    if (!isEmail(email)) {
      return Future.error('Email tidak valid');
    }
    return null;
  }

  static Future? passwordValidation({required String password}) {
    // validation password
    final passwordSplit = password.split('');
    if (passwordSplit.length < 5) {
      return Future.error('Password minimal 5 karakter');
    }
    if (isAlpha(password) || isNumeric(password)) {
      return Future.error('Password harus berupa huruf dan angka');
    }
    return null;
  }

  static Future? validationLogin(
      {required String email, required String password}) async {
    // validation empty field
    if (email.isEmpty || password.isEmpty) {
      return Future.error('Semua field harus diisi');
    }

    await emailValidation(email: email);
    await passwordValidation(password: password);
    return null;
  }

  static Future? authenticationLogin(
      {required List<Map<String, dynamic>> result, required String password}) {
    // Authentication email
    if (result.isEmpty) {
      return Future.error('Alamat email tidak terdaftar');
    }

    // Authentication password
    var passwordEncode = base64.encode(password.codeUnits);
    var passwordDatabase = result[0]['password'];
    if (passwordEncode != passwordDatabase) {
      return Future.error('Password salah');
    }
    return null;
  }

  static validateName({required nama}) {}
}
