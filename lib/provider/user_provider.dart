import 'package:bti_test_app/models/user.dart';
import 'package:bti_test_app/services/sqflite/table/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;
  set user(UserModel? value) {
    _user = value;
    notifyListeners();
  }

  Future<UserModel?> getUser() async {
    final db = UserDB();
    try {
      final response = await db.getUser();
      user = response;
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insertUser(UserModel user) async {
    final db = UserDB();
    try {
      await db.insert(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser() async {
    final db = UserDB();
    try {
      await db.delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      user = UserModel(
        name: result.user?.displayName,
        email: result.user?.email,
      );
      await insertUser(user!);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future logout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    await deleteUser();
  }
}
