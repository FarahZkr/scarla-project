/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../login_page/login_page_widget.dart';
import '../my_profile_page/widgets/games_list_profile_widget.dart';
import '../my_profile_page/widgets/group_circle_widget.dart';
import '../settings_page/settings_page_widget.dart';

/// Widget pour la page de profile de l'utilisateur
class MyProfilePageWidget extends StatefulWidget {
  MyProfilePageWidget({Key key}) : super(key: key);

  @override
  _MyProfilePageWidgetState createState() => _MyProfilePageWidgetState();
}

class _MyProfilePageWidgetState extends State<MyProfilePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Color color1 = Color(0xff0b323e);
  Color color2 = Color(0xff010b15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.primaryColor,
      body:

          /// Fait la requête de l'utilisateur connecté
          StreamBuilder<List<UsersRecord>>(
        stream: queryUsersRecord(
          queryBuilder: (usersRecord) =>
              usersRecord.where('uid', isEqualTo: currentUserUid),
          singleRecord: true,
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<UsersRecord> stackUsersRecordList = snapshot.data;
          if (snapshot.data.isEmpty) {
            stackUsersRecordList = createDummyUsersRecord(count: 1);
          }
          final stackUsersRecord = stackUsersRecordList.first;
          return Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.primaryColor,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      children: [
                        if (stackUsersRecord.bgProfile != "")
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
                                  imageUrl: stackUsersRecord.bgProfile,
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
                              padding: EdgeInsets.fromLTRB(0, 45, 1, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        /// Demande à l'utilisateur s'il veut se déconnecter
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
                                                'Are you sure you want \n to log out?',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              buttonPadding:
                                                  EdgeInsets.fromLTRB(
                                                      0, 30, 4, 0),
                                              actions: <Widget>[
                                                Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 13, 15),
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
                                                                  0, 0, 14, 10),
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
                                                                /// Annule la commande et ramène à la page précédente
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
                                                                  0, 0, 10, 10),
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
                                                                'Log Out',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                /// Déconnecte l'utilisateur et ramène vers la page [LoginPageWidget]
                                                                await signOut();
                                                                await Navigator
                                                                    .pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            LoginPageWidget(),
                                                                  ),
                                                                  (r) => false,
                                                                );
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
                                      child: Icon(
                                        Icons.login_outlined,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        /// Envoie vers la page des paramètres [SettingsPageWidget]
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SettingsPageWidget(
                                              photoUrl:
                                                  stackUsersRecord.photoUrl,
                                              user: stackUsersRecord.reference,
                                              name: stackUsersRecord.name,
                                              tag: stackUsersRecord.tag,
                                              bgProfile:
                                                  stackUsersRecord.bgProfile,
                                              about: stackUsersRecord.about,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.more_vert,
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
                                            imageUrl: stackUsersRecord.photoUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        stackUsersRecord.name,
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
                                        stackUsersRecord.tag,
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
                                      stackUsersRecord.about,
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
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    'My Games',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 6, 20, 5),
                                  child: GamesListProfileWidget(
                                    selectedGames:
                                        stackUsersRecord.selectedGames.asList(),
                                    userName: stackUsersRecord.name,
                                    userRef: stackUsersRecord.reference,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 8, 0, 0),
                                  child: Text(
                                    'My Squads',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 120),
                                  child:

                                      /// Fait la requête des groupes dans lesquels se trouve l'utilisateur connecté
                                      StreamBuilder<List<GroupsRecord>>(
                                    stream: queryGroupsRecord(
                                      queryBuilder: (groupsRecord) =>
                                          groupsRecord.where('members_id',
                                              arrayContains: currentUserUid),
                                    ),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                      List<GroupsRecord>
                                          gridViewGroupsRecordList =
                                          snapshot.data;
                                      if (gridViewGroupsRecordList.isEmpty) {
                                        return Center(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 25, 0, 0),
                                            child: Text(
                                              "No Squads yet..",
                                              style: FlutterFlowTheme.title1
                                                  .override(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 20),
                                            ),
                                          ),
                                        );
                                      }
                                      return Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 17, 0, 0),
                                        child: GridView.builder(
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 0,
                                            mainAxisSpacing: 0,
                                            childAspectRatio: 1,
                                          ),
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              gridViewGroupsRecordList.length,
                                          itemBuilder:
                                              (context, gridViewIndex) {
                                            final gridViewGroupsRecord =
                                                gridViewGroupsRecordList[
                                                    gridViewIndex];
                                            return GroupCircleWidget(
                                              group: gridViewGroupsRecord,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
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
          );
        },
      ),
    );
  }
}
