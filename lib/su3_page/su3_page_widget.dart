/*
 * Copyright (c) 2021. Scarla
 */

import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../su4_page/su4_page_widget.dart';

/// Widget pour la troisième page d'inscription
class Su3PageWidget extends StatefulWidget {
  Su3PageWidget({Key key, this.username, this.tag, this.photoUrl, this.about})
      : super(key: key);

  final String username;
  final String tag;
  final String photoUrl;
  final String about;

  @override
  _Su3PageWidgetState createState() => _Su3PageWidgetState();
}

class _Su3PageWidgetState extends State<Su3PageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<bool> selected = List.filled(5, false);
  List<String> selectedGames = List.empty(growable: true);

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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(1, 100, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Choose your games',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.title2.override(
                            fontFamily: 'Poppins',
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: ListView(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        children: [
                          InkWell(
                            onTap: () async {
                              /// Ajoute ou enleve le jeu lol à la liste des jeux de l'utilisateur
                              setState(() {
                                selected[0] = !selected[0];
                              });

                              if (selectedGames.contains("lol")) {
                                selectedGames.remove("lol");
                              } else {
                                selectedGames.add("lol");
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: new BoxDecoration(
                                    border: Border.all(
                                        width: 4,
                                        color: (!selected[0])
                                            ? Colors.transparent
                                            : Colors.green),
                                    borderRadius: BorderRadius.circular(24),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'assets/games/cards/lol/3.jpg',
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 35, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'League of legends',
                                          textAlign: TextAlign.center,
                                          style:
                                              FlutterFlowTheme.title1.override(
                                            fontFamily: 'Roboto',
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 3.5,
                          ),
                          InkWell(
                            onTap: () async {
                              setState(() {
                                /// Ajoute ou enleve le jeu valorant à la liste des jeux de l'utilisateur
                                selected[1] = !selected[1];
                              });

                              if (selectedGames.contains("valorant")) {
                                selectedGames.remove("valorant");
                              } else {
                                selectedGames.add("valorant");
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: new BoxDecoration(
                                    border: Border.all(
                                        width: 4,
                                        color: (!selected[1])
                                            ? Colors.transparent
                                            : Colors.green),
                                    borderRadius: BorderRadius.circular(24),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'assets/games/cards/valorant/3.jpg',
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 35, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Valorant',
                                          textAlign: TextAlign.center,
                                          style:
                                              FlutterFlowTheme.title1.override(
                                            fontFamily: 'Roboto',
                                            color: Colors.white,
                                            fontSize: 30,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 3.5,
                          ),
                          InkWell(
                            onTap: () async {
                              /// Ajoute ou enleve le jeu mw à la liste des jeux de l'utilisateur
                              setState(() {
                                selected[2] = !selected[2];
                              });

                              if (selectedGames.contains("mw")) {
                                selectedGames.remove("mw");
                              } else {
                                selectedGames.add("mw");
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: new BoxDecoration(
                                    border: Border.all(
                                        width: 4,
                                        color: (!selected[2])
                                            ? Colors.transparent
                                            : Colors.green),
                                    borderRadius: BorderRadius.circular(24),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'assets/games/cards/mw/3.jpg',
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 35, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Call of duty MW',
                                          textAlign: TextAlign.center,
                                          style:
                                              FlutterFlowTheme.title1.override(
                                            fontFamily: 'Roboto',
                                            color: Colors.white,
                                            fontSize: 30,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 3.5,
                          ),
                          InkWell(
                            onTap: () async {
                              /// Ajoute ou enleve le jeu ow à la liste des jeux de l'utilisateur
                              setState(() {
                                selected[3] = !selected[3];
                              });

                              if (selectedGames.contains("ow")) {
                                selectedGames.remove("ow");
                              } else {
                                selectedGames.add("ow");
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: new BoxDecoration(
                                    border: Border.all(
                                        width: 4,
                                        color: (!selected[3])
                                            ? Colors.transparent
                                            : Colors.green),
                                    borderRadius: BorderRadius.circular(24),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'assets/games/cards/ow/3.jpg',
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 35, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Overwatch',
                                          textAlign: TextAlign.center,
                                          style:
                                              FlutterFlowTheme.title1.override(
                                            fontFamily: 'Roboto',
                                            color: Colors.white,
                                            fontSize: 30,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 3.5,
                          ),
                          InkWell(
                            onTap: () async {
                              /// Ajoute ou enleve le jeu rl à la liste des jeux de l'utilisateur
                              setState(() {
                                selected[4] = !selected[4];
                              });

                              if (selectedGames.contains("rl")) {
                                selectedGames.remove("rl");
                              } else {
                                selectedGames.add("rl");
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: new BoxDecoration(
                                    border: Border.all(
                                        width: 4,
                                        color: (!selected[4])
                                            ? Colors.transparent
                                            : Colors.green),
                                    borderRadius: BorderRadius.circular(24),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'assets/games/cards/rl/3.jpg',
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 35, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Rocket league\n',
                                          textAlign: TextAlign.center,
                                          style:
                                              FlutterFlowTheme.title1.override(
                                            fontFamily: 'Roboto',
                                            color: Colors.white,
                                            fontSize: 30,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(6, 1, 0, 0),
                          child: InkWell(
                            onTap: () async {
                              /// Retourne à la page précédente
                              Navigator.pop(context);
                            },
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFF4D5078),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                width: 140,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Color(0x00EEEEEE),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                      child: Icon(
                                        Icons.arrow_back_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Text(
                                        'Back',
                                        style: FlutterFlowTheme.title2.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(70, 1, 6, 0),
                          child: InkWell(
                            onTap: () async {
                              /// Vérification et envoie vers la page [Su4PageWidget]
                              if (selected.contains(true)) {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Su4PageWidget(
                                      username: widget.username,
                                      tag: widget.tag,
                                      photoUrl: widget.photoUrl,
                                      about: widget.about,
                                      selectedGames: selectedGames,
                                    ),
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      title: Center(child: Text('Alert!')),
                                      content: Text(
                                          'You have not picked any games yet!'),
                                      actions: <Widget>[
                                        Column(
                                          children: [
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 17, 15),
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
                                                          0, 0, 24, 0),
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
                                                        /// Annule commande et retourne à page précédente
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
                              }
                            },
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFF4D5078),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                width: 140,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Color(0xFF4D5078),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                                      child: Text(
                                        'Next',
                                        style: FlutterFlowTheme.title2.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    )
                                  ],
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
            ),
          )
        ],
      ),
    );
  }
}
