import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'components/sign_in_register_button.dart';

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
          Hero(
            tag: 'makeplanetgreenagain',
            child: Row(
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
