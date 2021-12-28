/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:scarla/chat_page/chat_page_widget.dart';
import 'package:scarla/flutter_flow/flutter_flow_util.dart';
import 'package:scarla/home_page/widgets/post_widget.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../my_profile_page/widgets/games_list_profile_widget.dart';


/// Widget pour la page de profile des autres utilisateurs
class ProfilePageWidget extends StatefulWidget {
  ProfilePageWidget({Key key, this.userRef}) : super(key: key);

  final DocumentReference userRef;

  @override
  _ProfilePageWidgetState createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String nom = 'Add as friend';
  bool isRequested;

  @override
  void initState() {
    super.initState();
    if (widget.userRef == currentUserReference) {
      setState(() {
        nom = "None";
      });
    } else {
      queryFriendsRecord(
          queryBuilder: (friendsRecord) =>
              friendsRecord.where('friends', whereIn: [
                [widget.userRef, currentUserReference],
                [currentUserReference, widget.userRef]
              ])).first.then((value) {
        if (value.isEmpty) {
          nom = "Add as friend";
        } else {
          int status = value.first.status;
          if (status == 0) {
            isRequested = (value.first.friends.first == currentUserReference);
            if (isRequested) {
              nom = "Request Sent";
            } else {
              nom = "Accept request";
            }
          } else {
            nom = "Friends";
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Fait la requête de l'utilisateur sélectionné
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(widget.userRef),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final profilePageUsersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.primaryColor,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 1,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.primaryColor,
                          ),
                        ),
                        if (profilePageUsersRecord.bgProfile != "")
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                decoration: BoxDecoration(
                                  color: Color(0xFFB7B7B7),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: profilePageUsersRecord.bgProfile,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 1,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                decoration: BoxDecoration(
                                  color: Color(0x81000000),
                                ),
                              )
                            ],
                          ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        /// Retourne à la page précédente
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  if (nom == 'Friends')
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 19, 0),
                                      child: InkWell(
                                        onTap: () async {
                                          ///  Envoie vers une page de message avec l'utilisateur, à partir de son profile page
                                          final isGroupRecord =
                                              await queryGroupsRecord(
                                                  queryBuilder:
                                                      (groupsRecord) =>
                                                          groupsRecord.where(
                                                              'members_id',
                                                              whereIn: [
                                                                [
                                                                  profilePageUsersRecord
                                                                      .uid,
                                                                  currentUserUid
                                                                ],
                                                                [
                                                                  currentUserUid,
                                                                  profilePageUsersRecord
                                                                      .uid
                                                                ]
                                                              ])).first;

                                          GroupsRecord group;
                                          String myName =
                                              (await UsersRecord.getDocument(
                                                          currentUserReference)
                                                      .first)
                                                  .name;

                                          if (isGroupRecord.isEmpty) {
                                            final gName =
                                                "${profilePageUsersRecord.name} and $myName";
                                            final gPhotoUrl =
                                                profilePageUsersRecord.photoUrl;
                                            final lastMessage = '...';

                                            final groupsRecordData = {
                                              ...createGroupsRecordData(
                                                gName: gName,
                                                gPhotoUrl: gPhotoUrl,
                                                lastMessage: lastMessage,
                                                lastMessageTimestamp:
                                                    getCurrentTimestamp,
                                                host: currentUserReference,
                                            ),
                                              'members_id': [
                                                profilePageUsersRecord.uid,
                                                currentUserUid
                                              ],
                                            };

                                            await GroupsRecord.collection
                                                .doc()
                                                .set(groupsRecordData);

                                            group = (await queryGroupsRecord(
                                                    queryBuilder:
                                                        (groupsRecord) =>
                                                            groupsRecord.where(
                                                                'members_id',
                                                                whereIn: [
                                                                  [
                                                                    profilePageUsersRecord
                                                                        .uid,
                                                                    currentUserUid
                                                                  ],
                                                                  [
                                                                    currentUserUid,
                                                                    profilePageUsersRecord
                                                                        .uid
                                                                  ]
                                                                ])).first)
                                                .first;
                                          } else {
                                            group = isGroupRecord.first;
                                          }
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ChatPageWidget(
                                                      groupName: group.gName,
                                                      groupRef: group.reference,
                                                      groupPf: group.gPhotoUrl),
                                            ),
                                          );
                                        },
                                        child: Icon(
                                          AntDesign.message1,
                                          color: Colors.white,
                                          size: 26,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment(0, -45.5),
                                      child: Container(
                                        width: 104,
                                        height: 104,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0, -1.3),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 2, 0, 0),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                profilePageUsersRecord.photoUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        profilePageUsersRecord.name,
                                        textAlign: TextAlign.center,
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(2, 0, 1, 0),
                                        child: Text(
                                          '#',
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                      Text(
                                        profilePageUsersRecord.tag,
                                        style:
                                            FlutterFlowTheme.bodyText2.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 300,
                                    maxHeight: 100,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0x00EEEEEE),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(45, 5, 45, 5),
                                    child: Text(
                                      profilePageUsersRecord.about,
                                      textAlign: TextAlign.center,
                                      style:
                                          FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  indent: 20,
                                  endIndent: 20,
                                  color: Color(0x39F5F5F5),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (nom != 'None')
                                  FFButtonWidget(
                                    onPressed: () async {
                                      /// Actions pour ajouter l'ami ou l'enlever de ta liste d'amis
                                      if (nom == 'Add as friend') {
                                        final friendshipData = {
                                          ...createFriendsRecordData(
                                              status: 0,
                                              timestamp: getCurrentTimestamp),
                                          'friends': [
                                            currentUserReference,
                                            profilePageUsersRecord.reference
                                          ]
                                        };

                                        await FriendsRecord.collection
                                            .doc()
                                            .set(friendshipData);
                                        setState(() {
                                          nom = 'Request Sent';
                                        });
                                      } else if (nom == 'Request Sent') {
                                        queryFriendsRecord(
                                            queryBuilder: (friendsRecord) =>
                                                friendsRecord
                                                    .where('friends', whereIn: [
                                                  [
                                                    widget.userRef,
                                                    currentUserReference
                                                  ],
                                                  [
                                                    currentUserReference,
                                                    widget.userRef
                                                  ]
                                                ])).first.then((value) async {
                                          if (value.isEmpty) {
                                            setState(() {
                                              nom = 'Add as friend';
                                            });
                                          } else {
                                            await value.first.reference
                                                .delete();
                                            setState(() {
                                              nom = 'Add as friend';
                                            });
                                          }
                                        });
                                      } else if (nom == 'Accept request') {
                                        queryFriendsRecord(
                                            queryBuilder: (friendsRecord) =>
                                                friendsRecord
                                                    .where('friends', whereIn: [
                                                  [
                                                    widget.userRef,
                                                    currentUserReference
                                                  ],
                                                  [
                                                    currentUserReference,
                                                    widget.userRef
                                                  ]
                                                ])).first.then((value) async {
                                          if (value.isEmpty) {
                                            setState(() {
                                              nom = 'Add as friend';
                                            });
                                          } else {
                                            final friendshipData = {
                                              ...createFriendsRecordData(
                                                status: 1,
                                              )
                                            };

                                            await value.first.reference
                                                .update(friendshipData);

                                            setState(() {
                                              nom = "Friends";
                                            });
                                          }
                                        });
                                      } else if (nom == 'Friends') {
                                        /// Montre dialogue qui demande si l'utilisateur est sûre d'enlever ce ami
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              title:
                                                  Center(child: Text('Alert!')),
                                              content: Text(
                                                  'Are you sure you want to remove this friend?'),
                                              actions: <Widget>[
                                                Column(
                                                  children: [
                                                    Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 21, 15),
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
                                                                  0, 0, 12, 0),
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
                                                                /// Annule la commande et envoie à la page précédente
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
                                                                  0, 0, 18, 0),
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
                                                                'Yes!',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                /// Enleve l'autre utilisateur de la liste d'amis et retourne à la page précédente
                                                                queryFriendsRecord(
                                                                    queryBuilder: (friendsRecord) =>
                                                                        friendsRecord.where(
                                                                            'friends',
                                                                            whereIn: [
                                                                              [
                                                                                widget.userRef,
                                                                                currentUserReference
                                                                              ],
                                                                              [
                                                                                currentUserReference,
                                                                                widget.userRef
                                                                              ]
                                                                            ])).first.then(
                                                                    (value) async {
                                                                  await value
                                                                      .first
                                                                      .reference
                                                                      .delete();
                                                                });
                                                                setState(() {
                                                                  nom =
                                                                      'Add as friend';
                                                                });
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
                                      }
                                    },
                                    text: nom,
                                    options: FFButtonOptions(
                                      width: 130,
                                      height: 40,
                                      color: FlutterFlowTheme.secondaryColor,
                                      textStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Poppins',
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 12,
                                    ),
                                  ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(3, 12, 0, 3),
                                      child: Text(
                                        'Games',
                                        textAlign: TextAlign.center,
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 2, 20, 2),
                                          child: GamesListProfileWidget(
                                            selectedGames: profilePageUsersRecord.selectedGames.asList(),
                                            userName: profilePageUsersRecord.name,
                                            userRef: widget.userRef,
                                          ),
                                        )
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(3, 11, 0, 4),
                                      child: Text(
                                        'Posts',
                                        textAlign: TextAlign.center,
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                    /// Fait la requête des fils d'actualité postés par l'utilisateur sélectionné
                                    StreamBuilder<List<FeedRecord>>(
                                      stream: queryFeedRecord(
                                        queryBuilder: (feedRecord) => feedRecord
                                            .where('author_id',
                                                isEqualTo:
                                                    profilePageUsersRecord.uid)
                                            .orderBy('timestamp',
                                                descending: true),
                                      ),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        List<FeedRecord>
                                            listViewFeedRecordList =
                                            snapshot.data;
                                        if (listViewFeedRecordList.isEmpty) {
                                          return Center(
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://i.pinimg.com/originals/65/ba/48/65ba488626025cff82f091336fbf94bb.gif',
                                              width: 200,
                                              height: 200,
                                            ),
                                          );
                                        }
                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              listViewFeedRecordList.length,
                                          itemBuilder:
                                              (context, listViewIndex) {
                                            final listViewFeedRecord =
                                                listViewFeedRecordList[
                                                    listViewIndex];
                                            final isLastPost = (listViewIndex ==
                                                listViewFeedRecordList.length -
                                                    1);
                                            return PostWidget(
                                              isLastPost: isLastPost,
                                              postRecord: listViewFeedRecord,
                                            );
                                          },
                                        );
                                      },
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
