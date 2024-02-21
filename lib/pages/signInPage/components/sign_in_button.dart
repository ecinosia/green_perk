import 'package:flutter/material.dart';
import 'package:green_perk/auth/auth.dart';
import 'package:green_perk/constants/app_colors.dart';

class SignInButton extends StatefulWidget {
  const SignInButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        signIn(context, widget.emailController, widget.passwordController);
      },
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
