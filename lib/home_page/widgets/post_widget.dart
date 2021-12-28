/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:scarla/add_post_page/add_post_page_widget.dart';
import 'package:scarla/auth/auth_util.dart';
import 'package:scarla/backend/backend.dart';
import 'package:scarla/flutter_flow/flutter_flow_theme.dart';
import 'package:scarla/profile_page/profile_page_widget.dart';
import 'package:scarla/util/transparent_route.dart';

/// Widget pour faire une publication
class PostWidget extends StatelessWidget {
  const PostWidget({Key key, this.isLastPost, this.postRecord})
      : super(key: key);
  final bool isLastPost;
  final FeedRecord postRecord;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, (isLastPost) ? 110 : 0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: FlutterFlowTheme.tertiaryColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 2, 3, 2),
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
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () async {
                            /// Envoie vers la page de profile de l'utilisateur
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePageWidget(
                                  userRef: postRecord.authorRef,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: postRecord.authorPhotoUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () async {
                              /// Envoie vers la page de profile de l'utilisateur
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePageWidget(
                                    userRef: postRecord.authorRef,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                              child: Text(
                                postRecord.authorName,
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 0),
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 25),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.horizontal_rule_rounded,
                                      size: 45,
                                      color: Colors.grey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 15, 0),
                                      child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15),
                                            ),
                                            color:
                                                FlutterFlowTheme.title1Color),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 15, 10, 15),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme
                                                      .tertiaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    if (postRecord.authorId ==
                                                        currentUserUid)
                                                      InkWell(
                                                        onTap: () async {
                                                          /// Ça enlève le post si c'est celui de l'utilisateur
                                                         Navigator.of(context).pop();
                                                          showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return AlertDialog(
                                                                backgroundColor: Colors.white,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius.circular(10.0),
                                                                ),

                                                                content: Text(
                                                                  'Are you sure you want to delete this post?',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600),),
                                                                actions: <Widget>[
                                                                  Column(
                                                                    children: [
                                                                      Center(
                                                                        child: Padding(
                                                                          padding:
                                                                          const EdgeInsets
                                                                              .fromLTRB(
                                                                              0, 0, 24, 15),
                                                                          child: Container(
                                                                            width: 250,
                                                                            height: 2,
                                                                            decoration:
                                                                            BoxDecoration(
                                                                              borderRadius:
                                                                              BorderRadius
                                                                                  .circular(
                                                                                  24),
                                                                              color: Colors
                                                                                  .grey[300],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                            const EdgeInsets
                                                                                .fromLTRB(
                                                                                0, 0, 14, 0),
                                                                            child: Container(
                                                                              width: 107,
                                                                              height: 47,
                                                                              decoration:
                                                                              BoxDecoration(
                                                                                borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                    24),
                                                                                color:
                                                                                Colors.grey,
                                                                              ),
                                                                              child: TextButton(
                                                                                child: Text(
                                                                                  'Cancel',
                                                                                  style: TextStyle(
                                                                                      color: Colors
                                                                                          .white),
                                                                                ),
                                                                                onPressed: () {
                                                                                  /// Ça annule la commande
                                                                                  Navigator.of(
                                                                                      context)
                                                                                      .pop();
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                            const EdgeInsets
                                                                                .fromLTRB(
                                                                                0, 0, 20, 0),
                                                                            child: Container(
                                                                              width: 107,
                                                                              height: 47,
                                                                              decoration:
                                                                              BoxDecoration(
                                                                                borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                    24),
                                                                                color: Color(
                                                                                    0xffff4553),
                                                                              ),
                                                                              child: TextButton(
                                                                                child: Text(
                                                                                  'Yes',
                                                                                  style: TextStyle(
                                                                                      color: Colors
                                                                                          .white),
                                                                                ),
                                                                                onPressed:
                                                                                    () async {
                                                                                  /// Ça enleve la publication fait par l'utilisateur
                                                                                      Navigator.pop(
                                                                                          context);
                                                                                      await postRecord
                                                                                          .reference
                                                                                          .delete();
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
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          child: Center(
                                                            child: Text(
                                                              "Delete",
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                color:
                                                                    Colors.red,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    Divider(
                                                      height: 0,
                                                      indent: 0,
                                                      endIndent: 0,
                                                      color: Color(0x23F5F5F5),
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        /// Envoie vers la page de [AddPostPageWidget] pour repost
                                                        Navigator.pop(context);
                                                        await Navigator.push(
                                                          context,
                                                          TransparentRoute(
                                                            builder: (context) =>
                                                                AddPostPageWidget(
                                                              userRef:
                                                                  currentUserReference,
                                                              initValue:
                                                                  postRecord
                                                                      .content,
                                                              initImage:
                                                                  postRecord
                                                                      .imageUrl,
                                                              chosenGame:
                                                                  postRecord
                                                                      .game,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        child: Center(
                                                          child: Text(
                                                            "Repost",
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText1
                                                                    .override(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(10, 5, 10, 25),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme
                                                      .tertiaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    /// Envoie à la page précédente
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    child: Center(
                                                      child: Text(
                                                        "Cancel",
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      icon: Icon(
                        Icons.keyboard_control,
                        color: Colors.white,
                        size: 15,
                      ),
                      iconSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 3),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 300,
                  maxHeight: 100,
                ),
                decoration: BoxDecoration(
                  color: Color(0x00EEEEEE),
                ),
                child: Text(
                  postRecord.content,
                  style: FlutterFlowTheme.bodyText2.override(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: (postRecord.imageUrl.trim() == "") ? 0 : 200,
              decoration: BoxDecoration(
                color: Color(0x00EEEEEE),
              ),
              child: (postRecord.imageUrl.trim() == "")
                  ? Container()
                  : CachedNetworkImage(
                      imageUrl: postRecord.imageUrl,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1,
                      fit: BoxFit.cover,
                    ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () async {
                    /// Envoie vers la page [AddPostPageWidget] pour repost
                    await Navigator.push(
                      context,
                      TransparentRoute(
                        builder: (context) => AddPostPageWidget(
                          userRef: currentUserReference,
                          initValue: postRecord.content,
                          initImage: postRecord.imageUrl,
                          chosenGame: postRecord.game,
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    MaterialCommunityIcons.twitter_retweet,
                    color: Color(0xFF444771),
                    size: 24,
                  ),
                  iconSize: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
