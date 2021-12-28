/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgur/imgur.dart' as imgur;
import 'package:scarla/flutter_flow/upload_media.dart';
import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../group_add_member_page/group_add_member_page_widget.dart';
import '../main.dart';
import '../profile_page/profile_page_widget.dart';

/// Widget de la page de réglages pour les groupes
class GroupsSettingsPageWidget extends StatefulWidget {
  GroupsSettingsPageWidget({Key key, this.groupRef, this.groupName})
      : super(key: key);

  final DocumentReference groupRef;
  final String groupName;

  @override
  _GroupsSettingsPageWidgetState createState() =>
      _GroupsSettingsPageWidgetState();
}

class _GroupsSettingsPageWidgetState extends State<GroupsSettingsPageWidget> {
  TextEditingController groupNameFieldController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String groupPic;

  @override
  void initState() {
    super.initState();
    groupNameFieldController = TextEditingController(text: widget.groupName);
  }

  /// Récupère l'image téléverser par l'utilisateur pour mettre dans [groupPic]
  Future getImage({bool isVideo = false}) async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    if (isVideo) {
      pickedFile = await imagePicker.getVideo(source: ImageSource.gallery);
    } else {
      pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      final isValid = await validateFileFormat(pickedFile.path, context);
      if (isValid) {
        setState(() {
          FlutterFlowTheme.isUploading = true;
        });
        final client =
            imgur.Imgur(imgur.Authentication.fromClientId('2a04555f27563dc'));
        await client.image
            .uploadImage(
                imagePath: pickedFile.path, title: '*_*', description: '*_*')
            .then((image) {
          groupPic = image.link;
          setState(() {
            FlutterFlowTheme.isUploading = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GroupsRecord>(
      stream: GroupsRecord.getDocument(widget.groupRef),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final groupsSettingsPageGroupsRecord = snapshot.data;
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
                  Align(
                    alignment: Alignment(0, 0),
                    child: Column(
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
                                IconButton(
                                  onPressed: () async {
                                    /// Ramène à la page de messages du groupe
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_sharp,
                                    color: FlutterFlowTheme.title1Color,
                                    size: 30,
                                  ),
                                  iconSize: 30,
                                ),
                                Text(
                                  'Group Settings',
                                  style: FlutterFlowTheme.title1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    /// Envoie vers la page de messages du groupe en sauvegardant les changements
                                    final gName = groupNameFieldController.text;
                                    final gPhotoUrl = (groupPic != null)
                                        ? groupPic
                                        : groupsSettingsPageGroupsRecord
                                            .gPhotoUrl;

                                    final groupsRecordData = {
                                      ...createGroupsRecordData(
                                        gName: gName,
                                        gPhotoUrl: gPhotoUrl,
                                      ),
                                      'members_id': FieldValue.arrayUnion(
                                          [currentUserUid]),
                                    };

                                    await widget.groupRef
                                        .update(groupsRecordData);
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.check_rounded,
                                    color: FlutterFlowTheme.title1Color,
                                    size: 30,
                                  ),
                                  iconSize: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment(0, 0),
                                child: InkWell(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: (groupPic != null)
                                          ? groupPic
                                          : groupsSettingsPageGroupsRecord
                                              .gPhotoUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment(0, 0),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(65, 0, 0, 0),
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: Color(0xAEC1C1C1),
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: Color(0x9CCBCBCB),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.pen,
                                            color: Colors.black,
                                            size: 12,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(),
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(35)
                            ],
                            controller: groupNameFieldController,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Group Name',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Poppins',
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
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
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              filled: true,
                              fillColor: Color(0xFF4D5078),
                            ),
                            style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Poppins',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            (groupsSettingsPageGroupsRecord.host ==
                                        currentUserReference ||
                                    groupsSettingsPageGroupsRecord
                                            .membersId.length <=
                                        2)
                                ? Padding(
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        /// Ça demande si l'utilisateur est sûre d'enlever le groupe
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
                                                  'Are you sure you want to delete this group?',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600),),
                                              actions: <Widget>[
                                                Column(
                                                  children: [
                                                    Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 24, 15),
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
                                                                  0, 0, 14, 0),
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
                                                                /// Ça annule la commande
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
                                                                  0, 0, 23, 0),
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
                                                                'Yes!',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                /// Ça enleve le groupe de la liste de groupes de l'utilisateur
                                                                await widget
                                                                    .groupRef
                                                                    .delete();
                                                                await Navigator
                                                                    .pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        NavBarPage(
                                                                            initialPage:
                                                                                'GroupListPage'),
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
                                      text: 'Delete Group',
                                      options: FFButtonOptions(
                                        width: 130,
                                        height: 40,
                                        color: FlutterFlowTheme.secondaryColor,
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Poppins',
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: 12,
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        /// Ça demande si l'utilisateur veut quitter le groupe
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
                                                  'Are you sure you want to leave this '
                                                  'group?',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600),),
                                              actions: <Widget>[
                                                Column(
                                                  children: [
                                                    Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 23, 15),
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
                                                                  0, 0, 10, 0),
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
                                                                /// Ça annule la commande
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
                                                                  0, 0, 25, 0),
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
                                                                'Yes!',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                /// Ça enleve l'utilisateur du groupe
                                                                final groupsRecordData =
                                                                    {
                                                                  'members_id':
                                                                      FieldValue
                                                                          .arrayRemove([
                                                                    currentUserUid
                                                                  ]),
                                                                };

                                                                await widget
                                                                    .groupRef
                                                                    .update(
                                                                        groupsRecordData);
                                                                await Navigator
                                                                    .pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        NavBarPage(
                                                                            initialPage:
                                                                                'GroupListPage'),
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
                                      text: 'Leave Group',
                                      options: FFButtonOptions(
                                        width: 130,
                                        height: 40,
                                        color: FlutterFlowTheme.secondaryColor,
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Poppins',
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: 12,
                                      ),
                                    ),
                                  )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 19,
                          indent: 20,
                          endIndent: 20,
                          color: Color(0xFF666666),
                          thickness: 0.3,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(23, 7, 10, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                FluentIcons.people_16_regular,
                                color: FlutterFlowTheme.title1Color,
                                size: 30,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                child: Text(
                                  'Members',

                                  //textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.title3.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  /// Envoie à la page d'ajout des amis dans un groupe
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GroupAddMemberPageWidget(
                                        groupRef: widget.groupRef,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  FluentIcons.people_add_16_regular,
                                  //Icons.add_circle,
                                  color: FlutterFlowTheme.title1Color,
                                  size: 30,
                                ),
                                iconSize: 30,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child:
                          /// Fait la requête des utilisateurs dans le groupe courant
                          StreamBuilder<List<UsersRecord>>(
                            stream: queryUsersRecord(
                              queryBuilder: (usersRecord) => usersRecord.where(
                                  'uid',
                                  whereIn: groupsSettingsPageGroupsRecord
                                      .membersId
                                      .asList()),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              List<UsersRecord> listViewUsersRecordList =
                                  snapshot.data;
                              // Customize what your widget looks like with no query results.
                              if (listViewUsersRecordList.isEmpty) {
                                return Center(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://static.thenounproject.com/png/449469-200.png',
                                  ),
                                );
                              }
                              return Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount: listViewUsersRecordList.length,
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewUsersRecord =
                                        listViewUsersRecordList[listViewIndex];
                                    return InkWell(
                                      onTap: () async {
                                        /// Envoie l'utilisateur vers la page de profile de l'utilisateur qu'il a clicker
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProfilePageWidget(
                                              userRef:
                                                  listViewUsersRecord.reference,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: FlutterFlowTheme.title1Color,
                                        child: Align(
                                          alignment: Alignment(0, 0),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 5, 5, 5),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 80,
                                                      height: 80,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            listViewUsersRecord
                                                                .photoUrl,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 0, 0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            listViewUsersRecord
                                                                .name,
                                                            textAlign: TextAlign
                                                                .justify,
                                                            style:
                                                                FlutterFlowTheme
                                                                    .subtitle2
                                                                    .override(
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                          Text(
                                                            '#',
                                                            textAlign: TextAlign
                                                                .justify,
                                                            style: FlutterFlowTheme
                                                                .bodyText2
                                                                .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          Text(
                                                            listViewUsersRecord
                                                                .tag,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: FlutterFlowTheme
                                                                .bodyText2
                                                                .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        16),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                if ((groupsSettingsPageGroupsRecord
                                                                .host ==
                                                            currentUserReference ||
                                                        groupsSettingsPageGroupsRecord
                                                                .membersId
                                                                .length <=
                                                            2) &&
                                                    listViewUsersRecord.uid !=
                                                        currentUserUid)
                                                  IconButton(
                                                    onPressed: () async {
                                                      /// Ça demande si l'utilisateur est sûre d'enlever un autre utilisateur du groupe
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            backgroundColor: Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(10.0),
                                                            ),
                                                            content:
                                                            Text.rich(
                                                              TextSpan(text: 'Are you sure you want \n to remove',
                                                                  children: [
                                                                    TextSpan(text: ' ${listViewUsersRecord.name}', style: TextStyle(fontWeight: FontWeight.w900)),
                                                                    TextSpan(text: ' from this group?'),
                                                                  ]),

                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                  fontFamily: 'Poppins',
                                                                  fontWeight: FontWeight.w600),
                                                            ),
                                                            actions: <Widget>[
                                                              Column(
                                                                children: [
                                                                  Center(
                                                                    child: Padding(
                                                                      padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          0, 0, 7, 15),
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
                                                                            0, 0, 13, 0),
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
                                                                              /// Ça annule la commande
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
                                                                            0, 0, 7, 0),
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
                                                                              'Yes!',
                                                                              style: TextStyle(
                                                                                  color: Colors
                                                                                      .white),
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              /// Ça enleve un utilisateur du groupe
                                                                                Navigator.of(context).pop();
                                                                                final groupsRecordData = {
                                                                                    'members_id': FieldValue
                                                                                        .arrayRemove([
                                                                                      listViewUsersRecord
                                                                                          .uid
                                                                                    ]),
                                                                                  };

                                                                                  await widget.groupRef
                                                                                      .update(
                                                                                      groupsRecordData);
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
                                                    icon: Icon(
                                                      Icons.cancel_sharp,
                                                      color: FlutterFlowTheme
                                                          .subtitle2Color,
                                                      size: 30,
                                                    ),
                                                    iconSize: 30,
                                                  )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
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
              )
            ],
          ),
        );
      },
    );
  }
}
