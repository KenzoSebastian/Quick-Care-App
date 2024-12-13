import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InboxProvider with ChangeNotifier {
  final supabase = Supabase.instance.client;

  final List<Map<String, dynamic>> _inbox = [];
  List<Map<String, dynamic>> get inbox => _inbox;

  void setInbox(int? id) async {
    if (id != null) {
      try {
        var response = await supabase
            .from('Inbox')
            .select('*')
            .eq('id_users', id)
            .order('created_at', ascending: false);
        _inbox.clear();
        _inbox.addAll(response);
      } on PostgrestException catch (e) {
        print(e);
      } catch (e) {
        print(e);
      }
    }
  }

  void addInbox(Map<String, dynamic> data) {
    _inbox.add(data);
    notifyListeners();
  }
}