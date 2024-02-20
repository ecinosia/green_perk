import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
void registerToFb(
    BuildContext context,
    TextEditingController fullNameController,
    TextEditingController emailController,
    TextEditingController passwordController) {
  final dbRef = FirebaseFirestore.instance.collection("users");

  auth
      .createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text)
      .then((result) {
    dbRef.doc(result.user!.uid).set({
      'fullname': fullNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    }).then((res) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Welcome"),
            content: Text(
                "You successfuly registered.\nRedirecting to sign in page!"),
          );
        },
      );
      Future.delayed(
        const Duration(seconds: 5),
        () {
          context.go('/sign_in_register_page/sign_in_page');
        },
      );
    });
  }).catchError((err) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(err.message),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  });
}

void signIn(BuildContext context, TextEditingController emailController,
    TextEditingController passwordController) {
  auth
      .signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text)
      .then(
    (result) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Welcome back!"),
            content:
                Text("You successfuly signed in.\nRedirecting to home page!"),
          );
        },
      );
      Future.delayed(
        const Duration(seconds: 5),
        () {
          context.go('/home_page');
        },
      );
    },
  ).catchError((err) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(err.message),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  });
}

void signOut() {
  auth.signOut();
}

String? returnUserName() {
  final User? user = auth.currentUser;
  final uid = user?.uid;
  return uid;
}
