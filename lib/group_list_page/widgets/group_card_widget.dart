/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scarla/backend/backend.dart';
import 'package:scarla/chat_page/chat_page_widget.dart';
import 'package:scarla/flutter_flow/flutter_flow_theme.dart';
import 'package:scarla/groups_settings_page/groups_settings_page_widget.dart';

/// Widget pour chaque groupe
class GroupWidget extends StatelessWidget {
  const GroupWidget({Key key, this.isLastGroup, this.group}) : super(key: key);
  final bool isLastGroup;
  final GroupsRecord group;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, isLastGroup ? 110 : 0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: FlutterFlowTheme.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () async {
            /// Envoie vers le chat page du groupe
            await Navigator.push(
                context,
                PageTransition(
                  child: ChatPageWidget(
                      groupName: group.gName,
                      groupRef: group.reference,
                      groupPf: group.gPhotoUrl),
                  type: PageTransitionType.rightToLeftWithFade,
                  duration: Duration(milliseconds: 400),
                  reverseDuration: Duration(milliseconds: 400),
                ));
          },
          onLongPress: () async {
            /// Envoie vers la page des paramètres du groupe
            await Navigator.push(
                context,
                PageTransition(
                  child: GroupsSettingsPageWidget(
                    groupRef: group.reference,
                    groupName: group.gName,
                  ),
                  type: PageTransitionType.rightToLeftWithFade,
                  duration: Duration(milliseconds: 400),
                  reverseDuration: Duration(milliseconds: 400),
                ));
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Container(
                  width: 80,
                  height: 80,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: group.gPhotoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 250,
                      child: Text(
                        group.gName,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.title2.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Color(0x00EEEEEE),
                      ),
                      alignment: Alignment(-1, 0),
                      child: Text(
                        group.lastMessage,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.bodyText2.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
