/*
 * Copyright (c) 2021. Scarla
 */

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:scarla/chat_page/widgets/scarla_video_controls.dart';
import 'package:scarla/flutter_flow/flutter_flow_theme.dart';
import 'package:video_player/video_player.dart';

/// Widget pour les vidéos
class ScarlaVideoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final Color color;

  const ScarlaVideoPlayer(
      {Key key, @required this.videoPlayerController, this.looping, this.color})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<ScarlaVideoPlayer> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    widget.videoPlayerController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        looping: widget.looping,
        allowPlaybackSpeedChanging: false,
        showControlsOnInitialize: false,
        autoInitialize: true,
        customControls: ScarlaVidControls(),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.videoPlayerController.value.isInitialized ||
        _chewieController != null) {
      final vidControl = _chewieController.videoPlayerController;
      double h = vidControl.value.size.height;
      double w = vidControl.value.size.width;
      double div = w / h;
      double finalHeight = 300 / div;

      return Material(
        child: Container(
          constraints: BoxConstraints(maxHeight: 400),
          height: finalHeight,
          decoration: BoxDecoration(
            color: widget.color,
          ),
          child: Chewie(
            controller: _chewieController,
          ),
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        clipBehavior: Clip.hardEdge,
      );
    } else {
      return Material(
        child: Container(
          constraints: BoxConstraints(maxHeight: 400),
          height: 100,
          width: 300,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.secondaryColor,
          ),
          child: Center(child: CircularProgressIndicator()),
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        clipBehavior: Clip.hardEdge,
      );
    }
  }

  @override
  void dispose() {
    if (_chewieController.isPlaying) {
      _chewieController.pause();
      widget.videoPlayerController.pause();
    }
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
