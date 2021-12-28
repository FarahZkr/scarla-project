/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scarla/backend/backend.dart';
import 'package:scarla/chat_page/widgets/video_player_widget.dart';
import 'package:scarla/profile_page/profile_page_widget.dart';
import 'package:video_player/video_player.dart';

/// Widget pour un message d'un autre utilisateur
class ChatMessageOther extends StatelessWidget {
  final int index;
  final GMessagesRecord data;
  final bool showAvatar;

  const ChatMessageOther(
      {Key key, this.index, this.data, this.showAvatar = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
        bottom: index == 0 ? 15 : 0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!showAvatar)
                SizedBox(
                  width: 30,
                )
              else
                StreamBuilder<UsersRecord>(
                    stream: UsersRecord.getDocument(data.authorRef),
                    builder: (context, snapshot) {
                      final columnUsersRecord = snapshot.data;
                      if (snapshot.hasData) {
                        return InkWell(
                          onTap: () async {
                            /// Envoie vers la page de profil de l'utilisateur
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePageWidget(
                                  userRef: columnUsersRecord.reference,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    columnUsersRecord.photoUrl),
                                radius: 15,
                              ),
                              if (showAvatar)
                                Text(
                                  columnUsersRecord.name,
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 300),
            padding: EdgeInsets.symmetric(
              horizontal: data.type != 0 ? 0 : 10,
              vertical: data.type != 0 ? 0 : 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: data.type == 0 //0
                ? Text(data.value)
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
                        color: Colors.white,
                      ),
          ),
        ],
      ),
    );
  }
}
