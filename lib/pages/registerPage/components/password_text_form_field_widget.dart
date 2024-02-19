import 'package:flutter/material.dart';
import 'package:green_perk/constants/app_colors.dart';

class PasswordTextFormFieldWidget extends StatelessWidget {
  const PasswordTextFormFieldWidget({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Material(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        color: AppColors.primaryBlue,
        child: TextFormField(
          obscureText: true,
          controller: passwordController,
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
        ),
      ),
    );
  }
}
