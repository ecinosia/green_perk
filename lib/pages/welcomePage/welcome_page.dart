import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:green_perk/constants/app_colors.dart';

import 'components/lets_go_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .5,
      height: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.primaryGreen,
      ),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 60.0, bottom: 15),
              child: Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  "lib/assets/images/right_corner.png",
                  width: 80,
                ),
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  textSpan("make\n", AppColors.primaryBlue),
                  textSpan("planet\n", AppColors.primaryBlue),
                  textSpan("green\n", AppColors.textPink),
                  textSpan("again\n", AppColors.primaryBlue),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 60.0,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  "lib/assets/images/left_corner.png",
                  width: 80,
                ),
              ),
            ),
            const LetsGoButton(),
          ],
        ),
      ),
    );
  }

  TextSpan textSpan(String text, Color color) {
    return TextSpan(
        text: text,
        style: TextStyle(
          height: .8,
          fontSize: 65,
          fontFamily: 'Boardley',
          decoration: TextDecoration.none,
          color: color,
          fontWeight: FontWeight.w100,
        ));
  }
}
