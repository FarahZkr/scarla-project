/*
 * Copyright (c) 2021. Scarla
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_util.dart';

/// Connecte anonymement l'utilisateur avec Firebase
Future<User> signInAnonymously(BuildContext context) async {
  final signInFunc = () => FirebaseAuth.instance.signInAnonymously();
  return signInOrCreateAccount(context, signInFunc);
}
