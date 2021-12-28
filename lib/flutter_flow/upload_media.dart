/*
 * Copyright (c) 2021. Scarla
 */

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';

import '../auth/auth_util.dart';

/// Formats de fichier acceptés
const allowedFormats = {'image/png', 'image/jpeg', 'video/mp4', 'image/gif'};

/// Classe de médias
class SelectedMedia {
  const SelectedMedia(this.storagePath, this.bytes);

  final String storagePath;
  final Uint8List bytes;
}

/// Sélectionne un média
Future<SelectedMedia> selectMedia({
  double maxWidth,
  double maxHeight,
  bool isVideo = false,
  bool fromCamera = false,
}) async {
  final picker = ImagePicker();
  final source = fromCamera ? ImageSource.camera : ImageSource.gallery;
  final pickedMediaFuture = isVideo
      ? picker.getVideo(source: source)
      : picker.getImage(
          maxWidth: maxWidth, maxHeight: maxHeight, source: source);
  final pickedMedia = await pickedMediaFuture;
  final mediaBytes = await pickedMedia?.readAsBytes();
  if (mediaBytes == null) {
    return null;
  }
  final path = storagePath(currentUserUid, pickedMedia.path, isVideo);
  return SelectedMedia(path, mediaBytes);
}

/// Valide le format et la taille du fichier
Future<bool> validateFileFormat(String filePath, BuildContext context) async {
  PickedFile pickedFile = PickedFile(filePath);
  bool tailleCorrect = (await pickedFile.readAsBytes()).length < 20000000;
  if (allowedFormats.contains(mime(filePath)) && tailleCorrect) {
    return true;
  }
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text('Invalid file format or size (20MB) : ${mime(filePath)}'),
    ));
  return false;
}

/// Donne le lien du fichier dans Firebase
String storagePath(String uid, String filePath, bool isVideo) {
  final timestamp = DateTime.now().microsecondsSinceEpoch;
  // Workaround fixed by https://github.com/flutter/plugins/pull/3685
  // (not yet in stable).
  final ext = isVideo ? 'mp4' : filePath.split('.').last;
  return 'users/$uid/uploads/$timestamp.$ext';
}

/// Montre un snackbarpour indiquer que ça téléverse un fichier
void showUploadMessage(BuildContext context, String message,
    {bool showLoading = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (showLoading)
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: CircularProgressIndicator(),
              ),
            Text(message),
          ],
        ),
      ),
    );
}
