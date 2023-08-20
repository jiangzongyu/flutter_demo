import 'package:flutter/material.dart';

class LogoModel extends ChangeNotifier {
  bool _flipX = false;

  bool get flipX => _flipX;

  set flipX(bool value) {
    _flipX = value;
    notifyListeners();
  }

  bool _flipY = false;

  bool get flipY => _flipY;

  set flipY(bool value) {
    _flipY = value;
    notifyListeners();
  }

  double _size = 200.0;

  double get size => _size;

  set size(double value) {
    _size = value;
    notifyListeners();
  }
}
