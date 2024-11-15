import 'package:chakracabsrider/view_models/signup_provider.dart';
import 'package:chakracabsrider/views/auth_screens/login_screen/login_screen.dart';
import 'package:chakracabsrider/views/driver_details/utils/detail_button.dart';
import 'package:chakracabsrider/views/helper.dart';
import 'package:chakracabsrider/views/widgets/export.dart';
import 'package:chakracabsrider/views/widgets/top_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utils/export.dart';

class DriverDetailsScreen extends StatelessWidget {
  const DriverDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> driveMenu = [
      'Driving License',
      'Profile Photo',
      'Aadhaar Card',
      'PAN Card',
      'Registration Certificate (RC)',
      'Vehicle Insurance',
      'Vehicle Permit',
      'Add Your Bank Details',
    ];

    var signupProivder = Provider.of<SignupProvider>(context);
    String driverId = signupProivder.driverId;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopBar(),
            const SizedBox(height: 16),
            const HeadingTextWelcome(text: 'Welcome Anmol'),
            const SizedBox(height: 8),
            const Text(
              'You\'ll need these items to set up your account',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (ctx, i) => DriverDetailMenu(
                text: driveMenu[i],
                driverId: driverId,
              ),
              separatorBuilder: (ctx, i) => const SizedBox(
                height: 8,
              ),
              itemCount: driveMenu.length,
            ),
            const SizedBox(height: 16),
            AuthButton(onTap: () async {
              final firestoreRef = FirebaseFirestore.instance
                  .collection('drivers')
                  .doc(driverId);
              await firestoreRef.set({
                'driverId': driverId,
                'firstName': signupProivder.firstName,
                'lastName': signupProivder.lastName,
                'email': signupProivder.email,
                'cabStation': signupProivder.preferredCabStation,
                'car': signupProivder.car,
                'fullPhoneNumber': signupProivder.phoneNumber,
              });

              showSnackbar('Signed up successfully', Colors.green, context);
              replace(context, LoginScreen());
            }),
          ],
        ),
      ),
    ));
  }
}
