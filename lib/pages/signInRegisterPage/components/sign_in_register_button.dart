import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_perk/constants/app_colors.dart';

class SignInRegisterButton extends StatelessWidget {
  const SignInRegisterButton({
    super.key,
    required this.text,
    required this.route,
  });

  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: () => context.go(route),
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            textStyle: TextStyle(
              color: AppColors.textGreen,
            )),
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.textGreen,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
