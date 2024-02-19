import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_perk/constants/app_colors.dart';

class LetsGoButton extends StatelessWidget {
  const LetsGoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 120,
      right: 135,
      child: ElevatedButton(
        onPressed: () => context.go('/sign_in_register_page'),
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            textStyle: TextStyle(
              color: AppColors.textGreen,
            )),
        child: Text(
          "Let's Go",
          style: TextStyle(
            color: AppColors.textGreen,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
