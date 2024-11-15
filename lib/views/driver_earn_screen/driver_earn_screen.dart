import 'package:chakracabsrider/main.dart';
import 'package:chakracabsrider/view_models/signup_provider.dart';
import 'package:chakracabsrider/views/driver_car/driver_car.dart';
import 'package:chakracabsrider/views/helper.dart';
import 'package:chakracabsrider/views/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/export.dart';
import 'utils/export.dart';

class DriverEarnScreen extends StatelessWidget {
  const DriverEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBar(),
              const SizedBox(height: 16),
              const HeadingTextWelcome(text: 'Join Chakra & Earn'),
              const SizedBox(height: 8),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                'Where do you prefer to earn money',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              CustomDropdown(),
              const SizedBox(height: 16),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aliquam sem et tortor consequat id porta. Viverra vitae congue eu consequat ac felis donec.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              AuthButton(onTap: () {
                if (Provider.of<SignupProvider>(context, listen: false)
                        .preferredCabStation !=
                    "") {
                  push(context, DriverCarScreen());
                } else {
                  showSnackbar('Please select a cab hub', Colors.red, context);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
