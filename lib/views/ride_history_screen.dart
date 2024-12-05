import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/ride_requests_model.dart';

// class RideRequest {
//   final String requestId;
//   final String? driverId;
//   final String userId;
//   final String status;
//   final String rideType;
//   final Map<String, dynamic> pickup;
//   final Map<String, dynamic> destination;

//   RideRequest({
//     required this.requestId,
//     this.driverId,
//     required this.userId,
//     required this.status,
//     required this.rideType,
//     required this.pickup,
//     required this.destination,
//   });

//   factory RideRequest.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return RideRequest(
//       requestId: doc.id,
//       driverId: data['driverId'] as String?,
//       userId: data['userId'] as String,
//       status: data['status'] as String,
//       rideType: data['rideType'] as String,
//       pickup: data['pickup'] as Map<String, dynamic>,
//       destination: data['destination'] as Map<String, dynamic>,
//     );
//   }
// }

class DriverRideHistoryScreen extends StatelessWidget {
  final String driverId;

  DriverRideHistoryScreen({required this.driverId});

  Future<List<RideRequest>> fetchRideHistory() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('rideRequests')
        .where('driverId', isEqualTo: driverId)
        // .orderBy('status') // Primary order
        // .orderBy('timestamp', descending: true) // Secondary order
        .get();

    return querySnapshot.docs
        .map((doc) => RideRequest.fromFirestore(doc))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ride History"),
      ),
      body: FutureBuilder<List<RideRequest>>(
        future: fetchRideHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No rides found."));
          }

          final rideRequests = snapshot.data!;
          return ListView.separated(
            itemCount: rideRequests.length,
            separatorBuilder: (_, __) => Divider(),
            itemBuilder: (context, index) {
              final ride = rideRequests[index];
              return ListTile(
                title: Text("Ride Type: ${ride.rideType}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pickup: ${ride.pickup['address']}"),
                    Text("Destination: ${ride.destination['address']}"),
                    Text("Status: ${ride.status}"),
                  ],
                ),
                trailing: Text("User: ${ride.userId}"),
              );
            },
          );
        },
      ),
    );
  }
}
