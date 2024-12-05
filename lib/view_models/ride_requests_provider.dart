import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/ride_requests_model.dart';

class RideRequestsProvider with ChangeNotifier {
  List<RideRequest> _rideRequests = [];

  List<RideRequest> get rideRequests => _rideRequests;

  void fetchRideRequests() async {
    FirebaseFirestore.instance
        .collection('rideRequests')
        .where('status', isEqualTo: 'requested')
        .snapshots()
        .listen((snapshot) {
      _rideRequests =
          snapshot.docs.map((doc) => RideRequest.fromFirestore(doc)).toList();
      notifyListeners();
    });
  }

  Future<void> acceptRide(String requestId, String driverId) async {
    await FirebaseFirestore.instance
        .collection('rideRequests')
        .doc(requestId)
        .update({
      'status': 'confirmed',
      'driverId': driverId,
    });
  }

  Future<void> rejectRide(String requestId) async {
    await FirebaseFirestore.instance
        .collection('rideRequests')
        .doc(requestId)
        .update({
      'status': 'cancelled',
    });
  }
}
