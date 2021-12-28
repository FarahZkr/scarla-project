/*
 * Copyright (c) 2021. Scarla
 */

import 'package:flutter/material.dart';
import 'package:scarla/group_list_page/widgets/group_card_widget.dart';
import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../create_group_page/create_group_page_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';

/// Widget qui montre tous les groupes
class GroupListPageWidget extends StatefulWidget {
  GroupListPageWidget({Key key}) : super(key: key);

  @override
  _GroupListPageWidgetState createState() => _GroupListPageWidgetState();
}

class _GroupListPageWidgetState extends State<GroupListPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.primaryColor,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: FlutterFlowTheme.secondaryColor,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: InkWell(
                      onTap: () async {
                        /// Envoie vers la page de création d'un groupe
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateGroupPageWidget(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 2, 6, 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 2, 0),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            Text(
                              'New Group',
                              style: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Poppins',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child:
                  /// Fait la requête des groupes dans lesquels se trouve l'utilisateur connecté
                  StreamBuilder<List<GroupsRecord>>(
                    stream: queryGroupsRecord(
                      queryBuilder: (groupsRecord) => groupsRecord
                          .where('members_id', arrayContains: currentUserUid)
                          .orderBy('last_message_timestamp', descending: true),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      List<GroupsRecord> listViewGroupsRecordList =
                          snapshot.data;
                      // Customize what your widget looks like with no query results.
                      if (listViewGroupsRecordList.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 120),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "You can find a new Squad by clicking on the button below",
                                  style: FlutterFlowTheme.title1,
                                  textAlign: TextAlign.center,
                                ),
                                Icon(
                                  Icons.arrow_circle_down_rounded,
                                  size: 50,
                                  color: FlutterFlowTheme.title1Color,
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewGroupsRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewGroupsRecord =
                                listViewGroupsRecordList[listViewIndex];
                            final isLastGroup = (listViewIndex ==
                                listViewGroupsRecordList.length - 1);
                            return GroupWidget(
                                isLastGroup: isLastGroup,
                                group: listViewGroupsRecord);
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
