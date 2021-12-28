/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scarla/backend/schema/g_messages_record.dart';
import 'package:scarla/chat_page/widgets/video_player_widget.dart';
import 'package:scarla/flutter_flow/flutter_flow_theme.dart';
import 'package:video_player/video_player.dart';

/// Widget pour un message de l'utilisateur courant
class ChatMessage extends StatelessWidget {
  final int index;
  final GMessagesRecord data;
  final int nbElements;

  const ChatMessage({Key key, this.index, this.data, this.nbElements})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: index == (nbElements - 1) ? 10 : 0,
        bottom: index == 0 ? 15 : 5,
        left: 10,
        right: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.secondaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: data.type != 0 ? 0 : 10,
              vertical: data.type != 0 ? 0 : 10,
            ),
            child: data.type == 0
                ? Text(
                    data.value,
                    style: FlutterFlowTheme.bodyText1,
                  )
                : data.type == 1
                    ? Material(
                        child: CachedNetworkImage(
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) {
                            return Container(
                              width: 400.0,
                              height: 200.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  LinearProgressIndicator(
                                    value: downloadProgress.progress,
                                  ),
                                ],
                              ),
                            );
                          },
                          imageUrl: data.value,
                          width: 400.0,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        clipBehavior: Clip.hardEdge,
                      )
                    : ScarlaVideoPlayer(
                        videoPlayerController:
                            VideoPlayerController.network(data.value),
                        looping: true,
                        color: FlutterFlowTheme.secondaryColor,
                      ),
          )
        ],
      ),
    );
  }
}
