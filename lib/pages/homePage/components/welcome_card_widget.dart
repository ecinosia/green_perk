import 'package:flutter/material.dart';
import 'package:green_perk/pages/homePage/components/welcome_main_widget.dart';

class WelcomeCardWidget extends StatelessWidget {
  const WelcomeCardWidget({
    super.key,
    required this.userName,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    return WelcomeMainWidget(userName: userName);
  }
}
