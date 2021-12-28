/*
 * Copyright (c) 2021. Scarla
 */

import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:scarla/assets/custom_icons_icons.dart';
import 'package:scarla/auth/auth_util.dart';
import 'package:scarla/backend/backend.dart';
import 'package:selectable_circle/selectable_circle.dart';

import '../matches_page/matches_page_widget.dart';

/// Widget de la page de matchmaking
class CirclesPage extends StatefulWidget {
  @override
  _CirclesPageState createState() => _CirclesPageState();
}

class _CirclesPageState extends State<CirclesPage>
    with TickerProviderStateMixin {
  List<bool> isSelected = new List.filled(5, false);

  bool isSelected2 = false;
  AnimationController _animationController;
  bool checkSelect = true;
  Icon icon = Icon(
    CustomIcons.controller,
    color: Colors.white,
    size: 25,
  );
  Color color = Color(0xFF5B54C2);
  AnimationController controller;
  bool isPlaying = false;
  List<String> selectedGames;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _animationController
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reset();
        }
      });

    queryUsersRecord(
      queryBuilder: (usersRecord) =>
          usersRecord.where('uid', isEqualTo: currentUserUid),
    ).first.then((value) {
      selectedGames = value.first.selectedGames.toList();
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String game;
  List<bool> competitive;
  bool noSelected = false;
  bool anySelected = true;
  bool yesSelected = false;
  Color color1 = Color(0xff0b323e);
  Color color2 = Color(0xff010b15);

  @override
  Widget build(BuildContext context) {
    if (selectedGames == null) {
      return Container();
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xBA000000),
      body: SafeArea(
        child: checkSelect
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 140, 40, 0),
                    child: Wrap(
                      spacing: 25,
                         runSpacing: 25,
                         alignment: WrapAlignment.center,
                        children: <Widget>[
                          if (selectedGames.contains('valorant'))
                            SelectableCircle(
                              width: 80.0,
                              isSelected: isSelected[0],
                              borderColor: Colors.black,
                              selectedBorderColor: Colors.green,
                              color: Color(0xffff4654),
                              onTap: () {
                                /// Sélectionne le jeu
                                setState(() {
                                  if (!isSelected[0]) {
                                    if (!isSelected.contains(true)) {
                                      _animationController.forward();
                                    }
                                    isSelected.fillRange(
                                        0, isSelected.length, false);
                                    isSelected[0] = true;
                                    game = "valorant";
                                    if (isSelected[0]) {
                                      icon = Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      );
                                      color = Colors.green;
                                    }
                                  } else {
                                    _animationController.forward();
                                    isSelected.fillRange(
                                        0, isSelected.length, false);

                                    icon = Icon(
                                      CustomIcons.controller,
                                      color: Colors.white,
                                      size: 25,
                                    );
                                    color = Color(0xFF5B54C2);
                                  }
                                });
                              },
                              child: CircleAvatar(
                                maxRadius: 29.5,
                                backgroundColor: Color(0xffff4454),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(1, 4, 0, 0),
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Color(0xffff4454),
                                    image: DecorationImage(
                                      image: ExactAssetImage(
                                          'assets/games/icons/valorantIcon.png'),
                                      scale: 120,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          if (selectedGames.contains('mw'))
                            SelectableCircle(
                                selectedColor: Colors.black,
                                width: 80.0,
                                color: Colors.grey[900],
                                isSelected: isSelected[1],
                                borderColor: Colors.black,
                                selectedBorderColor: Colors.green,
                                onTap: () {
                                  /// Sélectionne le jeu
                                  setState(() {
                                    if (!isSelected[1]) {
                                      if (!isSelected.contains(true)) {
                                        _animationController.forward();
                                      }
                                      isSelected.fillRange(
                                          0, isSelected.length, false);
                                      isSelected[1] = true;
                                      game = "mw";
                                      if (isSelected[1]) {
                                        icon = Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        );
                                        color = Colors.green;
                                      }
                                    } else {
                                      _animationController.forward();

                                      isSelected.fillRange(
                                          0, isSelected.length, false);

                                      icon = Icon(
                                        CustomIcons.controller,
                                        color: Colors.white,
                                        size: 25,
                                      );
                                      color = Color(0xFF5B54C2);
                                    }
                                  });
                                },
                                child: CircleAvatar(
                                  maxRadius: 30,
                                  backgroundColor: Colors.grey[900],
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: ExactAssetImage(
                                            'assets/games/icons/mwIcon.png'),
                                        scale: 2.3,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )),
                          if (selectedGames.contains('lol'))
                            SelectableCircle(
                                width: 80.0,
                                color: Color(0xff0a2f39),
                                isSelected: isSelected[2],
                                borderColor: Colors.black,
                                selectedBorderColor: Colors.green,
                                onTap: () {
                                  setState(() {
                                    /// Sélectionne le jeu
                                    if (!isSelected[2]) {
                                      if (!isSelected.contains(true)) {
                                        _animationController.forward();
                                      }
                                      isSelected.fillRange(
                                          0, isSelected.length, false);
                                      isSelected[2] = true;
                                      game = "lol";
                                      if (isSelected[2]) {
                                        icon = Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        );
                                        color = Colors.green;
                                      }
                                    } else {
                                      _animationController.forward();

                                      isSelected.fillRange(
                                          0, isSelected.length, false);

                                      icon = Icon(
                                        CustomIcons.controller,
                                        color: Colors.white,
                                        size: 25,
                                      );
                                      color = Color(0xFF5B54C2);
                                    }
                                  });
                                },
                                child: CircleAvatar(
                                  maxRadius: 30,
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: ExactAssetImage(
                                              'assets/games/icons/lolIcon.png'),
                                          scale: 10),
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          color1,
                                          color2,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                )),
                          if (selectedGames.contains('rl'))
                            SelectableCircle(
                              color: Color(0xff004ca3),
                              width: 80.0,
                              isSelected: isSelected[3],
                              borderColor: Colors.black,
                              selectedBorderColor: Colors.green,
                              onTap: () {
                                /// Sélectionne le jeu
                                setState(() {
                                  if (!isSelected[3]) {
                                    if (!isSelected.contains(true)) {
                                      _animationController.forward();
                                    }
                                    isSelected.fillRange(
                                        0, isSelected.length, false);
                                    isSelected[3] = true;
                                    game = "rl";
                                    if (isSelected[3]) {
                                      icon = Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      );
                                      color = Colors.green;
                                    }
                                  } else {
                                    _animationController.forward();
                                    isSelected.fillRange(
                                        0, isSelected.length, false);

                                    icon = Icon(
                                      CustomIcons.controller,
                                      color: Colors.white,
                                      size: 25,
                                    );
                                    color = Color(0xFF5B54C2);
                                  }
                                });
                              },
                              child: CircleAvatar(
                                maxRadius: 30,
                                backgroundColor: Color(0xff004ca3),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(2, 3, 0, 0),
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Color(0xff004ca3),
                                    image: DecorationImage(
                                      image: ExactAssetImage(
                                          'assets/games/icons/rlIcon.png'),
                                      scale: 23,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          if (selectedGames.contains('ow'))
                            SelectableCircle(
                              color: Colors.grey[350],
                              width: 80.0,
                              isSelected: isSelected[4],
                              borderColor: Colors.black,
                              selectedBorderColor: Colors.green,
                              onTap: () {
                                /// Sélectionne le jeu
                                setState(() {
                                  if (!isSelected[4]) {
                                    if (!isSelected.contains(true)) {
                                      _animationController.forward();
                                    }
                                    isSelected.fillRange(
                                        0, isSelected.length, false);
                                    isSelected[4] = true;
                                    game = "ow";
                                    if (isSelected[4]) {
                                      icon = Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      );
                                      color = Colors.green;
                                    }
                                  } else {
                                    _animationController.forward();

                                    isSelected.fillRange(
                                        0, isSelected.length, false);

                                    icon = Icon(
                                      CustomIcons.controller,
                                      color: Colors.white,
                                      size: 25,
                                    );
                                    color = Color(0xFF5B54C2);
                                  }
                                });
                              },
                              child: CircleAvatar(
                                radius: 30,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    image: DecorationImage(
                                      image: ExactAssetImage(
                                          'assets/games/icons/owIcon.png'),
                                      scale: 25,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                             )
                        ]),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                    child: Text(
                      'Type of players',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  //Text('Type'),
                  SizedBox(
                    height: 45,
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(37, 0, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Any',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: (anySelected)
                                      ? Color(0xFFff4553)
                                      : Colors.blue,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                )),
                            width: 23,
                            height: 23,
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.transparent,
                              ),
                              child: Checkbox(
                                activeColor: Colors.transparent,
                                checkColor: Color(0xFFff4553),
                                splashRadius: 2,
                                value: anySelected,
                                tristate: false,
                                onChanged: (bool isChecked) {
                                  /// Sélectionne le type de joueur Any
                                  setState(() {
                                    anySelected = !anySelected;
                                    noSelected = false;
                                    yesSelected = false;
                                    if (anySelected == true) {
                                      yesSelected = false;
                                      anySelected = true;
                                      noSelected = false;
                                    } else {
                                      noSelected = false;
                                      anySelected = !anySelected;
                                      yesSelected = false;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Casual',
                        style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: (noSelected)
                                      ? Color(0xFFff4553)
                                      : Colors.blue,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                )),
                            width: 23,
                            height: 23,
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.transparent,
                              ),
                              child: Checkbox(
                                activeColor: Colors.transparent,
                                checkColor: Color(0xFFff4553),
                                splashRadius: 2,
                                value: noSelected,
                                tristate: false,
                                onChanged: (bool isChecked) {
                                  /// Sélectionne le type de joueur No
                                  setState(() {
                                    if (noSelected == true) {
                                      yesSelected = false;
                                      anySelected = false;
                                      noSelected = true;
                                    } else {
                                      noSelected = isChecked;
                                      anySelected = false;
                                      yesSelected = false;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Competitive',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: (yesSelected)
                                      ? Color(0xFFff4553)
                                      : Colors.blue,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                )),
                            width: 23,
                            height: 23,
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.transparent,
                              ),
                              child: Checkbox(
                                activeColor: Colors.transparent,
                                checkColor: Color(0xFFff4553),
                                splashRadius: 2,
                                value: yesSelected,
                                tristate: false,
                                onChanged: (bool isChecked) {
                                  /// Sélectionne le type de joueur Yes
                                  setState(() {
                                    if (yesSelected == true) {
                                      yesSelected = true;
                                      anySelected = false;
                                      noSelected = false;
                                    } else {
                                      yesSelected = isChecked;
                                      anySelected = false;
                                      noSelected = false;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            : Scaffold(
                backgroundColor: Color(0xBA000000),
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 130),
                  child: Center(
                    child: Lottie.network(
                        'https://assets1.lottiefiles.com/datafiles/ApBHGLbGk8W9yS0/data.json',
                        width: 200,
                        height: 200,
                        fit: BoxFit.scaleDown,
                        controller: controller, onLoaded: (composition) {
                      controller
                        ..duration = composition.duration
                        ..forward();

                      controller.addStatusListener((status) async {
                        if (status == AnimationStatus.completed) {
                          if (anySelected) {
                            competitive = [false, true];
                          } else if (yesSelected) {
                            competitive = [true];
                          } else if (noSelected) {
                            competitive = [false];
                          }
                          /// Envoie vers la page avec les joueurs trouvés
                          await Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MatchesPageWidget(
                                game: game,
                                competitive: competitive,
                              ),
                            ),
                          );
                        }
                      });
                    }),
                  ),
                ),
                floatingActionButton: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: FloatingActionButton(
                    backgroundColor: Color(0xFF5B54C2),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LoadingIndicator(
                        indicatorType: Indicator.circleStrokeSpin,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
              ),
      ),
      floatingActionButton: checkSelect
          ? Padding(
              padding: const EdgeInsets.all(32.0),
              child: FloatingActionButton(
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                child: AnimatedIconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  animationController: _animationController,
                  icons: [
                    AnimatedIconItem(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 27,
                      ),
                      backgroundColor: Colors.red,
                      onPressed: () {
                        /// Quitte la page de matchmaking
                        _animationController.addStatusListener((status) async {
                          if (status == AnimationStatus.completed) {
                            Navigator.of(context).pop();
                          }
                        });
                      },
                    ),
                    AnimatedIconItem(
                        backgroundColor: color,
                        icon: icon,
                        onPressed: () {
                          /// Changement de l'affichage si la page de matchmaking est présente
                          setState(() {
                            checkSelect = !checkSelect;
                          });
                        }),
                  ],
                ),
                onPressed: () {},
              ))
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
