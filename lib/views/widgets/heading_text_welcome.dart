import 'package:flutter/material.dart';

class HeadingTextWelcome extends StatelessWidget {
  const HeadingTextWelcome({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
