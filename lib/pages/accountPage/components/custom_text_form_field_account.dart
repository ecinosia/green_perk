import 'package:flutter/material.dart';
import 'package:green_perk/constants/app_colors.dart';

class CustomTextFormFieldAccount extends StatelessWidget {
  const CustomTextFormFieldAccount({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.label,
  });

  final TextEditingController controller;
  final bool obscureText;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, top: 20),
            child: Text(
              label,
              style: TextStyle(
                height: 1.5,
                decoration: TextDecoration.none,
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20,
          ),
          child: Material(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            color: AppColors.primaryGreen,
            child: TextFormField(
              obscureText: obscureText,
              controller: controller,
              cursorColor: AppColors.textPink,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: AppColors.textPink,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontFamily: 'Cy Grotestk Key',
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
