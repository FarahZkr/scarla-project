/*
 * Copyright (c) 2021. Scarla
 */

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

/// Lance le [url] entré dans un navigateur internet
Future launchURL(String url) async {
  var uri = Uri.parse(url).toString();
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}

/// Crée des mots-clés pour [s]
List<String> createKeys(String s) {
  List<String> list = <String>[];

  var curName = '';

  for (final i in s.split('')) {
    curName += i.toLowerCase();
    list.add(curName);
  }

  return list;
}

/// Donne le Timestamp du moment
Timestamp get getCurrentTimestamp => Timestamp.fromDate(DateTime.now());

/// Si la plateforme est IOS
bool get isIos => Platform.isIOS;
