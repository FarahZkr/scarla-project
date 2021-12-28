/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scarla/rank_page/rank_page_widget.dart';
import 'package:scarla/util/transparent_route.dart';

/// Widget des jeux d'un utilisateur
class GamesListProfileWidget extends StatelessWidget {
  const GamesListProfileWidget(
      {Key key, this.selectedGames, this.userName, this.userRef})
      : super(key: key);
  final List<String> selectedGames;
  final String userName;
  final DocumentReference userRef;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(selectedGames.length, (gameIndex) {
        final game = selectedGames[gameIndex];
        return Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: InkWell(
            onTap: () async {
              /// Envoie vers la page [RankPageWidget]
              await Navigator.push(
                context,
                TransparentRoute(
                  builder: (context) => RankPageWidget(
                    username: userName,
                    game: game,
                    userRef: userRef,
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                if (game == "valorant")
                  Container(
                    width: 30,
                    height: 30,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffff4454),
                        border: Border.all(color: Colors.black)),
                    child: Image.asset(
                      'assets/games/icons/valorantIcon.png',
                      scale: 250,
                    ),
                  ),
                if (game == "mw")
                  Container(
                    width: 30,
                    height: 30,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black)),
                    child: Image.asset(
                      'assets/games/icons/mwIcon.png',
                      scale: 2.7,
                    ),
                  ),
                if (game == "lol")
                  Container(
                    width: 30,
                    height: 30,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff0b323e),
                          Color(0xff010b15),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.9, bottom: 1),
                      child: Image.asset(
                        'assets/games/icons/lolIcon.png',
                        scale: 21,
                      ),
                    ),
                  ),
                if (game == "ow")
                  Container(
                    width: 30,
                    height: 30,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: Image.asset(
                      'assets/games/icons/owIcon.png',
                      scale: 50,
                    ),
                  ),
                if (game == "rl")
                  Container(
                    width: 30,
                    height: 30,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black),
                      color: Color(0xff004ca3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2, top: 1),
                      child: Image.asset(
                        'assets/games/icons/rlIcon.png',
                        scale: 27,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
