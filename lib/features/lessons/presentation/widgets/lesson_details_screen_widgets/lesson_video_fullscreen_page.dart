import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'lesson_video_controls.dart';

class LessonVideoFullscreenPage extends StatefulWidget {
  const LessonVideoFullscreenPage({super.key, required this.videoId});

  final String videoId;

  @override
  State<LessonVideoFullscreenPage> createState() {
    return _LessonVideoFullscreenPageState();
  }
}

class _LessonVideoFullscreenPageState extends State<LessonVideoFullscreenPage> {
  late final YoutubePlayerController _controller;

  bool _isClosing = false;

  @override
  void initState() {
    super.initState();

    unawaited(
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky),
    );

    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(
        interfaceLanguage: 'ar',
        captionLanguage: 'ar',
        playsInline: true,
        enableCaption: false,
        strictRelatedVideos: true,
        showControls: false,
        showFullscreenButton: false,
        pointerEvents: PointerEvents.none,
      ),
    );
  }

  @override
  void dispose() {
    unawaited(_controller.close());

    unawaited(SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge));

    super.dispose();
  }

  void _closeVideo() {
    if (_isClosing) {
      return;
    }

    _isClosing = true;

    Navigator.of(context).pop();
  }

  Future<void> _pauseOnExit() async {
    try {
      await _controller.pauseVideo();
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<void>(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _isClosing = true;
          unawaited(_pauseOnExit());
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox.expand(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: YoutubePlayer(
                  controller: _controller,
                  aspectRatio: constraints.maxWidth / constraints.maxHeight,
                  backgroundColor: Colors.black,
                  autoFullScreen: false,
                  enableFullScreenOnVerticalDrag: false,
                  controlsBuilder: (context, isFullscreen) {
                    return SafeArea(
                      child: LessonVideoControls(
                        key: ObjectKey(_controller),
                        controller: _controller,
                        onClose: _closeVideo,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
