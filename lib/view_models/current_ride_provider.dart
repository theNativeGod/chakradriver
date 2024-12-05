import 'package:chakracabsrider/models/ride_requests_model.dart';
import 'package:flutter/material.dart';

class CurrentRideProvider with ChangeNotifier {
  RideRequest? _rideRequest;

  get rideRequest => _rideRequest;

  set rideRequest(value) {
    _rideRequest = value;
    notifyListeners();
  }
}
