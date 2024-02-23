import 'package:flutter/material.dart';
import 'package:green_perk/components/h40_custom_sized_box.dart';
import '../../constants/app_colors.dart';
import 'components/custom_text_form_field_widget.dart';
import 'components/input_label.dart';
import 'components/password_confirm_text_form_field_widget.dart';
import 'components/password_text_form_field_widget.dart';
import 'components/sign_up_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryGreen,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'makeplanetgreenagain',
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
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
              Column(
                children: [
                  const InputLabel(text: 'Full Name'),
                  CustomTextFormFieldWidget(
                    controller: fullNameController,
                  ),
                  const H40CustomSizedBox(),
                  const InputLabel(text: 'E-mail'),
                  CustomTextFormFieldWidget(
                    controller: emailController,
                  ),
                  const H40CustomSizedBox(),
                  const InputLabel(text: 'Password'),
                  PasswordTextFormFieldWidget(
                      passwordController: passwordController),
                  const H40CustomSizedBox(),
                  const InputLabel(text: 'Confirm Password'),
                  PasswordConfirmTextFormFieldWidget(
                      passwordConfirmController: passwordConfirmController),
                  const H40CustomSizedBox(),
                  SignUpButton(
                    fullNameController: fullNameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    passwordConfirmController: passwordConfirmController,
                  ),
                  const H40CustomSizedBox(),
                ],
              ),
            ],
          ),
        ),
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
