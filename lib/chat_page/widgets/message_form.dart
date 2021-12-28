/*
 * Copyright (c) 2021. Scarla
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:scarla/flutter_flow/flutter_flow_theme.dart';
import 'package:scarla/flutter_flow/upload_media.dart';

/// Widget du formulaire de message à envoyer
class MessageForm extends StatefulWidget {
  final ValueChanged<Map> onSubmit;

  MessageForm({Key key, this.onSubmit}) : super(key: key);

  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  final _controller = TextEditingController();
  String _message;

  /// Envoie un message texte
  void _onPressed() {
    Map msgMap = Map();
    msgMap['value'] = _message;
    msgMap['type'] = 0;
    widget.onSubmit(msgMap);
    _message = '';
    _controller.clear();
    setState(() {});
  }

  /// Lance la galerie de photos du téléphone pour prendre une image ou une vidéo
  Future getImage({bool isVideo = false}) async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    if (isVideo) {
      pickedFile = await imagePicker.getVideo(
          source: ImageSource.gallery, maxDuration: Duration(seconds: 60));
    } else {
      pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    }
    Map msgMap = Map();
    if (pickedFile != null) {
      final isValid = await validateFileFormat(pickedFile.path, context);
      if (isValid) {
        msgMap['value'] = pickedFile.path;
        msgMap['type'] = isVideo ? 2 : 1;
        widget.onSubmit(msgMap);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlutterFlowTheme.title1Color,
      padding: const EdgeInsets.fromLTRB(3, 5, 5, 5),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            (FlutterFlowTheme.isUploading)
                ? Material(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Color(0xFF25263E),
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        splashRadius: 24,
                        highlightColor: Colors.white.withOpacity(0.2),
                        splashColor: Colors.white.withOpacity(0.2),
                        icon: Icon(Icons.file_upload),
                        onPressed: () {},
                        color: Colors.white,

                      ),
                    ),
                    color: Colors.transparent,
                  )
                : Material(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Color(0xFF25263E),
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        splashRadius: 24,
                        highlightColor: Colors.white.withOpacity(0.2),
                        splashColor: Colors.white.withOpacity(0.2),
                        icon: Icon(Icons.image),
                        onPressed: getImage,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.transparent,
                  ),
            SizedBox(
              width: 4,
            ),
            Material(
              child: Ink(
                decoration: const ShapeDecoration(
                  color: Color(0xFF25263E),
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  splashRadius: 24,
                  highlightColor: Colors.white.withOpacity(0.2),
                  splashColor: Colors.white.withOpacity(0.2),
                  icon: Icon(Icons.video_collection),
                  onPressed: () {
                    /// Demande une vidéo
                    getImage(isVideo: true);
                  },
                  color: Colors.white,
                ),
              ),
              color: Colors.transparent,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
                flex: 4,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Send a Message . . .',
                    hintStyle: FlutterFlowTheme.bodyText2.override(
                      fontFamily: 'Poppins',
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.primaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                  style: FlutterFlowTheme.bodyText2.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                  minLines: 1,
                  maxLines: 4,
                  onChanged: (value) {
                    /// Change la valeur de [_message] à chaque modification pour vérification
                    setState(() {
                      _message = value;
                    });
                  },
                )),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 1,
              child: RawMaterialButton(
                onPressed: _message == null || _message.trim().isEmpty
                    ? null
                    : _onPressed,
                fillColor: _message == null || _message.trim().isEmpty
                    ? Color(0xFF8E87C1)
                    : FlutterFlowTheme.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      FluentIcons.send_20_filled,
                      color: Colors.white,
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
