import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class Driver {
  String driverId;
  String firstName;
  String lastName;
  String email;
  String fullPhoneNumber;
  String cabStation;
  LatLng? currentLocation; // Optional field for the driver's current location
  Timer? locationUpdater; // Timer to update location periodically

  Driver({
    required this.driverId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.fullPhoneNumber,
    required this.cabStation,
    this.currentLocation, // Optional
  });

  // Convert a Driver to a Firestore document
  Map<String, dynamic> toMap() {
    return {
      'driverId': driverId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'fullPhoneNumber': fullPhoneNumber,
      'cabStation': cabStation,
      'currentLocation': currentLocation != null
          ? {
              'lat': currentLocation!.latitude,
              'lng': currentLocation!.longitude,
            }
          : null, // Include currentLocation if available
    };
  }

  // Create a Driver from a Firestore document snapshot
  factory Driver.fromMap(String driverId, Map<String, dynamic> map) {
    return Driver(
      driverId: driverId,
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      fullPhoneNumber: map['fullPhoneNumber'],
      cabStation: map['cabStation'],
      currentLocation: map['currentLocation'] != null
          ? LatLng(
              map['currentLocation']['lat'],
              map['currentLocation']['lng'],
            )
          : null, // Parse currentLocation if available
    );
  }

  // Start updating the driver's location to Firestore every 3 seconds
  void startUpdatingLocation() {
    locationUpdater = Timer.periodic(Duration(seconds: 3), (timer) async {
      if (currentLocation != null) {
        await FirebaseFirestore.instance
            .collection('drivers')
            .doc(driverId)
            .update({
          'currentLocation': {
            'lat': currentLocation!.latitude,
            'lng': currentLocation!.longitude,
          },
        });
      }
    });
  }

  // Stop updating the driver's location
  void stopUpdatingLocation() {
    locationUpdater?.cancel();
    locationUpdater = null;
  }
}
