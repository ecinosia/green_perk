import 'package:flutter/material.dart';
import 'package:green_perk/auth/auth.dart';
import 'package:green_perk/constants/app_colors.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmController,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (fullNameController.text == "") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text('You must enter your full name!'),
                actions: [
                  TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            },
          );
        } else if (emailController.text == "") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text('You must enter an email address!'),
                actions: [
                  TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            },
          );
        } else if (passwordController.text == "") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text('You must enter a password!'),
                actions: [
                  TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            },
          );
        } else if (passwordController.text != passwordConfirmController.text) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text('The passwords are not matched!'),
                actions: [
                  TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            },
          );
        } else {
          registerToFb(
              context, fullNameController, emailController, passwordController);
        }
      },
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
    );
  }
}
