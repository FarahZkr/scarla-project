/*
 * Copyright (c) 2021. Scarla
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_util.dart';

final _googleSignIn = GoogleSignIn();

/// Connecte l'utilisateur à Firebase en utilisant l'authentification Google
Future<User> signInWithGoogle(BuildContext context) async {
  final signInFunc = () async {
    await signOutWithGoogle().catchError((_) => null);
    final auth = await (await _googleSignIn.signIn())?.authentication;
    if (auth == null) {
      return null;
    }
    final credential = GoogleAuthProvider.credential(
        idToken: auth.idToken, accessToken: auth.accessToken);
    return FirebaseAuth.instance.signInWithCredential(credential);
  };
  return signInOrCreateAccount(context, signInFunc);
}

/// Déconnecte l'utilisateur de Google
Future signOutWithGoogle() => _googleSignIn.signOut();
