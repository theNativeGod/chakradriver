import 'package:cloud_firestore/cloud_firestore.dart';

class RideRequest {
  final String requestId;
  final String? driverId;
  final String userId;
  final String status;
  final String rideType;
  final Map<String, dynamic> pickup; // Changed to Map for nested structure
  final Map<String, dynamic> destination; // Changed to Map for nested structure

  RideRequest({
    required this.requestId,
    this.driverId,
    required this.userId,
    required this.status,
    required this.rideType,
    required this.pickup,
    required this.destination,
  });

  // Factory constructor to create RideRequest from Firestore data
  factory RideRequest.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return RideRequest(
      requestId: doc.id,
      driverId: data['driverId'] as String?,
      userId: data['userId'] as String,
      status: data['status'] as String,
      rideType: data['rideType'] as String,
      pickup: data['pickup'] as Map<String, dynamic>, // Explicit map cast
      destination:
          data['destination'] as Map<String, dynamic>, // Explicit map cast
    );
  }

  // Optional: Convenience methods to extract details from nested fields
  String get pickupAddress => pickup['address'] as String;
  double get pickupLat => pickup['lat'] as double;
  double get pickupLng => pickup['lng'] as double;

  String get destinationAddress => destination['address'] as String;
  double get destinationLat => destination['lat'] as double;
  double get destinationLng => destination['lng'] as double;
}
