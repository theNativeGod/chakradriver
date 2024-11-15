import 'package:flutter/material.dart';

class HelpButton extends StatelessWidget {
  const HelpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 2,
      ),
      // alignment: Alignment.center,
      child: const Text(
        'Help',
        style: TextStyle(
          color: Colors.white,
          shadows: [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 1,
            )
          ],
        ),
      ),
    );
  }
}
