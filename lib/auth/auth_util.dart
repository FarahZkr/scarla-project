/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../backend/backend.dart';
import 'firebase_user_provider.dart';

export 'anonymous_auth.dart';
export 'apple_auth.dart';
export 'email_auth.dart';
export 'google_auth.dart';

/// Tries to sign in or create an account using Firebase Auth.
/// Returns the User object if sign in was successful.
Future<User> signInOrCreateAccount(
    BuildContext context, Future<UserCredential> Function() signInFunc) async {
  try {
    final userCredential = await signInFunc();
    await maybeCreateUser(userCredential.user);
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.message}')),
    );
    return null;
  }
}

/// Déconnecte l'utilisateur
Future signOut() => FirebaseAuth.instance.signOut();

/// Envoie un email de réinitialisation de mot de passe à l'utilisateur
Future resetPassword({String email, BuildContext context}) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.message}')),
    );
    return null;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Password reset email sent!')),
  );
}

/// Retourne l'email de l'utilisateur connecté
String get currentUserEmail => currentUser?.user?.email ?? '';

/// Retourne l'id de l'utilisateur connecté
String get currentUserUid => currentUser?.user?.uid ?? '';

/// Retourne le nom de compte de l'utilisateur connecté
String get currentUserDisplayName => currentUser?.user?.displayName ?? '';

/// Retourne la photo de profil de l'utilisateur connecté
String get currentUserPhoto => currentUser?.user?.photoURL ?? '';

/// Retourne le document de l'utilisateur connecté dans la base de données
DocumentReference get currentUserReference => currentUser?.user != null
    ? UsersRecord.collection.doc(currentUser.user.uid)
    : null;
