import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../components/h40_custom_sized_box.dart';
import 'components/email_input_field.dart';
import 'components/input_label_text.dart';
import 'components/password_input_field.dart';
import 'components/sign_in_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: AppColors.primaryGreen,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'makeplanetgreenagain',
              child: textWidget(),
            ),
            Column(
              children: [
                const InputLabelText(text: 'E-mail'),
                EmailInputField(
                  emailController: emailController,
                ),
                const H40CustomSizedBox(),
                const InputLabelText(text: 'Password'),
                PasswordInputField(
                  passwordController: passwordController,
                ),
                const H40CustomSizedBox(),
                SignInButton(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row textWidget() {
    return Row(
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
