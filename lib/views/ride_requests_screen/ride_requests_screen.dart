import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/ride_requests_model.dart';

class RideRequestsScreen extends StatelessWidget {
  final String driverId;

  const RideRequestsScreen({required this.driverId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Ride Requests"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('rideRequests')
            .where('status', isEqualTo: 'requested')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No ride requests available"));
          }

          var rideRequests = snapshot.data!.docs
              .map((doc) => RideRequest.fromFirestore(doc))
              .toList();

          return ListView.builder(
            itemCount: rideRequests.length,
            itemBuilder: (context, index) {
              var rideRequest = rideRequests[index];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text("Pickup: ${rideRequest.pickup}"),
                  subtitle: Text("Destination: ${rideRequest.destination}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check, color: Colors.green),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('rideRequests')
                              .doc(rideRequest.requestId)
                              .update({
                            'status': 'confirmed',
                            'driverId': driverId,
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.red),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('rideRequests')
                              .doc(rideRequest.requestId)
                              .update({
                            'status': 'cancelled',
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}