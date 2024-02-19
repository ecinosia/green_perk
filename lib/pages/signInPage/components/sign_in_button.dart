import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_perk/constants/app_colors.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.go('/home_page'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.textPink,
        minimumSize: const Size(
          150,
          50,
        ),
      ),
      child: Text(
        "Sign In",
        style: TextStyle(
          fontSize: 24,
          color: AppColors.primaryBlue,
        ),
      ),
    );
  }
}
