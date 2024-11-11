import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  // bool _isLogin = false;
  // bool get isLogin => _isLogin;
  // void setIsLogin(bool value){
  //   _isLogin = value;
  //   notifyListeners();
  // }

  bool _hidePass = true;
  bool get hidePass => _hidePass;
  void setHidePass() {
    _hidePass = !_hidePass;
    notifyListeners();
  }


}