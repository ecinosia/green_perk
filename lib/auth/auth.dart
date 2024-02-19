import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void registerToFb(
    BuildContext context,
    TextEditingController fullNameController,
    TextEditingController emailController,
    TextEditingController passwordController) {
  final FirebaseAuth auth = FirebaseAuth.instance;
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
      context.go('/home_page');
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
