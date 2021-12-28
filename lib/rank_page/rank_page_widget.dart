/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';

/// Widget pour montrer le rank de chaque utilisateur
class RankPageWidget extends StatefulWidget {
  RankPageWidget({Key key, this.username, this.game, this.userRef})
      : super(key: key);

  final String username;
  final String game;
  final DocumentReference userRef;

  @override
  _RankPageWidgetState createState() => _RankPageWidgetState();
}

class _RankPageWidgetState extends State<RankPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    /// Fait la requête du rang des jeux de l'utilisateur spécifié
    return StreamBuilder<List<GamesRanksRecord>>(
      stream: queryGamesRanksRecord(
        queryBuilder: (gamesRanksRecord) =>
            gamesRanksRecord.where('userRef', isEqualTo: widget.userRef),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        List<GamesRanksRecord> rankPageGamesRanksRecordList = snapshot.data;
        int rank;
        if (snapshot.data.isEmpty) {
          rank = 1;
        } else {
          final rankPageGamesRanksRecord = rankPageGamesRanksRecordList.first;
          switch (widget.game) {
            case 'valorant':
              rank = rankPageGamesRanksRecord.valorant;
              break;
            case 'lol':
              rank = rankPageGamesRanksRecord.lol;
              break;
            case 'ow':
              rank = rankPageGamesRanksRecord.ow;
              break;
            case 'rl':
              rank = rankPageGamesRanksRecord.rl;
              break;
            default:
              rank = 1;
          }
        }
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0x7A000000),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment(0, 0),
                  children: [
                    InkWell(
                      onTap: () async {
                        /// Retourne à la page précédente
                        Navigator.pop(context);
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 1,
                        decoration: BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: FlutterFlowTheme.tertiaryColor,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.username,
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Text(
                                  '-',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Text(
                                  widget.game,
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Color(0x00EEEEEE),
                            ),
                            child: Image.asset(
                              'assets/games/ranks/${widget.game}/$rank.png',
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 1,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  /// Retourne à la page précédente
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  color: Color(0xFF444771),
                                  size: 20,
                                ),
                                iconSize: 20,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
