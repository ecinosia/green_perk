import 'package:flutter/material.dart';
import 'package:green_perk/constants/app_colors.dart';

class SelectImageTextWidget extends StatelessWidget {
  const SelectImageTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'Please select an\nimage or take a photo!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Cy Grotestk Key',
          fontSize: 26,
          color: AppColors.white,
        ),
      ),
    );
  }
}
