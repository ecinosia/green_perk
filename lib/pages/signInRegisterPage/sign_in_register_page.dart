import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_colors.dart';

class SignInRegisterPage extends StatefulWidget {
  const SignInRegisterPage({super.key});

  @override
  State<SignInRegisterPage> createState() => _SignInRegisterPageState();
}

class _SignInRegisterPageState extends State<SignInRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .5,
      height: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.primaryGreen,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    "lib/assets/images/left_corner.png",
                    width: 30,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    textSpan("make ", AppColors.primaryBlue),
                    textSpan("planet ", AppColors.primaryBlue),
                    textSpan("green ", AppColors.textPink),
                    textSpan("again", AppColors.primaryBlue),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    "lib/assets/images/right_corner.png",
                    width: 30,
                  ),
                ),
              ),
            ],
          ),
          const Column(
            children: [
              SignInRegisterButton(
                  text: 'Sign In',
                  route: '/sign_in_register_page/sign_in_page'),
              SizedBox(
                height: 10,
              ),
              SignInRegisterButton(
                  text: 'Sign Up',
                  route: '/sign_in_register_page/sign_up_page'),
            ],
          ),
        ],
      ),
    );
  }

  TextSpan textSpan(String text, Color color) {
    return TextSpan(
        text: text,
        style: TextStyle(
          height: .8,
          fontSize: 35,
          fontFamily: 'Boardley',
          decoration: TextDecoration.none,
          color: color,
          fontWeight: FontWeight.w100,
        ));
  }
}

class SignInRegisterButton extends StatelessWidget {
  const SignInRegisterButton({
    super.key,
    required this.text,
    required this.route,
  });

  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: () => context.go(route),
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            textStyle: TextStyle(
              color: AppColors.textGreen,
            )),
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.textGreen,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
