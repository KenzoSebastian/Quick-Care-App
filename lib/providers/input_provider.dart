import 'package:flutter/material.dart';

class InputProvider with ChangeNotifier {
  bool _hidePass = true;

  bool get hidePass => _hidePass;
  void setHidePass() {
    _hidePass = !_hidePass;
    notifyListeners();
  }

  String? _errorMassageNama;
  String? _errorMassageNik;
  String? _errorMassageNoHandphone;
  String? _errorMassageEmail;
  String? _errorMassagePassword;

  String? get errorMassageNama => _errorMassageNama;
  String? get errorMassageNik => _errorMassageNik;
  String? get errorMassageNoHandphone => _errorMassageNoHandphone;
  String? get errorMassageEmail => _errorMassageEmail;
  String? get errorMassagePassword => _errorMassagePassword;

  void setErrorMassageNama(String? value) {
    _errorMassageNama = value;
    notifyListeners();
  }
  void setErrorMassageNik(String? value) {
    _errorMassageNik = value;
    notifyListeners();
  }
  void setErrorMassageNoHandphone(String? value) {
    _errorMassageNoHandphone = value;
    notifyListeners();
  }
  void setErrorMassageEmail(String? value) {
    _errorMassageEmail = value;
    notifyListeners();
  }
  void setErrorMassagePassword(String? value) {
    _errorMassagePassword = value;
    notifyListeners();
  }

}
