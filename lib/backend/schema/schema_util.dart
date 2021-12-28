/*
 * Copyright (c) 2021. Scarla
 */

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

final random = Random();

/// Génère un nombre entier entre 0 et 10
int get dummyInteger => random.nextInt(10);

/// Génère un nombre à virgule
double get dummyDouble => random.nextDouble() * 10;

/// Génère un boolean
bool get dummyBoolean => random.nextBool();

///Génère un String
String get dummyString => [
      'Lorem ipsum',
      'dolor sit',
      'amet consectetur',
      'adipiscing elit'
    ][random.nextInt(4)];

/// Génère un lien d'image
String get dummyImagePath =>
    "https://picsum.photos/seed/${random.nextInt(1000)}/400";

/// Génère un lien de vidéo
String get dummyVideoPath => 'https://assets.mixkit.co/videos/preview/'
    'mixkit-forest-stream-in-the-sunlight-529-large.mp4';

/// Génère un Timestamp
Timestamp get dummyTimestamp => Timestamp.fromMillisecondsSinceEpoch(
    1612302574000 - (random.nextDouble() * 8000000000).round());
