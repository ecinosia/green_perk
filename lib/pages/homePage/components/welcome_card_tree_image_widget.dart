import 'package:flutter/material.dart';

class WelcomeCardTreeImageWidget extends StatelessWidget {
  const WelcomeCardTreeImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/assets/images/tree.png',
      width: 125,
    );
  }
}
