/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scarla/auth/auth_util.dart';
import 'package:scarla/backend/backend.dart';

import '../flutter_flow/flutter_flow_theme.dart';

/// Widget dudialogue pour ajouter ou enlever un jeu de son compte
class AddRemoveGamePageWidget extends StatefulWidget {
  AddRemoveGamePageWidget({Key key}) : super(key: key);

  @override
  _AddRemoveGamePageWidgetState createState() =>
      _AddRemoveGamePageWidgetState();
}

class _AddRemoveGamePageWidgetState extends State<AddRemoveGamePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0x7A000000),
      body:
      /// Prend le document de l'utilisateur
      StreamBuilder<UsersRecord>(
          stream: UsersRecord.getDocument(currentUserReference),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            final selectedGames = snapshot.data.selectedGames;

            return SingleChildScrollView(
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
                              padding: EdgeInsets.fromLTRB(14, 2, 10, 2),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Add or remove games',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GridView(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1,
                              ),
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        /// Ajoute ou supprime valorant dans la base de données
                                        final usersRecordData = {
                                          'selected_games': (selectedGames
                                                  .contains("valorant"))
                                              ? FieldValue.arrayRemove(
                                                  ['valorant'])
                                              : FieldValue.arrayUnion(
                                                  ['valorant']),
                                        };

                                        await currentUserReference
                                            .update(usersRecordData);
                                      },
                                      child: Container(
                                        width: 65,
                                        height: 65,
                                        child: Stack(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/games/icons/valorantIcon.png',
                                                        scale:110
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            (selectedGames.contains("valorant"))
                                                ? Align(
                                                    alignment: Alignment(1, -1),
                                                    child: Icon(
                                                      Icons.remove_circle,
                                                      color: Color(0xFFFF0000),
                                                      size: 24,
                                                    ),
                                                  )
                                                : Align(
                                                    alignment: Alignment(1, -1),
                                                    child: Icon(
                                                      Icons.add_circle,
                                                      color: Color(0xFF27FF00),
                                                      size: 24,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        /// Ajoute ou supprime mw dans la base de données
                                        final usersRecordData = {
                                          'selected_games': (selectedGames
                                                  .contains("mw"))
                                              ? FieldValue.arrayRemove(['mw'])
                                              : FieldValue.arrayUnion(['mw']),
                                        };

                                        await currentUserReference
                                            .update(usersRecordData);
                                      },
                                      child: Container(
                                        width: 65,
                                        height: 65,
                                        child: Stack(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/games/icons/mwIcon.png',
                                                        scale: 1,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            (selectedGames.contains("mw"))
                                                ? Align(
                                                    alignment: Alignment(1, -1),
                                                    child: Icon(
                                                      Icons.remove_circle,
                                                      color: Color(0xFFFF0000),
                                                      size: 24,
                                                    ),
                                                  )
                                                : Align(
                                                    alignment: Alignment(1, -1),
                                                    child: Icon(
                                                      Icons.add_circle,
                                                      color: Color(0xFF27FF00),
                                                      size: 24,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        /// Ajoute ou supprime rl dans la base de données
                                        final usersRecordData = {
                                          'selected_games': (selectedGames
                                                  .contains("rl"))
                                              ? FieldValue.arrayRemove(['rl'])
                                              : FieldValue.arrayUnion(['rl']),
                                        };

                                        await currentUserReference
                                            .update(usersRecordData);
                                      },
                                      child: Container(
                                        width: 65,
                                        height: 65,
                                        child: Stack(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/games/icons/rlIcon.png',
                                                        scale: 25,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            (selectedGames.contains("rl"))
                                                ? Align(
                                                    alignment: Alignment(1, -1),
                                                    child: Icon(
                                                      Icons.remove_circle,
                                                      color: Color(0xFFFF0000),
                                                      size: 24,
                                                    ),
                                                  )
                                                : Align(
                                                    alignment: Alignment(1, -1),
                                                    child: Icon(
                                                      Icons.add_circle,
                                                      color: Color(0xFF27FF00),
                                                      size: 24,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        /// Ajoute ou supprime ow dans la base de données
                                        final usersRecordData = {
                                          'selected_games': (selectedGames
                                                  .contains("ow"))
                                              ? FieldValue.arrayRemove(['ow'])
                                              : FieldValue.arrayUnion(['ow']),
                                        };

                                        await currentUserReference
                                            .update(usersRecordData);
                                      },
                                      child: Container(
                                        width: 65,
                                        height: 65,
                                        child: Stack(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/games/icons/owIcon.png',
                                                        scale: 29,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            (selectedGames.contains("ow"))
                                                ? Align(
                                                    alignment: Alignment(1, -1),
                                                    child: Icon(
                                                      Icons.remove_circle,
                                                      color: Color(0xFFFF0000),
                                                      size: 24,
                                                    ),
                                                  )
                                                : Align(
                                                    alignment: Alignment(1, -1),
                                                    child: Icon(
                                                      Icons.add_circle,
                                                      color: Color(0xFF27FF00),
                                                      size: 24,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        /// Ajoute ou supprime lol dans la base de données
                                        final usersRecordData = {
                                          'selected_games': (selectedGames
                                                  .contains("lol"))
                                              ? FieldValue.arrayRemove(['lol'])
                                              : FieldValue.arrayUnion(['lol']),
                                        };

                                        await currentUserReference
                                            .update(usersRecordData);
                                      },
                                      child: Container(
                                        width: 65,
                                        height: 65,
                                        child: Stack(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/games/icons/lolIcon.png',
                                                        fit: BoxFit.contain,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            (selectedGames.contains("lol"))
                                                ? Align(
                                                    alignment: Alignment(1, -1),
                                                    child: Icon(
                                                      Icons.remove_circle,
                                                      color: Color(0xFFFF0000),
                                                      size: 24,
                                                    ),
                                                  )
                                                : Align(
                                                    alignment: Alignment(1, -1),
                                                    child: Icon(
                                                      Icons.add_circle,
                                                      color: Color(0xFF27FF00),
                                                      size: 24,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
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
            );
          }),
    );
  }
}
