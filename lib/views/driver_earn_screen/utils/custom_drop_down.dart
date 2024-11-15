import 'package:chakracabsrider/view_models/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDropdown extends StatefulWidget {
  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedOption;
  bool isDropdownOpen = false;
  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];

  void toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: toggleDropdown,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: .5,
                  blurRadius: 3,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedOption ?? 'Select an option',
                  style: const TextStyle(color: Colors.black),
                ),
                Icon(
                  isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        if (isDropdownOpen)
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0, 1),
                  spreadRadius: .5,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: options.map((option) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOption = option;
                      Provider.of<SignupProvider>(context, listen: false)
                          .preferredCabStation = selectedOption;
                      isDropdownOpen = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      option,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
