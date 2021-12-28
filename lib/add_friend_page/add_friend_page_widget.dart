/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scarla/auth/auth_util.dart';
import 'package:scarla/flutter_flow/flutter_flow_util.dart';

import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../profile_page/profile_page_widget.dart';

/// Widget pour la page d'ajout des amitiés
class AddFriendPageWidget extends StatefulWidget {
  AddFriendPageWidget({Key key}) : super(key: key);

  @override
  _AddFriendPageWidgetState createState() => _AddFriendPageWidgetState();
}

class _AddFriendPageWidgetState extends State<AddFriendPageWidget> {
  TextEditingController searchTextFieldController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    searchTextFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.primaryColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.primaryColor,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.appBarColor,
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment(-1, 0),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(11, 0, 0, 0),
                            child: InkWell(
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xFF535480),
                                size: 27,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Add a Friend',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.title1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(11, 13, 16, 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 40, 0),
                        child: TextFormField(
                          controller: searchTextFieldController,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Find friends...',
                            hintStyle: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Poppins',
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 100,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 100,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          ),
                          style: FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child:
                /// Cherche les utilisateurs par rapport à [searchTextFieldController.text]
                StreamBuilder<List<UsersRecord>>(
                  stream: queryUsersRecord(
                    queryBuilder: (usersRecord) => usersRecord.where('keys',
                        arrayContainsAny: [
                          searchTextFieldController.text.toLowerCase()
                        ]).where('uid', isNotEqualTo: currentUserUid),
                    limit: 10,
                  ),
                  builder: (context, snapshot) {

                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    List<UsersRecord> listViewUsersRecordList = snapshot.data;
                    if (listViewUsersRecordList.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Text(
                            "Look for a friend . . .",
                            style: FlutterFlowTheme.title1,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: listViewUsersRecordList.length,
                      itemBuilder: (context, listViewIndex) {
                        final listViewUsersRecord =
                            listViewUsersRecordList[listViewIndex];
                        return Padding(
                          padding: EdgeInsets.fromLTRB(6, 6, 6, 10),
                          child: InkWell(
                            onTap: () async {
                              /// Dirige vers la page de profile de l'utilisateur sur la carte
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePageWidget(
                                    userRef: listViewUsersRecord.reference,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: FlutterFlowTheme.title1Color,
                              elevation: 5,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment(0, 0),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 80,
                                                height: 80,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: listViewUsersRecord
                                                      .photoUrl,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    5, 0, 0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      listViewUsersRecord.name,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: FlutterFlowTheme
                                                          .subtitle2
                                                          .override(
                                                        fontFamily: 'Poppins',
                                                      ),
                                                    ),
                                                    Text(
                                                      '#',
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 16),
                                                    ),
                                                    Text(
                                                      listViewUsersRecord.tag,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 16),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              /// Fait une demande d'amitié à l'utilisateur si ce n'est pas déjà le cas
                                              final isFriendRecord =
                                                  await queryFriendsRecord(
                                                      queryBuilder:
                                                          (friendsRecord) =>
                                                              friendsRecord
                                                                  .where(
                                                                      'friends',
                                                                      whereIn: [
                                                                    [
                                                                      listViewUsersRecord
                                                                          .reference,
                                                                      currentUserReference
                                                                    ],
                                                                    [
                                                                      currentUserReference,
                                                                      listViewUsersRecord
                                                                          .reference
                                                                    ]
                                                                  ])).first;

                                              if (isFriendRecord.isEmpty) {
                                                final friendshipData = {
                                                  ...createFriendsRecordData(
                                                      status: 0,
                                                      timestamp:
                                                          getCurrentTimestamp),
                                                  'friends': [
                                                    currentUserReference,
                                                    listViewUsersRecord
                                                        .reference
                                                  ]
                                                };

                                                await FriendsRecord.collection
                                                    .doc()
                                                    .set(friendshipData);
                                              } else {
                                                scaffoldKey.currentState
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "You already have a friendship with this user, go to Friends page!")));
                                              }
                                            },
                                            icon: Icon(
                                              Icons.add_circle_outline,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            iconSize: 30,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
