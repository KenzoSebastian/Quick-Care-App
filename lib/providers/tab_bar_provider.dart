import 'package:flutter/material.dart';

class TabBarProvider with ChangeNotifier {
  int _tabIndex = 3;
  int get tabIndex => _tabIndex;

  void setTabIndex(int newIndex) {
    _tabIndex = newIndex;
    notifyListeners();
  }
}