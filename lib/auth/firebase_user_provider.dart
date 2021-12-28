/*
 * Copyright (c) 2021. Scarla
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

/// Classe d'informations sur l'utilisateur courant
class ScarlaFirebaseUser {
  ScarlaFirebaseUser(this.user);

  /// utilisateur Firebase
  final User user;

  /// boolean de si l'utilisateur est connecté ou non
  bool get loggedIn => user != null;
}

ScarlaFirebaseUser currentUser;

bool get loggedIn => currentUser?.loggedIn ?? false;

/// Stream sur l'état de l'utilisateur
Stream<ScarlaFirebaseUser> scarlaFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<ScarlaFirebaseUser>((user) => currentUser = ScarlaFirebaseUser(user));
