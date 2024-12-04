import 'package:flutter/material.dart';
import '../utils/validate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginProvider with ChangeNotifier {
  final supabase = Supabase.instance.client;
  final Map<String, dynamic> _user = {};

  Map<String, dynamic> get user => _user;
  Future loginUser({required String email, required String password}) async {
    try {
      await Validate.validationLogin(email: email, password: password);
      var response =
          await supabase.from('Users').select('*').eq('email', email);
      await Validate.authenticationLogin(result: response, password: password);
      _user.clear();
      _user.addAll(response[0]);
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
