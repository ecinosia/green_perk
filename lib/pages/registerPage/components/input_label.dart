import 'package:flutter/material.dart';
import 'package:green_perk/constants/app_colors.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 50.0),
        child: Text(
          text,
          style: TextStyle(
            height: 1.5,
            decoration: TextDecoration.none,
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
