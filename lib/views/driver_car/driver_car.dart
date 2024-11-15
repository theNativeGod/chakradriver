import 'package:chakracabsrider/view_models/signup_provider.dart';
import 'package:chakracabsrider/views/driver_details/driver_details_screen.dart';
import 'package:chakracabsrider/views/helper.dart';
import 'package:chakracabsrider/views/widgets/export.dart';
import 'package:chakracabsrider/views/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverCarScreen extends StatefulWidget {
  const DriverCarScreen({super.key});

  @override
  State<DriverCarScreen> createState() => _DriverCarScreenState();
}

class _DriverCarScreenState extends State<DriverCarScreen> {
  String? selectedCar; // Track the selected car option

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBar(),
              const SizedBox(height: 16),
              const HeadingTextWelcome(
                text: 'Chakra allows you to earn in the way you see fit',
              ),
              const SizedBox(height: 16),
              DriverCar(
                text: 'Sedan',
                isSelected: selectedCar == 'Sedan',
                onTap: () => setState(() {
                  selectedCar = 'Sedan';
                }),
              ),
              const SizedBox(height: 8),
              DriverCar(
                text: 'Mini',
                isSelected: selectedCar == 'Mini',
                onTap: () => setState(() {
                  selectedCar = 'Mini';
                }),
              ),
              const SizedBox(height: 8),
              DriverCar(
                text: 'Premium SUV',
                isSelected: selectedCar == 'Premium SUV',
                onTap: () => setState(() {
                  selectedCar = 'Premium SUV';
                }),
              ),
              SizedBox(height: 16),
              AuthButton(
                onTap: () {
                  if (selectedCar != null) {
                    Provider.of<SignupProvider>(context, listen: false).car =
                        selectedCar;
                    push(context, DriverDetailsScreen());
                  } else {
                    showSnackbar(
                        'Please select a Car type', Colors.red, context);
                  }

                  // Handle further actions with the selectedCar option
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DriverCar extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const DriverCar({
    required this.text,
    required this.onTap,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey, // Highlight if selected
          ),
        ),
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Row(
          children: [
            Flexible(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.',
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Flexible(flex: 1, child: Image.asset('assets/images/car.png'))
          ],
        ),
      ),
    );
  }
}
