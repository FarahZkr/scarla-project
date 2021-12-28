/*
 * Copyright (c) 2021. Scarla
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scarla/home_page/widgets/post_widget.dart';
import 'package:scarla/util/transparent_route.dart';
import 'package:selectable_circle/selectable_circle.dart';
import '../add_post_page/add_post_page_widget.dart';
import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';

/// Widget pour voir la page home avec tous les publications
class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<bool> isSelected = new List.filled(6, false);
  AnimationController _animationController;
  Color color1 = Color(0xff0b323e);
  Color color2 = Color(0xff010b15);
  List<String> games = ['valorant', 'lol', 'ow', 'rl', 'mw'];

  @override
  initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    isSelected[5] = true;
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.primaryColor,
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.20,
        child: Drawer(
          child: Container(
            color: Color(0xff292e5c),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20),
                SelectableCircle(
                  color: Color(0xFF5B54C2),
                  selectedColor: Color(0xFF5B54C2),
                  width: 80.0,
                  isSelected: isSelected[5],
                  borderColor: Colors.black,
                  selectedBorderColor: Colors.green,
                  selectMode: SelectMode.simple,
                  onTap: () {
                    /// Ça te montre les publications de tous les jeux
                    setState(() {
                      if (!isSelected[5]) {
                        if (!isSelected.contains(true)) {}
                        isSelected.fillRange(0, isSelected.length, false);
                        isSelected[5] = true;
                        games = ['valorant', 'lol', 'ow', 'rl', 'mw'];
                      }
                    });
                  },
                  child: Text(
                    'All',
                    style: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                SelectableCircle(
                  width: 80.0,
                  isSelected: isSelected[0],
                  borderColor: Colors.black,
                  selectedBorderColor: Colors.green,
                  color: Color(0xffff4654),
                  selectedColor: Colors.green,
                  selectMode: SelectMode.simple,
                  onTap: () {
                    /// Ça te montre seulement les publications du jeu Valorant
                    setState(() {
                      if (!isSelected[0]) {
                        if (!isSelected.contains(true)) {}
                        isSelected.fillRange(0, isSelected.length, false);
                        isSelected[0] = true;
                        games = ['valorant'];
                      }
                    });
                  },
                  child: CircleAvatar(
                    maxRadius: 28.5,
                    backgroundColor: Color(0xffff4454),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(1, 4, 0, 0),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0xffff4454),
                        image: DecorationImage(
                          image: ExactAssetImage(
                              'assets/games/icons/valorantIcon.png'
                          ),
                          scale: 120,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                SelectableCircle(
                    selectMode: SelectMode.simple,
                    selectedColor: Colors.grey[900],
                    width: 80.0,
                    color: Colors.grey[900],
                    isSelected: isSelected[1],
                    borderColor: Colors.black,
                    selectedBorderColor: Colors.green,
                    onTap: () {
                      /// Ça te montre seulement les publications du jeu Modern Warfare
                      setState(() {
                        if (!isSelected[1]) {
                          if (!isSelected.contains(true)) {}
                          isSelected.fillRange(0, isSelected.length, false);
                          isSelected[1] = true;
                          games = ['mw'];
                        }
                      });
                    },
                    child: CircleAvatar(
                      maxRadius: 28.5,
                      backgroundColor: Colors.grey[900],
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage(
                                'assets/games/icons/mwIcon.png'
                            ),
                            scale: 2.5,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    )),
                SizedBox(height: 30),
                SelectableCircle(
                    width: 80.0,
                    selectMode: SelectMode.simple,
                    color: Color(0xff0a2f39),
                    isSelected: isSelected[2],
                    borderColor: Colors.black,
                    selectedBorderColor: Colors.green,
                    onTap: () {
                      /// Ça te montre seulement les publications du jeu League of Legends
                      setState(() {
                        if (!isSelected[2]) {
                          if (!isSelected.contains(true)) {}
                          isSelected.fillRange(0, isSelected.length, false);
                          isSelected[2] = true;
                          games = ['lol'];
                        }
                      });
                    },
                    child: CircleAvatar(
                      maxRadius: 28.5,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: ExactAssetImage(
                                  'assets/games/icons/lolIcon.png'
                              ),
                              alignment: Alignment(0.2, -0.18),
                              scale: 11),
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
                SizedBox(height: 30),
                SelectableCircle(
                  color: Color(0xff004ca3),
                  width: 80.0,
                  isSelected: isSelected[3],
                  borderColor: Colors.black,
                  selectedBorderColor: Colors.green,
                  selectMode: SelectMode.simple,
                  onTap: () {
                    /// Ça te montre seulement les publications du jeu Rocket League
                    setState(() {
                      if (!isSelected[3]) {
                        if (!isSelected.contains(true)) {}
                        isSelected.fillRange(0, isSelected.length, false);
                        isSelected[3] = true;
                        games = ['rl'];
                      }
                    });
                  },
                  child: CircleAvatar(
                    maxRadius: 28.5,
                    backgroundColor: Color(0xff004ca3),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(2, 3, 0, 0),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0xff004ca3),
                        image: DecorationImage(
                          image:
                              ExactAssetImage('assets/games/icons/rlIcon.png'),
                          scale: 23,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                SelectableCircle(
                  color: Colors.grey[350],
                  width: 80.0,
                  isSelected: isSelected[4],
                  borderColor: Colors.black,
                  selectMode: SelectMode.simple,
                  selectedBorderColor: Colors.green,
                  onTap: () {
                    /// Ça te montre seulement les publications du jeu Overwatch
                    setState(() {
                      if (!isSelected[4]) {
                        if (!isSelected.contains(true)) {}
                        isSelected.fillRange(0, isSelected.length, false);
                        isSelected[4] = true;
                        games = ['ow'];
                      }
                    });
                  },
                  child: CircleAvatar(
                    radius: 28,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        image: DecorationImage(
                          image:
                              ExactAssetImage('assets/games/icons/owIcon.png'),
                          scale: 26,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 0, 7),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: FlutterFlowTheme.tertiaryColor,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: InkWell(
                      onTap: () async {
                        /// Envoie vers la page de [AddPostPageWidget] pour faire une publication
                        await Navigator.push(
                          context,
                          TransparentRoute(
                            builder: (context) => AddPostPageWidget(
                              userRef: currentUserReference,
                              initValue: '',
                              initImage: '',
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 2, 8, 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 2, 0),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            Text(
                              'Make a post',
                              style: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Poppins',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child:
                  /// Fait la requête des fils d'actualité du jeu demandé
                  StreamBuilder<List<FeedRecord>>(
                    stream: queryFeedRecord(
                      queryBuilder: (feedRecord) => feedRecord
                          .orderBy('timestamp', descending: true)
                          .where('game', whereIn: games),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      List<FeedRecord> listViewFeedRecordList = snapshot.data;
                      // Customize what your widget looks like with no query results.
                      if (listViewFeedRecordList.isEmpty) {
                        return Center(
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://i.pinimg.com/originals/65/ba/48/65ba488626025cff82f091336fbf94bb.gif',
                            width: 200,
                            height: 200,
                          ),
                        );
                      }
                      return ListView.builder(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewFeedRecordList.length,
                        itemBuilder: (context, listViewIndex) {
                          final listViewFeedRecord =
                              listViewFeedRecordList[listViewIndex];
                          final isLastPost = (listViewIndex ==
                              listViewFeedRecordList.length - 1);
                          return PostWidget(
                            isLastPost: isLastPost,
                            postRecord: listViewFeedRecord,
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
