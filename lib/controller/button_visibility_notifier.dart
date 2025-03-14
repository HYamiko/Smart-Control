import 'package:flutter/material.dart';

import '../storage.dart';

class ButtonVisibilityNotifier with ChangeNotifier{
  bool _isVisible = Storage().getString('adresseIp') == null ? false : true;
  bool get isVisible => _isVisible;

  void setIsVisible(){
    _isVisible = !_isVisible;
    notifyListeners();
  }
}