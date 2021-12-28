/*
 * Copyright (c) 2021. Scarla
 */

import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:scarla/circles_page/circles_page_widget.dart';
import 'package:scarla/flutter_flow/flutter_flow_util.dart';
import 'package:scarla/login_page/login_page_widget.dart';

import 'assets/custom_icons_icons.dart';
import 'auth/firebase_user_provider.dart';
import 'friends_page/friends_page_widget.dart';
import 'group_list_page/group_list_page_widget.dart';
import 'home_page/home_page_widget.dart';
import 'login_page/login_page_widget.dart';
import 'my_profile_page/my_profile_page_widget.dart';
import 'util/transparent_route.dart';

/// Méthode principale
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ScarlaApp());
}

/// Widget principal
class ScarlaApp extends StatefulWidget {
  @override
  _ScarlaAppState createState() => _ScarlaAppState();
}

class _ScarlaAppState extends State<ScarlaApp> {
  Stream<ScarlaFirebaseUser> userStream;
  ScarlaFirebaseUser initialUser;

  @override
  void initState() {
    super.initState();
    userStream = scarlaFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scarla',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: initialUser == null
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff4b39ef)),
              ),
            )
          : currentUser.loggedIn
              ? NavBarPage()
              : LoginPageWidget(),
    );
  }
}

/// Widget pour toutes les pages contenant la barre de navigation
class NavBarPage extends StatefulWidget {
  NavBarPage({Key key, this.initialPage}) : super(key: key);

  final String initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> with TickerProviderStateMixin {
  String _currentPage = 'HomePage';
  AnimationController _animationController;
  bool isDisabled = false;
  Color selectedColor;
  final _homeIconKey = GlobalKey();
  final _chatIconKey = GlobalKey();
  final _friendsIconKey = GlobalKey();
  final _profileIconKey = GlobalKey();
  Color color = Color(0xFFFF4553);
  double posL;
  double posR;
  double posT;
  double posB;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    posL = -750;
    posR = 0;
    posT = 35;
    posB = 0;
  }

  /// Retourne le Offset de la position du widget ayant la [key]
  Offset getPosition(GlobalKey key) {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);
    return position;
  }

  /// Retourne le Size du widget ayant la [key]
  Size getSize(GlobalKey key) {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    final size = renderBox.size;
    return size;
  }

  /// Bouge le point en dessous des icône de la barre de navigation à la position [pos]
  void _moveBottomDot(String pos) {
    setState(() {
      if (pos == "Profile") {
        posL = getPosition(_profileIconKey).dx -
            (getSize(_profileIconKey).width / 2) +
            4;
        posR = 0;
        posT = 35;
        posB = 0;
      } else if (pos == "Users") {
        posL = isIos
            ? getPosition(_chatIconKey).dx + 35
            : getPosition(_friendsIconKey).dx -
                ((getSize(_friendsIconKey).width * 2) + 9);
        posR = 0;
        posT = 35;
        posB = 0;
      } else if (pos == "Home") {
        posL = -getPosition(_profileIconKey).dx +
            (getSize(_homeIconKey).width / 2) -
            6;
        posR = 0;
        posT = 35;
        posB = 0;
      } else if (pos == "Messages") {
        if (isIos) {
          posL = -getPosition(_chatIconKey).dx - 35;
          posR = 0;
        } else {
          posL = 0;
          posR = getPosition(_chatIconKey).dx +
              (getSize(_chatIconKey).width / 4) +
              16;
        }
        posT = 35;
        posB = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Map des pages ayant une barre de navigation
    final tabs = {
      'HomePage': HomePageWidget(),
      'GroupListPage': GroupListPageWidget(),
      'FriendsPage': FriendsPageWidget(),
      'MyProfilePage': MyProfilePageWidget(),
    };

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: tabs[_currentPage],
      floatingActionButton: FloatingActionButton(
        child: AnimatedIconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          animationController: _animationController,
          icons: [
            AnimatedIconItem(
              backgroundColor: Color(0xFF5B54C2),
              icon: Icon(
                CustomIcons.controller,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
              /// Ouvre la page de matchmaking
                if (!isDisabled) {
                  _animationController.addStatusListener((status) async {
                    if (status == AnimationStatus.completed) {
                      Navigator.of(context).push(
                        TransparentRoute(
                          builder: (context) => CirclesPage(),
                        ),
                      );
                      await Future.delayed(Duration(milliseconds: 200));
                      _animationController.reverse();
                      isDisabled = true;
                    }
                  });
                }
              },
            ),
            AnimatedIconItem(
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 27,
              ),
              backgroundColor: Colors.red,
            ),
          ],
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 3,
          color: Color(0xFF373856),
          child: Container(
              height: 60,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          key: _homeIconKey,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(FluentIcons.home_24_regular),
                          iconSize: 24.0,
                          color: (_currentPage == 'HomePage')
                              ? color
                              : Colors.white,
                          onPressed: () {
                            /// Change la page à Home
                            _moveBottomDot("Home");
                            setState(() => setState(
                                () => _currentPage = tabs.keys.toList()[0]));
                          },
                        ),
                        IconButton(
                          key: _chatIconKey,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(
                            FluentIcons.chat_32_regular,
                          ),
                          iconSize: 27.0,
                          color: (_currentPage == 'GroupListPage')
                              ? color
                              : Colors.white,
                          onPressed: () {
                            /// Change la page à Messages
                            _moveBottomDot("Messages");
                            setState(() => setState(
                                () => _currentPage = tabs.keys.toList()[1]));
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                          child: IconButton(
                            key: _friendsIconKey,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: Icon(FluentIcons.people_community_28_regular),
                            iconSize: 30.0,
                            color: (_currentPage == 'FriendsPage')
                                ? color
                                : Colors.white,
                            onPressed: () {
                              /// Change la page à Amis
                              setState(() => setState(
                                  () => _currentPage = tabs.keys.toList()[2]));
                              _moveBottomDot("Users");
                            },
                          ),
                        ),
                        IconButton(
                          key: _profileIconKey,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(LineIcons.userCircle),
                          iconSize: 29,
                          color: (_currentPage == 'MyProfilePage')
                              ? color
                              : Colors.white,
                          onPressed: () {
                            /// Change la page à Mon profile
                            _moveBottomDot("Profile");
                            setState(() => setState(
                                () => _currentPage = tabs.keys.toList()[3]));
                          },
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      AnimatedPositioned(
                        curve: Curves.ease,
                        left: posL,
                        right: posR,
                        top: posT,
                        bottom: posB,
                        duration: Duration(milliseconds: 220),
                        child: Center(
                          child: Container(
                            width: 6.0,
                            height: 6.0,
                            decoration: new BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ))),
    );
  }
}
