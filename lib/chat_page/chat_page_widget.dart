/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:imgur/imgur.dart' as imgur;
import 'package:page_transition/page_transition.dart';
import 'package:scarla/chat_page/widgets/chat_message_other.dart';
import 'package:scarla/chat_page/widgets/chat_message_self.dart';
import 'package:scarla/chat_page/widgets/message_form.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../groups_settings_page/groups_settings_page_widget.dart';

/// Widget de la page de chat de groupe
class ChatPageWidget extends StatefulWidget {
  ChatPageWidget(
      {Key key, this.groupName, this.groupRef, @required this.groupPf})
      : super(key: key);

  final String groupName;
  final DocumentReference groupRef;
  final String groupPf;

  @override
  _ChatPageWidgetState createState() => _ChatPageWidgetState();
}

class _ChatPageWidgetState extends State<ChatPageWidget> {
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final messageListController = ScrollController();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  /// Ajoute un message du type spécifié dans la base de données Firebase
  void _addMessage(Map msgMap) async {
    String value = msgMap['value'];
    int type = msgMap['type'];
    switch (type) {
      case 0:
        value = value;
        break;
      case 1:
      case 2:
        setState(() {
          FlutterFlowTheme.isUploading = true;
        });
        final client =
            imgur.Imgur(imgur.Authentication.fromClientId('2a04555f27563dc'));
        await client.image
            .uploadImage(imagePath: value, title: '*_*', description: '*_*')
            .then((image) {
          value = image.link;
          setState(() {
            FlutterFlowTheme.isUploading = false;
          });
        });
        break;
      default:
        print("Not configured yet");
    }
    final authorId = currentUserUid;
    final groupRef = widget.groupRef;
    final timestamp = getCurrentTimestamp;
    final authorRef = currentUserReference;

    final gMessagesRecordData = createGMessagesRecordData(
      authorId: authorId,
      groupRef: groupRef,
      timestamp: timestamp,
      type: type,
      value: value,
      authorRef: authorRef,
    );

    await GMessagesRecord.collection.doc().set(gMessagesRecordData);

    final groupsRecordData = createGroupsRecordData(
      lastMessage: value,
      lastMessageTimestamp: getCurrentTimestamp,
    );

    await widget.groupRef.update(groupsRecordData);

    messageListController.animateTo(
        messageListController.position.minScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.primaryColor,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.primaryColor,
            ),
          ),
          Stack(
            children: [
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                            child: InkWell(
                              onTap: () async {
                                /// Quitte la page de chat
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: FlutterFlowTheme.title1Color,
                                size: 24,
                              ),
                            ),
                          ),
                          Container(
                            width: 250,
                            child: Text(
                              widget.groupName,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.title1.override(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              /// Envoie vers la page des paramètres du groupe courant
                              await Navigator.push(
                                  context,
                                  PageTransition(
                                    child: GroupsSettingsPageWidget(
                                      groupRef: widget.groupRef,
                                      groupName: widget.groupName,
                                    ),
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    duration: Duration(milliseconds: 400),
                                    reverseDuration:
                                        Duration(milliseconds: 400),
                                  ));
                            },
                            icon: Icon(
                              Icons.more_vert,
                              color: FlutterFlowTheme.title1Color,
                              size: 33,
                            ),
                            iconSize: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child:
                    /// Fait une requête pour les messages du groupe courant
                    StreamBuilder<List<GMessagesRecord>>(
                      stream: queryGMessagesRecord(
                        queryBuilder: (gMessagesRecord) => gMessagesRecord
                            .where('group_ref', isEqualTo: widget.groupRef)
                            .orderBy('timestamp', descending: true),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        List<GMessagesRecord> listViewGMessagesRecordList =
                            snapshot.data;
                        bool shouldDisplayAvatar(int index) {
                          if (index == 0) return true;

                          final previousId =
                              listViewGMessagesRecordList[index - 1].authorId;
                          final authorId =
                              listViewGMessagesRecordList[index].authorId;
                          return authorId != previousId;
                        }

                        if (listViewGMessagesRecordList.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 70),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                            imageUrl: widget.groupPf,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "This is the beginning of the group named ${widget.groupName}",
                                  style: FlutterFlowTheme.title1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          controller: messageListController,
                          padding: EdgeInsets.zero,
                          reverse: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewGMessagesRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewGMessagesRecord =
                                listViewGMessagesRecordList[listViewIndex];
                            if (currentUserUid ==
                                listViewGMessagesRecord.authorId) {
                              return Dismissible(
                                onDismissed: (_) {
                                  listViewGMessagesRecord.reference.delete();
                                },
                                key:
                                    ValueKey(listViewGMessagesRecord.timestamp),
                                child: ChatMessage(
                                  index: listViewIndex,
                                  data: listViewGMessagesRecord,
                                  nbElements:
                                      listViewGMessagesRecordList.length,
                                ),
                              );
                            }
                            return ChatMessageOther(
                              index: listViewIndex,
                              data: listViewGMessagesRecord,
                              showAvatar: shouldDisplayAvatar(listViewIndex),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  MessageForm(
                    onSubmit: _addMessage,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
