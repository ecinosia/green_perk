import 'package:flutter/material.dart';
import 'package:green_perk/constants/app_colors.dart';

class WelcomeCardDescTextWidget extends StatelessWidget {
  const WelcomeCardDescTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Have you recycled\nanything today?',
      style: TextStyle(
        fontFamily: 'Cy Grotestk Key',
        fontSize: 20,
        color: AppColors.textGreen,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
