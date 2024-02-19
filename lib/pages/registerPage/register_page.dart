import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_perk/components/h40_custom_sized_box.dart';

import '../../constants/app_colors.dart';
import 'components/custom_text_form_field_widget.dart';
import 'components/input_label.dart';

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
          height: MediaQuery.of(context).size.height,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Material(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: AppColors.primaryBlue,
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        cursorColor: AppColors.textPink,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: AppColors.textPink,
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                    ),
                  ),
                  const H40CustomSizedBox(),
                  const InputLabel(text: 'Confirm Password'),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Material(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: AppColors.primaryBlue,
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordConfirmController,
                        cursorColor: AppColors.textPink,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: AppColors.textPink,
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                    ),
                  ),
                  const H40CustomSizedBox(),
                  ElevatedButton(
                    onPressed: () => context.go('/home_page'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textPink,
                      minimumSize: const Size(
                        150,
                        50,
                      ),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
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
