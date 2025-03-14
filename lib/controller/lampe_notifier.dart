import 'package:flutter/material.dart';

class LampeNotifier with ChangeNotifier {

  bool _isOn = false;
  bool get isOn => _isOn;

  void setIsOn() {
    _isOn = !_isOn;
    notifyListeners();
  }
}