import 'package:flutter/material.dart';

class SignupProvider with ChangeNotifier {
  String _firstName = "";
  String _lastName = "";
  String _email = "";
  String _preferredCabStation = "";
  String _car = "";
  String _driverId = "";
  String _phoneNumber = "";

  get firstName => _firstName;
  get phoneNumber => _phoneNumber;
  get lastName => _lastName;
  get email => _email;
  get preferredCabStation => _preferredCabStation;
  get car => _car;
  get driverId => _driverId;

  set firstName(value) {
    _firstName = value;
    notifyListeners();
  }

  set lastName(value) {
    _lastName = value;
    notifyListeners();
  }

  set email(value) {
    _email = value;
    notifyListeners();
  }

  set preferredCabStation(value) {
    _preferredCabStation = value;
    notifyListeners();
  }

  set car(value) {
    _car = value;
    notifyListeners();
  }

  set driverId(value) {
    _driverId = value;
    notifyListeners();
  }

  set phoneNumber(value) {
    _phoneNumber = value;
    notifyListeners();
  }
}
