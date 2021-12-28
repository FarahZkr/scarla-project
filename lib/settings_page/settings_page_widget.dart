/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgur/imgur.dart' as imgur;
import 'package:scarla/add_remove_game_page/add_remove_game_page_widget.dart';
import 'package:scarla/flutter_flow/upload_media.dart';
import 'package:scarla/util/transparent_route.dart';
import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../edit_game_page/edit_game_page_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';

/// Widget pour les paramètres de l'utilisateur
class SettingsPageWidget extends StatefulWidget {
  SettingsPageWidget(
      {Key key,
      this.photoUrl,
      this.user,
      this.name,
      this.tag,
      this.bgProfile,
      this.about})
      : super(key: key);

  String photoUrl;
  final DocumentReference user;
  final String name;
  final String tag;
  String bgProfile;
  final String about;

  @override
  _SettingsPageWidgetState createState() => _SettingsPageWidgetState();
}

class _SettingsPageWidgetState extends State<SettingsPageWidget> {
  TextEditingController aboutFieldController;
  TextEditingController tagFieldController;
  TextEditingController usernameFieldController;
  bool notificationSwitchSetting;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Color color1 = Color(0xff0b323e);
  Color color2 = Color(0xff010b15);

  @override
  void initState() {
    super.initState();
    aboutFieldController = TextEditingController(text: widget.about);
    tagFieldController = TextEditingController(text: widget.tag);
    usernameFieldController = TextEditingController(text: widget.name);
  }

  /// Récupèrer l'image de profile téléverser par l'utilisateur
  Future getImage({bool isVideo = false, bool isPfp = true}) async {
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
          if (isPfp) {
            widget.photoUrl = image.link;
          } else {
            widget.bgProfile = image.link;
          }
          setState(() {
            FlutterFlowTheme.isUploading = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Fait la requête de l'utilisateur connecté
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(currentUserReference),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final settingsPageUsersRecord = snapshot.data;
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        /// L'utilisateur peut changer les couleurs déjà définies
                                        setState(() {
                                          FlutterFlowTheme.primaryColor =
                                              Color(0xFF25263E);
                                          FlutterFlowTheme.secondaryColor =
                                              Color(0xFFFF4553);
                                          FlutterFlowTheme.tertiaryColor =
                                              Color(0xFF252854);
                                          FlutterFlowTheme.appBarColor =
                                              Color(0xA2000000);
                                          FlutterFlowTheme.title1Color =
                                              Color(0xFF535480);
                                          FlutterFlowTheme.title2Color =
                                              Colors.white;
                                          FlutterFlowTheme.title3Color =
                                              Colors.white;
                                          FlutterFlowTheme.subtitle1Color =
                                              Colors.black;
                                          FlutterFlowTheme.subtitle2Color =
                                              Colors.white;
                                          FlutterFlowTheme.body1Color =
                                              Colors.white;
                                          FlutterFlowTheme.body2Color =
                                              Color(0xFFB2B2B2);
                                          notificationSwitchSetting = true;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: FlutterFlowTheme.title1Color,
                                        size: 27,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'Settings',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.title1.override(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Spacer()
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                ),
                                child: Stack(
                                  children: [
                                    (widget.bgProfile != "")
                                        ? Align(
                                            alignment: Alignment(0, 0),
                                            child: (FlutterFlowTheme
                                                    .isUploading)
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator())
                                                : CachedNetworkImage(
                                                    imageUrl: widget.bgProfile,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            1,
                                                    fit: BoxFit.cover,
                                                    placeholder: (context,
                                                            url) =>
                                                        Container(
                                                            color: FlutterFlowTheme
                                                                .tertiaryColor),
                                                  ),
                                          )
                                        : Container(
                                            color:
                                                FlutterFlowTheme.tertiaryColor),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        /// L'utilisateur téléverse une image pour sa page de profil
                                        getImage(isPfp: false);
                                      },
                                      text: 'Modify',
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: double.infinity,
                                        color: Color(0x66252854),
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Poppins',
                                        ),
                                        elevation: 2,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: 0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment(0, 0),
                                  child: InkWell(
                                    onTap: () async {
                                      /// Récupère image téléversée par l'utilisateur
                                      getImage();
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: (FlutterFlowTheme.isUploading)
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : CachedNetworkImage(
                                              imageUrl: widget.photoUrl,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Container(
                                                      color: FlutterFlowTheme
                                                          .tertiaryColor),
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                          color: Color(0x9CCBCBCB),
                                        ),
                                      ),
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
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(30, 0, 30, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10)
                                      ],
                                      controller: usernameFieldController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: 'Username',
                                        hintStyle:
                                            FlutterFlowTheme.bodyText2.override(
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
                                      style:
                                          FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Poppins',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                    child: Text(
                                      '#',
                                      style:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(5)
                                      ],
                                      controller: tagFieldController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: 'Tag',
                                        hintStyle:
                                            FlutterFlowTheme.bodyText2.override(
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
                                      style:
                                          FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Poppins',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                              child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(125)
                                ],
                                controller: aboutFieldController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'My description ...',
                                  hintStyle:
                                      FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Poppins',
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFF4D5078),
                                ),
                                style: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Poppins',
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 3,
                              ),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Divider(
                              height: 0,
                              indent: 20,
                              endIndent: 20,
                              color: Color(0xF7808080),
                              thickness: 0.3,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Game Preference',
                                      textAlign: TextAlign.center,
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Competitive',
                                            style: FlutterFlowTheme.bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          ToggleIcon(
                                            onPressed: () async {
                                              /// Enleve ou ajoute la variable [isCompetitive] à l'utilisateur
                                              final isCompetitive =
                                                  !settingsPageUsersRecord
                                                      .isCompetitive;

                                              final usersRecordData =
                                                  createUsersRecordData(
                                                isCompetitive: isCompetitive,
                                              );

                                              await settingsPageUsersRecord
                                                  .reference
                                                  .update(usersRecordData);
                                            },
                                            value: settingsPageUsersRecord
                                                .isCompetitive,
                                            onIcon: Icon(
                                              Icons.check_box,
                                              color: Color(0xFF535480),
                                              size: 23,
                                            ),
                                            offIcon: Icon(
                                              Icons.check_box_outline_blank,
                                              color: Color(0xFF535480),
                                              size: 23,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              height: 5,
                              indent: 20,
                              endIndent: 20,
                              color: Color(0xF7808080),
                              thickness: 0.3,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'App Settings',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Primary Color',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(50, 3, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FFButtonWidget(
                                            onPressed: () {
                                              /// Permet le changement de couleur du [primaryColor]
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    titlePadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: MaterialPicker(
                                                        pickerColor:
                                                            FlutterFlowTheme
                                                                .primaryColor,
                                                        onColorChanged:
                                                            (Color c) {
                                                          setState(() {
                                                            FlutterFlowTheme
                                                                .primaryColor = c;
                                                          });
                                                        },
                                                        enableLabel: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            text: '',
                                            options: FFButtonOptions(
                                              width: 25,
                                              height: 25,
                                              color:
                                                  FlutterFlowTheme.primaryColor,
                                              textStyle: FlutterFlowTheme
                                                  .subtitle2
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                              borderRadius: 12,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              /// Réinitialise la couleur [primaryColor] à la couleur initiale
                                              setState(() {
                                                FlutterFlowTheme.primaryColor =
                                                    Color(0xFF25263E);
                                              });
                                            },
                                            child: Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: Color(0xFFF5F5F5),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    2, 0, 2, 0),
                                                child: Text(
                                                  'Reset',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Secondary Color',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FFButtonWidget(
                                            onPressed: () {
                                              /// Permet le changement de couleur du [secondaryColor]
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    titlePadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: MaterialPicker(
                                                        pickerColor:
                                                            FlutterFlowTheme
                                                                .secondaryColor,
                                                        onColorChanged:
                                                            (Color c) {
                                                          setState(() {
                                                            FlutterFlowTheme
                                                                .secondaryColor = c;
                                                          });
                                                        },
                                                        enableLabel: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            text: '',
                                            options: FFButtonOptions(
                                              width: 25,
                                              height: 25,
                                              color: FlutterFlowTheme
                                                  .secondaryColor,
                                              textStyle: FlutterFlowTheme
                                                  .subtitle2
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                              borderRadius: 12,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              /// Réinitialise la couleur [secondaryColor] à la couleur initiale
                                              setState(() {
                                                FlutterFlowTheme
                                                        .secondaryColor =
                                                    Color(0xFFFF4553);
                                              });
                                            },
                                            child: Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: Color(0xFFF5F5F5),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    2, 0, 2, 0),
                                                child: Text(
                                                  'Reset',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Tertiary Color',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(55, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FFButtonWidget(
                                            onPressed: () {
                                              /// Permet le changement de couleur du [tertiaryColor]
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    titlePadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: MaterialPicker(
                                                        pickerColor:
                                                            FlutterFlowTheme
                                                                .tertiaryColor,
                                                        onColorChanged:
                                                            (Color c) {
                                                          setState(() {
                                                            FlutterFlowTheme
                                                                .tertiaryColor = c;
                                                          });
                                                        },
                                                        enableLabel: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            text: '',
                                            options: FFButtonOptions(
                                              width: 25,
                                              height: 25,
                                              color: FlutterFlowTheme
                                                  .tertiaryColor,
                                              textStyle: FlutterFlowTheme
                                                  .subtitle2
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                              borderRadius: 12,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              /// Réinitialise la couleur [tertiaryColor] à la couleur initiale
                                              setState(() {
                                                FlutterFlowTheme.tertiaryColor =
                                                    Color(0xFF252854);
                                              });
                                            },
                                            child: Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: Color(0xFFF5F5F5),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    2, 0, 2, 0),
                                                child: Text(
                                                  'Reset',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'AppBar Color',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(55, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FFButtonWidget(
                                            onPressed: () {
                                              /// Permet le changement de couleur du [appBarColor]
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    titlePadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: MaterialPicker(
                                                        pickerColor:
                                                            FlutterFlowTheme
                                                                .appBarColor,
                                                        onColorChanged:
                                                            (Color c) {
                                                          setState(() {
                                                            FlutterFlowTheme
                                                                .appBarColor = c;
                                                          });
                                                        },
                                                        enableLabel: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            text: '',
                                            options: FFButtonOptions(
                                              width: 25,
                                              height: 25,
                                              color:
                                                  FlutterFlowTheme.appBarColor,
                                              textStyle: FlutterFlowTheme
                                                  .subtitle2
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                              borderRadius: 12,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              /// Réinitialise la couleur [appBarColor] à la couleur initiale
                                              setState(() {
                                                FlutterFlowTheme.appBarColor =
                                                    Color(0xA2000000);
                                              });
                                            },
                                            child: Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: Color(0xFFF5F5F5),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    2, 0, 2, 0),
                                                child: Text(
                                                  'Reset',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Title 1 Color',
                                      style: FlutterFlowTheme.title1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () {
                                            /// Permet le changement de couleur du [title1Color]
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  titlePadding:
                                                      const EdgeInsets.all(0.0),
                                                  contentPadding:
                                                      const EdgeInsets.all(0.0),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: MaterialPicker(
                                                      pickerColor:
                                                          FlutterFlowTheme
                                                              .title1Color,
                                                      onColorChanged:
                                                          (Color c) {
                                                        setState(() {
                                                          FlutterFlowTheme
                                                              .title1Color = c;
                                                        });
                                                      },
                                                      enableLabel: true,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          text: '',
                                          options: FFButtonOptions(
                                            width: 25,
                                            height: 25,
                                            color: FlutterFlowTheme.title1Color,
                                            textStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 1,
                                            ),
                                            borderRadius: 12,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            /// Réinitialise la couleur [title1Color] à la couleur initiale
                                            setState(() {
                                              FlutterFlowTheme.title1Color =
                                                  Color(0xFF535480);
                                            });
                                          },
                                          child: Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: Color(0xFFF5F5F5),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  2, 0, 2, 0),
                                              child: Text(
                                                'Reset',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Title 2 Color',
                                      style: FlutterFlowTheme.title2.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FFButtonWidget(
                                            onPressed: () {
                                              /// Permet le changement de couleur du [title2Color]
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    titlePadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: MaterialPicker(
                                                        pickerColor:
                                                            FlutterFlowTheme
                                                                .title2Color,
                                                        onColorChanged:
                                                            (Color c) {
                                                          setState(() {
                                                            FlutterFlowTheme
                                                                .title2Color = c;
                                                          });
                                                        },
                                                        enableLabel: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            text: '',
                                            options: FFButtonOptions(
                                              width: 25,
                                              height: 25,
                                              color:
                                                  FlutterFlowTheme.title2Color,
                                              textStyle: FlutterFlowTheme
                                                  .subtitle2
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                              borderRadius: 12,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              /// Réinitialise la couleur [title2Color] à la couleur initiale
                                              setState(() {
                                                FlutterFlowTheme.title2Color =
                                                    Colors.white;
                                              });
                                            },
                                            child: Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: Color(0xFFF5F5F5),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    2, 0, 2, 0),
                                                child: Text(
                                                  'Reset',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Subtitle 1 Color',
                                      style:
                                          FlutterFlowTheme.subtitle1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FFButtonWidget(
                                            onPressed: () {
                                              /// Permet le changement de couleur du [subtitle1Color]
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    titlePadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: MaterialPicker(
                                                        pickerColor:
                                                            FlutterFlowTheme
                                                                .subtitle1Color,
                                                        onColorChanged:
                                                            (Color c) {
                                                          setState(() {
                                                            FlutterFlowTheme
                                                                .subtitle1Color = c;
                                                          });
                                                        },
                                                        enableLabel: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            text: '',
                                            options: FFButtonOptions(
                                              width: 25,
                                              height: 25,
                                              color: FlutterFlowTheme
                                                  .subtitle1Color,
                                              textStyle: FlutterFlowTheme
                                                  .subtitle2
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                              borderRadius: 12,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              /// Réinitialise la couleur [subtitle1Color] à la couleur initiale
                                              setState(() {
                                                FlutterFlowTheme
                                                        .subtitle1Color =
                                                    Colors.black;
                                              });
                                            },
                                            child: Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: Color(0xFFF5F5F5),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    2, 0, 2, 0),
                                                child: Text(
                                                  'Reset',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Subtitle 2 Color',
                                      style:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FFButtonWidget(
                                            onPressed: () {
                                              /// Permet le changement de couleur du [subtitle2Color]
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    titlePadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: MaterialPicker(
                                                        pickerColor:
                                                            FlutterFlowTheme
                                                                .subtitle2Color,
                                                        onColorChanged:
                                                            (Color c) {
                                                          setState(() {
                                                            FlutterFlowTheme
                                                                .subtitle2Color = c;
                                                          });
                                                        },
                                                        enableLabel: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            text: '',
                                            options: FFButtonOptions(
                                              width: 25,
                                              height: 25,
                                              color: FlutterFlowTheme
                                                  .subtitle2Color,
                                              textStyle: FlutterFlowTheme
                                                  .subtitle2
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                              borderRadius: 12,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              /// Réinitialise la couleur [subtitle2Color] à la couleur initiale
                                              setState(() {
                                                FlutterFlowTheme
                                                        .subtitle2Color =
                                                    Colors.white;
                                              });
                                            },
                                            child: Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: Color(0xFFF5F5F5),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    2, 0, 2, 0),
                                                child: Text(
                                                  'Reset',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Body Text 1 Color',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FFButtonWidget(
                                            onPressed: () {
                                              /// Permet le changement de couleur du [body1Color]
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    titlePadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: MaterialPicker(
                                                        pickerColor:
                                                            FlutterFlowTheme
                                                                .body1Color,
                                                        onColorChanged:
                                                            (Color c) {
                                                          setState(() {
                                                            FlutterFlowTheme
                                                                .body1Color = c;
                                                          });
                                                        },
                                                        enableLabel: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            text: '',
                                            options: FFButtonOptions(
                                              width: 25,
                                              height: 25,
                                              color:
                                                  FlutterFlowTheme.body1Color,
                                              textStyle: FlutterFlowTheme
                                                  .subtitle2
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                              borderRadius: 12,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              /// Réinitialise la couleur [body1Color] à la couleur initiale
                                              setState(() {
                                                FlutterFlowTheme.body1Color =
                                                    Colors.white;
                                              });
                                            },
                                            child: Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: Color(0xFFF5F5F5),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    2, 0, 2, 0),
                                                child: Text(
                                                  'Reset',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Body Text 2 Color',
                                      style:
                                          FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FFButtonWidget(
                                            onPressed: () {
                                              /// Permet le changement de couleur du [body2Color]
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    titlePadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: MaterialPicker(
                                                        pickerColor:
                                                            FlutterFlowTheme
                                                                .body2Color,
                                                        onColorChanged:
                                                            (Color c) {
                                                          setState(() {
                                                            FlutterFlowTheme
                                                                .body2Color = c;
                                                          });
                                                        },
                                                        enableLabel: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            text: '',
                                            options: FFButtonOptions(
                                              width: 25,
                                              height: 25,
                                              color:
                                                  FlutterFlowTheme.body2Color,
                                              textStyle: FlutterFlowTheme
                                                  .subtitle2
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                              borderRadius: 12,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              /// Réinitialise la couleur [body2Color] à la couleur initiale
                                              setState(() {
                                                FlutterFlowTheme.body2Color =
                                                    Color(0xFFB2B2B2);
                                              });
                                            },
                                            child: Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: Color(0xFFF5F5F5),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    2, 0, 2, 0),
                                                child: Text(
                                                  'Reset',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 15, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              /// Demande l'utilisateur s'il veut réinitialiser les paramètres de couleur
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    title: Center(
                                                        child: Text('Alert!')),
                                                    content: Text(
                                                        'Are you sure you want to reset your color settings?'),
                                                    actions: <Widget>[
                                                      Column(
                                                        children: [
                                                          Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      0,
                                                                      0,
                                                                      22,
                                                                      15),
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
                                                                          .grey[
                                                                      300],
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
                                                                        0,
                                                                        0,
                                                                        10,
                                                                        0),
                                                                child:
                                                                    Container(
                                                                  width: 107,
                                                                  height: 47,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            24),
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  child:
                                                                      TextButton(
                                                                    child: Text(
                                                                      'Cancel',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      /// Annule commande et retourne à page précédente
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
                                                                        0,
                                                                        0,
                                                                        20,
                                                                        0),
                                                                child:
                                                                    Container(
                                                                  width: 107,
                                                                  height: 47,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            24),
                                                                    color: Color(
                                                                        0xffff4553),
                                                                  ),
                                                                  child:
                                                                      TextButton(
                                                                    child: Text(
                                                                      'Yes!',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      /// Réinitialise tous les paramètres des couleurs
                                                                      setState(
                                                                          () {
                                                                        FlutterFlowTheme.primaryColor =
                                                                            Color(0xFF25263E);
                                                                        FlutterFlowTheme.secondaryColor =
                                                                            Color(0xFFFF4553);
                                                                        FlutterFlowTheme.tertiaryColor =
                                                                            Color(0xFF252854);
                                                                        FlutterFlowTheme.appBarColor =
                                                                            Color(0xA2000000);
                                                                        FlutterFlowTheme.title1Color =
                                                                            Color(0xFF535480);
                                                                        FlutterFlowTheme.title2Color =
                                                                            Colors.white;
                                                                        FlutterFlowTheme.title3Color =
                                                                            Colors.white;
                                                                        FlutterFlowTheme.subtitle1Color =
                                                                            Colors.black;
                                                                        FlutterFlowTheme.subtitle2Color =
                                                                            Colors.white;
                                                                        FlutterFlowTheme.body1Color =
                                                                            Colors.white;
                                                                        FlutterFlowTheme.body2Color =
                                                                            Color(0xFFB2B2B2);
                                                                        notificationSwitchSetting =
                                                                            true;
                                                                      });
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
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
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 26, 0),
                                              child: Card(
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                color: Color(0xFFF5F5F5),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      2, 0, 2, 0),
                                                  child: Text(
                                                    'Reset All',
                                                    style: GoogleFonts.getFont(
                                                      'Poppins',
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              height: 4,
                              indent: 20,
                              endIndent: 20,
                              color: Color(0xF7808080),
                              thickness: 0.3,
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 40),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(),
                                    child: Text(
                                      'Game Settings',
                                      textAlign: TextAlign.center,
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(),
                                    child: GridView(
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
                                        if (settingsPageUsersRecord
                                            .selectedGames
                                            .contains("valorant"))
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  /// Envoie vers la page d'édition de jeu pour valorant
                                                  await Navigator.push(
                                                    context,
                                                    TransparentRoute(
                                                      builder: (context) =>
                                                          EditGamePageWidget(
                                                        game: 'valorant',
                                                        user:
                                                            settingsPageUsersRecord
                                                                .reference,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color(0xffff4454),
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  child: Image.asset(
                                                    'assets/games/icons/valorantIcon.png',
                                                    scale: 150,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        if (settingsPageUsersRecord
                                            .selectedGames
                                            .contains("mw"))
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  /// Envoie vers la page d'édition de jeu pour mw
                                                  await Navigator.push(
                                                    context,
                                                    TransparentRoute(
                                                      builder: (context) =>
                                                          EditGamePageWidget(
                                                        game: 'mw',
                                                        user:
                                                            settingsPageUsersRecord
                                                                .reference,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black54,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  child: Image.asset(
                                                    'assets/games/icons/mwIcon.png',
                                                    scale: 2.7,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        if (settingsPageUsersRecord
                                            .selectedGames
                                            .contains("rl"))
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  /// Envoie vers la page d'édition de jeu pour rl
                                                  await Navigator.push(
                                                    context,
                                                    TransparentRoute(
                                                      builder: (context) =>
                                                          EditGamePageWidget(
                                                        game: 'rl',
                                                        user:
                                                            settingsPageUsersRecord
                                                                .reference,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color(0xff004ca3),
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 2, top: 1),
                                                    child: Image.asset(
                                                      'assets/games/icons/rlIcon.png',
                                                      scale: 28,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        if (settingsPageUsersRecord
                                            .selectedGames
                                            .contains("ow"))
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  /// Envoie vers la page d'édition de jeu pour ow
                                                  await Navigator.push(
                                                    context,
                                                    TransparentRoute(
                                                      builder: (context) =>
                                                          EditGamePageWidget(
                                                        game: 'ow',
                                                        user:
                                                            settingsPageUsersRecord
                                                                .reference,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.grey[300],
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  child: Image.asset(
                                                    'assets/games/icons/owIcon.png',
                                                    scale: 33,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        if (settingsPageUsersRecord
                                            .selectedGames
                                            .contains("lol"))
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  /// Envoie vers la page d'édition de jeu pour lol
                                                  await Navigator.push(
                                                    context,
                                                    TransparentRoute(
                                                      builder: (context) =>
                                                          EditGamePageWidget(
                                                        game: 'lol',
                                                        user:
                                                            settingsPageUsersRecord
                                                                .reference,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.black),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        color1,
                                                        color2,
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 2, bottom: 1),
                                                    child: Image.asset(
                                                      'assets/games/icons/lolIcon.png',
                                                      scale: 13,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                /// Envoie vers la page pour ajouter ou enlever des jeux
                                                await Navigator.push(
                                                  context,
                                                  TransparentRoute(
                                                    builder: (context) =>
                                                        AddRemoveGamePageWidget(),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: FlutterFlowTheme
                                                      .secondaryColor,
                                                ),
                                                child: Center(
                                                  child: FaIcon(
                                                    FontAwesomeIcons.pen,
                                                    color: FlutterFlowTheme
                                                        .primaryColor,
                                                    size: 25,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 12, 11),
                    //13,13
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 91,
                        height: 57,
                        child: Card(
                          elevation: 8,
                          shadowColor: Colors.black,
                          color: Color(0xFF4D5078),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            splashColor: Colors.white.withAlpha(30),
                            highlightColor: Colors.white.withAlpha(30),
                            onTap: () async {
                              /// Valide les entrées et les sauvegarde dans la base de données
                              if (usernameFieldController.text.isEmpty ||
                                  tagFieldController.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      title: Center(child: Text('Error')),
                                      content: Text(
                                        'Your username is not valid!',
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: <Widget>[
                                        Column(
                                          children: [
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 7, 15),
                                                child: Container(
                                                  width: 250,
                                                  height: 1,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                    color: Colors.grey[300],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 7, 0),
                                                  child: Container(
                                                    width: 107,
                                                    height: 47,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                      color: Color(0xffff4553),
                                                    ),
                                                    child: TextButton(
                                                      child: Text(
                                                        'Ok!',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
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
                              } else {
                                final name = usernameFieldController.text;
                                final tag = tagFieldController.text;
                                final photoUrl = widget.photoUrl;
                                final bgProfile = widget.bgProfile;
                                final about = aboutFieldController.text;

                                final keys = createKeys("$name#$tag");

                                final usersRecordData = {
                                  ...createUsersRecordData(
                                    name: name,
                                    tag: tag,
                                    photoUrl: photoUrl,
                                    bgProfile: bgProfile,
                                    about: about,
                                  ),
                                  'keys': keys,
                                };

                                await settingsPageUsersRecord.reference
                                    .update(usersRecordData);
                                Navigator.pop(context);
                              }
                            },
                            child: Center(
                              child: Text(
                                'Save',
                                style: FlutterFlowTheme.subtitle2
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    )
                                    .merge(TextStyle(letterSpacing: 1.3)),
                              ),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF373856).withOpacity(0.04),
                                spreadRadius: 0,
                                blurRadius: 21,
                                offset: Offset(0, 6),
                              )
                            ]),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
