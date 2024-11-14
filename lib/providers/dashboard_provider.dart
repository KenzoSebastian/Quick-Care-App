import 'package:flutter/material.dart';

class LoadDataUser with ChangeNotifier {
  final Map<String, dynamic> _data = {};
  Map<String, dynamic> get data => _data;

  void setData(Map<String, dynamic> args) {
    if (args.isNotEmpty) {
      _data.clear();
      _data.addAll(args);
      notifyListeners();
    }
  }
}
