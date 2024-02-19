import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection("users");

  User? get currentUser => _auth.currentUser;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String fullname) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await userCollection.doc(credential.user!.uid).set({
        'fullname': fullname,
        'email': email,
        'password': password,
      });

      return credential.user;
    } catch (e) {
      debugPrint("Error signing up: $e");
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      debugPrint("Error signing in: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
