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
    return SizedBox(
      width: MediaQuery.of(context).size.width * .5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WelcomeCardWelcomeTextWidget(userName: userName),
          const WelcomeCardDescTextWidget(),
        ],
      ),
    );
  }
}
