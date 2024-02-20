import 'package:flutter/material.dart';

import 'welcome_card_desc_text_widget.dart';
import 'welcome_card_welcome_text_widget.dart';

class WelcomeColumnWidget extends StatelessWidget {
  const WelcomeColumnWidget({
    super.key,
    required this.userName,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WelcomeCardWelcomeTextWidget(userName: userName),
        const WelcomeCardDescTextWidget(),
      ],
    );
  }
}
