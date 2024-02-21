import 'package:flutter/material.dart';
import 'package:green_perk/constants/app_colors.dart';

class CustomElevatedButtonForImage extends StatelessWidget {
  const CustomElevatedButtonForImage({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          fixedSize: Size(MediaQuery.of(context).size.width * .42, 50)),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'Cy Grotestk Key',
          fontSize: 15,
          color: AppColors.white,
        ),
      ),
    );
  }
}
