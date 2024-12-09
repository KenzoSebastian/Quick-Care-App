import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoadDataUser with ChangeNotifier {
  final supabase = Supabase.instance.client;
  int? _userId = 37;
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
}
