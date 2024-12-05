import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverMapScreen extends StatefulWidget {
  final LatLng driverLocation;
  final LatLng pickupLocation;
  final LatLng destinationLocation;
  final String customerPhoneNumber;

  const DriverMapScreen({
    required this.driverLocation,
    required this.pickupLocation,
    required this.destinationLocation,
    required this.customerPhoneNumber,
    super.key,
  });

  @override
  State<DriverMapScreen> createState() => _DriverMapScreenState();
}

class _DriverMapScreenState extends State<DriverMapScreen> {
  late GoogleMapController _mapController;

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();

    _markers.add(Marker(
      markerId: const MarkerId('driver'),
      position: widget.driverLocation,
      infoWindow: const InfoWindow(title: 'Driver Location'),
    ));

    _markers.add(Marker(
      markerId: const MarkerId('pickup'),
      position: widget.pickupLocation,
      infoWindow: const InfoWindow(title: 'Pickup Location'),
    ));

    _markers.add(Marker(
      markerId: const MarkerId('destination'),
      position: widget.destinationLocation,
      infoWindow: const InfoWindow(title: 'Destination'),
    ));
  }

  // void _launchCall(String phoneNumber) async {
  //   final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
  //   if (await canLaunchUrl(callUri)) {
  //     await launchUrl(callUri);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Could not make the call')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Navigation'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: widget.driverLocation,
              zoom: 14.0,
            ),
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton.icon(
              onPressed: () => null, //_launchCall(widget.customerPhoneNumber),
              icon: const Icon(Icons.phone),
              label: const Text('Call Customer'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
