import 'package:flutter/material.dart';

import 'welcome_card_tree_image_widget.dart';
import 'welcome_column_widget.dart';

class WelcomeRowWidget extends StatelessWidget {
  const WelcomeRowWidget({
    super.key,
    required this.userName,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WelcomeColumnWidget(userName: userName),
        const WelcomeCardTreeImageWidget(),
      ],
    );
  }
}
