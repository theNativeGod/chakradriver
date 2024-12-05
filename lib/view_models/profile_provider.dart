import 'package:chakracabsrider/models/driver_model.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  Driver? _driver;

  get driver => _driver;

  set driver(value) {
    _driver = value;
    notifyListeners();
  }
}
