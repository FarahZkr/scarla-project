/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';

/// Widget du dialogue pour modifier des paramètre pour un jeu
class EditGamePageWidget extends StatefulWidget {
  EditGamePageWidget({Key key, this.game, this.user}) : super(key: key);

  final String game;
  final DocumentReference user;

  @override
  _EditGamePageWidgetState createState() => _EditGamePageWidgetState();
}

class _EditGamePageWidgetState extends State<EditGamePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double sliderValue;
  double max;
  final min = 1;
  List<GamesRanksRecord> editGamePageGamesRanksRecordList;
  GamesRanksRecord editGamePageGamesRanksRecord;
  int lol;
  int valorant;
  int ow;
  int rl;

  @override
  void initState() {
    super.initState();
    queryGamesRanksRecord(
      queryBuilder: (gamesRanksRecord) =>
          gamesRanksRecord.where('userRef', isEqualTo: widget.user),
      singleRecord: true,
    ).first.then((value) async {
      setState(() {
        editGamePageGamesRanksRecordList = value;
      });
      if (editGamePageGamesRanksRecordList.isEmpty) {
        final gamesRankRecord = createGamesRanksRecordData(
          userRef: currentUserReference,
          lol: 1,
          valorant: 1,
          mw: 1,
          ow: 1,
          rl: 1,
        );
        await GamesRanksRecord.collection
            .doc(currentUserUid)
            .set(gamesRankRecord);
      }
      if (editGamePageGamesRanksRecordList != null) {
        editGamePageGamesRanksRecord = editGamePageGamesRanksRecordList.first;
        lol = editGamePageGamesRanksRecord.lol;
        valorant = editGamePageGamesRanksRecord.valorant;
        ow = editGamePageGamesRanksRecord.ow;
        rl = editGamePageGamesRanksRecord.rl;
      }

      switch (widget.game) {
        case 'lol':
          sliderValue = lol.toDouble();
          max = 37;
          break;
        case 'valorant':
          sliderValue = valorant.toDouble();
          max = 21;
          break;
        case 'ow':
          sliderValue = ow.toDouble();
          max = 9;
          break;
        case 'rl':
          sliderValue = rl.toDouble();
          max = 23;
          break;
        default:
          sliderValue = 1;
          max = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (editGamePageGamesRanksRecordList == null) {
      return Container();
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
                              widget.game,
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                            )
                          ],
                        ),
                      ),
                      Slider(
                        value: sliderValue,
                        onChanged: (value) {
                          /// Change la valeur de rang du jeu à modifier
                          setState(() {
                            sliderValue = value;
                          });
                          switch (widget.game) {
                            case 'lol':
                              lol = sliderValue.toInt();
                              break;
                            case 'valorant':
                              valorant = sliderValue.toInt();
                              break;
                            case 'ow':
                              ow = sliderValue.toInt();
                              break;
                            case 'rl':
                              rl = sliderValue.toInt();
                              break;
                            default:
                              sliderValue = 1;
                          }
                        },
                        divisions: (max <= 1) ? 1 : (max - 1).toInt(),
                        min: 1,
                        max: max,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                        child: Image.asset(
                          'assets/games/ranks/${widget.game}/${sliderValue.toInt()}.png',
                          width: MediaQuery.of(context).size.width,
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
                              /// Ferme le dialogue
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: Color(0xFF444771),
                              size: 20,
                            ),
                            iconSize: 20,
                          ),
                          IconButton(
                            onPressed: () async {
                              /// Confirme le rang choisi etle sauvegarde dans la base de données
                              final gamesRanksRecordData =
                                  createGamesRanksRecordData(
                                lol: lol,
                                valorant: valorant,
                                ow: ow,
                                rl: rl,
                              );

                              await editGamePageGamesRanksRecord.reference
                                  .update(gamesRanksRecordData);
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.check_circle_outlined,
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
  }
}
