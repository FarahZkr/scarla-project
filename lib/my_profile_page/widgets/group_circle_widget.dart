/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scarla/backend/schema/groups_record.dart';
import 'package:scarla/chat_page/chat_page_widget.dart';
import 'package:scarla/flutter_flow/flutter_flow_theme.dart';

/// Widget du cercle de groupe
class GroupCircleWidget extends StatelessWidget {
  const GroupCircleWidget({Key key, this.group}) : super(key: key);
  final GroupsRecord group;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        /// Envoie vers la page [ChatPageWidget]
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPageWidget(
                groupName: group.gName,
                groupRef: group.reference,
                groupPf: group.gPhotoUrl),
          ),
        );
      },
      child: Container(
        width: 100,
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                width: 100,
                height: 100,
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
            Text(
              group.gName,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.bodyText2.override(
                fontFamily: 'Poppins',
              ),
            )
          ],
        ),
      ),
    );
  }
}
