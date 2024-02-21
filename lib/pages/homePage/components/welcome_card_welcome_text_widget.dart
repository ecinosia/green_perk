import 'package:flutter/material.dart';
import 'package:green_perk/constants/app_colors.dart';

class WelcomeCardWelcomeTextWidget extends StatelessWidget {
  const WelcomeCardWelcomeTextWidget({
    super.key,
    required this.userName,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome $userName!',
      style: TextStyle(
        fontFamily: 'Google Sans',
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: AppColors.textGreen,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
