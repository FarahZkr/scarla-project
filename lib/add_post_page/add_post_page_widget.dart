/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgur/imgur.dart' as imgur;
import 'package:scarla/flutter_flow/upload_media.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';

/// Widget pour le dialogue d'ajout de fil d'actualité
class AddPostPageWidget extends StatefulWidget {
  AddPostPageWidget(
      {Key key, this.userRef, this.initValue, this.initImage, this.chosenGame})
      : super(key: key);

  final DocumentReference userRef;
  final String initValue;
  final String initImage;
  String chosenGame;

  @override
  _AddPostPageWidgetState createState() => _AddPostPageWidgetState();
}

class _AddPostPageWidgetState extends State<AddPostPageWidget> {
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final gamesList = ['valorant', 'lol', 'ow', 'rl', 'mw'];
  String postPic;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.initValue);
    if (widget.chosenGame == null) {
      widget.chosenGame = "valorant";
    }
  }

  /// Lance la galerie de photos du téléphone pour prendre une image ou une vidéo
  Future getImage({bool isVideo = false}) async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    if (isVideo) {
      pickedFile = await imagePicker.getVideo(source: ImageSource.gallery);
    } else {
      pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      final isValid = await validateFileFormat(pickedFile.path, context);
      if (isValid) {
        setState(() {
          FlutterFlowTheme.isUploading = true;
        });
        final client =
            imgur.Imgur(imgur.Authentication.fromClientId('2a04555f27563dc'));
        await client.image
            .uploadImage(
                imagePath: pickedFile.path, title: '*_*', description: '*_*')
            .then((image) {
          postPic = image.link;
          setState(() {
            FlutterFlowTheme.isUploading = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Prend le document de l'utilisateur
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(widget.userRef),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final addPostPageUsersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0x7A000000),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment(0, 0),
                  children: [
                    InkWell(
                      onTap: () async {
                        /// Ferme le dialogue courant
                        Navigator.pop(context);
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 1,
                        decoration: BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: FlutterFlowTheme.tertiaryColor,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0x00EEEEEE),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 2, 0, 2),
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                addPostPageUsersRecord.photoUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        child: Text(
                                          addPostPageUsersRecord.name,
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                DropdownButton(
                                  hint: Text("Select a game"),
                                  dropdownColor: FlutterFlowTheme.tertiaryColor,
                                  iconSize: 36,
                                  value: widget.chosenGame,
                                  style: FlutterFlowTheme.bodyText1
                                      .override(fontFamily: 'Poppins'),
                                  onChanged: (newVal) {
                                    /// Dropdown du choix du type de fil d'actualité
                                    setState(() {
                                      widget.chosenGame = newVal;
                                    });
                                  },
                                  items: gamesList.map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Color(0x00EEEEEE),
                            ),
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(125)
                              ],
                              controller: textController,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Content..',
                                hintStyle: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Poppins',
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 9,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.tertiaryColor,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  (postPic == null &&
                                          widget.initImage.trim() == "")
                                      ? Container()
                                      : CachedNetworkImage(
                                          imageUrl: (postPic != null)
                                              ? postPic
                                              : widget.initImage,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              1,
                                          fit: BoxFit.cover,
                                        ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: IconButton(
                                          onPressed: () async {
                                            /// Demande une image
                                            getImage();
                                          },
                                          icon: Icon(
                                            Icons.image,
                                            color:
                                                FlutterFlowTheme.secondaryColor,
                                            size: 30,
                                          ),
                                          iconSize: 30,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: IconButton(
                                          onPressed: () async {
                                            /// Supprime l'image du fil d'actualité choisie
                                            setState(() {
                                              postPic = null;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.clear,
                                            color:
                                                FlutterFlowTheme.secondaryColor,
                                            size: 30,
                                          ),
                                          iconSize: 30,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  /// Ferme le dialogue courant
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  color: Color(0xFF444771),
                                  size: 20,
                                ),
                                iconSize: 20,
                              ),
                              IconButton(
                                onPressed: () async {
                                  /// Vérifie les entrées du fil d'actualité puis les envoie à la base de données
                                  if (textController.text.isEmpty)
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          title: Center(child: Text('Error')),
                                          content: Text(
                                            'You have not entered anything yet!',
                                            textAlign: TextAlign.center,
                                          ),
                                          actions: <Widget>[
                                            Column(
                                              children: [
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 15, 15),
                                                    child: Container(
                                                      width: 250,
                                                      height: 1,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24),
                                                        color: Colors.grey[300],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 0, 15, 0),
                                                      child: Container(
                                                        width: 107,
                                                        height: 47,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
                                                          color:
                                                              Color(0xffff4553),
                                                        ),
                                                        child: TextButton(
                                                          child: Text(
                                                            'Ok!',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  else {
                                    final authorId = currentUserUid;
                                    final authorName =
                                        addPostPageUsersRecord.name;
                                    final content = textController.text;
                                    final game = widget.chosenGame;
                                    final type = 0;
                                    final authorPhotoUrl =
                                        addPostPageUsersRecord.photoUrl;
                                    final id = '';
                                    final timestamp = getCurrentTimestamp;
                                    final authorRef = widget.userRef;
                                    final imageUrl = (postPic != null)
                                        ? postPic
                                        : widget.initImage;

                                    final feedRecordData = createFeedRecordData(
                                      authorId: authorId,
                                      authorName: authorName,
                                      content: content,
                                      game: game,
                                      type: type,
                                      authorPhotoUrl: authorPhotoUrl,
                                      id: id,
                                      timestamp: timestamp,
                                      authorRef: authorRef,
                                      imageUrl: imageUrl,
                                    );

                                    await FeedRecord.collection
                                        .doc()
                                        .set(feedRecordData);
                                    Navigator.pop(context);
                                  }
                                },
                                icon: Icon(
                                  Icons.send_outlined,
                                  color: Color(0xFF444771),
                                  size: 20,
                                ),
                                iconSize: 20,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
