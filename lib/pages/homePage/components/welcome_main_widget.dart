import 'package:flutter/material.dart';
import 'package:green_perk/constants/app_colors.dart';

import 'welcome_row_widget.dart';

class WelcomeMainWidget extends StatelessWidget {
  const WelcomeMainWidget({
    super.key,
    required this.userName,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      height: MediaQuery.of(context).size.height * .2,
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: AppColors.primaryGreen,
            width: 3,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: WelcomeRowWidget(userName: userName),
        ),
      ),
    );
  }
}
