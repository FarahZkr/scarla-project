/*
 * Copyright (c) 2021. Scarla
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:scarla/friends_page/widgets/friend_card_widget.dart';

import '../add_friend_page/add_friend_page_widget.dart';
import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';

/// Widget de la page de liste d'amis
class FriendsPageWidget extends StatefulWidget {
  FriendsPageWidget({Key key}) : super(key: key);

  @override
  _FriendsPageWidgetState createState() => _FriendsPageWidgetState();
}

class _FriendsPageWidgetState extends State<FriendsPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Align(
                        alignment: Alignment(0, 0),
                        child: Text(
                          'Friends',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.title1.override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment(1, 0),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 11, 0),
                            child: InkWell(
                              onTap: () async {
                                /// Envoie vers la page de recherche d'amitié
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddFriendPageWidget(),
                                  ),
                                );
                              },
                              child: Icon(
                                //Icons.person_add,
                                FluentIcons.person_add_20_filled,

                                color: FlutterFlowTheme.title1Color,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<FriendsRecord>>(
                  stream: queryFriendsRecord(
                    queryBuilder: (friendsRecord) => friendsRecord
                        .where('friends', arrayContains: currentUserReference)
                        .orderBy('status'),
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    List<FriendsRecord> listViewFriendsRecordList =
                        snapshot.data;
                    // Customize what your widget looks like with no query results.
                    if (listViewFriendsRecordList.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                                child: Icon(
                                  Icons.arrow_circle_up_rounded,
                                  size: 35,
                                  color: FlutterFlowTheme.title1Color,
                                ),
                              ),
                              Text(
                                "Click here to add new friends",
                                style: FlutterFlowTheme.title1,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: listViewFriendsRecordList.length,
                      itemBuilder: (context, listViewIndex) {
                        final listViewFriendsRecord =
                            listViewFriendsRecordList[listViewIndex];
                        final refToTake = listViewFriendsRecord.friends.first ==
                                currentUserReference
                            ? listViewFriendsRecord.friends.last
                            : listViewFriendsRecord.friends.first;
                        final isRequested =
                            (listViewFriendsRecord.friends.first ==
                                currentUserReference);
                        final isLast = (listViewIndex ==
                            listViewFriendsRecordList.length - 1);
                        return FriendCardWidget(
                          refToTake: refToTake,
                          isRequested: isRequested,
                          friendsRecord: listViewFriendsRecord,
                          isLastFriend: isLast,
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
