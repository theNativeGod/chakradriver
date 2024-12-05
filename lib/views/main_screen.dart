import 'package:flutter/material.dart';

import 'home_screen/home_screen.dart';
import 'ride_history_screen.dart';
import 'ride_requests_screen/ride_requests_screen.dart';
import 'user_profile_screen.dart';

// Create this screen

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // Tracks the selected tab

  final List<Widget> _pages = [
    const RideRequestsScreen(
      driverId: '74abd0a6-017e-45ae-986a-338ad6e1375a',
    ),
    // HomeScreen content
    DriverRideHistoryScreen(
      driverId: '74abd0a6-017e-45ae-986a-338ad6e1375a',
    ), // Replace with actual RideHistoryScreen
    const UserProfileScreen(), // Replace with actual UserProfileScreen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Ride History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
