import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nutrobo/extensions/cubit.dart';

class AuthService {

  final FirebaseAuth auth;
  final _loggedInState = BoolCubit(false);
  Stream<bool> get loggedInStream => _loggedInState.stream;

  AuthService({required this.auth}) {
    auth.authStateChanges().listen((user) {
      _loggedInState.update(user != null);
    });
  }

  bool get isLoggedIn {
    return auth.currentUser != null;
  }

  Future<String> getToken({bool force = false}) async {
    return await auth.currentUser?.getIdToken(force) ?? "";
  }

  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final cred = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await _signIn(cred);
  }

  Future<bool> _signIn(AuthCredential credential) async {
    final cred = await auth.signInWithCredential(credential);
    final success = cred.user != null;

    _loggedInState.update(success);

    return success;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

}