import 'package:flutter/material.dart';
import 'package:green_perk/constants/app_colors.dart';

class PageTitleWidget extends StatelessWidget {
  const PageTitleWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 30,
            color: AppColors.textGreen,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
