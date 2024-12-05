import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  final String pickup;
  final String destination;
  final String requestId;

  const MapScreen({
    Key? key,
    required this.pickup,
    required this.destination,
    required this.requestId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ride in Progress"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "Navigating from $pickup to $destination",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Add functionality to complete the ride
                Navigator.pop(context); // Go back after completing
              },
              child: const Text("Complete Ride"),
            ),
          ),
        ],
      ),
    );
  }
}
