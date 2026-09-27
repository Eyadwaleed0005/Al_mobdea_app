import 'dart:async';

import 'package:al_mobdea/core/connection/cubit/network_status_cubit.dart';
import 'package:al_mobdea/core/connection/cubit/network_status_state.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonVideoCard extends StatefulWidget {
  const LessonVideoCard({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<LessonVideoCard> createState() => _LessonVideoCardState();
}

class _LessonVideoCardState extends State<LessonVideoCard> {
  static const double _aspectRatio = 350 / 218;

  YoutubePlayerController? _controller;

  bool _isPlayerActive = false;
  bool _isCheckingConnection = false;
  bool _isOfflineMessageVisible = false;

  @override
  void didUpdateWidget(covariant LessonVideoCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.videoUrl != widget.videoUrl) {
      _closePlayer();
      _restorePortraitOrientation();
    }
  }

  @override
  void dispose() {
    _closePlayer();
    _restorePortraitOrientation();

    super.dispose();
  }

  Future<void> _activatePlayer() async {
    if (_isPlayerActive || _isCheckingConnection || _isOfflineMessageVisible) {
      return;
    }

    final String? videoId = _extractVideoId(widget.videoUrl);

    if (videoId == null) {
      return;
    }

    _isCheckingConnection = true;

    try {
      final bool hasInternet = await _checkInternetConnection();

      if (!mounted) {
        return;
      }

      if (!hasInternet) {
        _showOfflineSnackBar();
        return;
      }

      _createPlayer(videoId);
    } catch (_) {
      _showPlaybackError();
    } finally {
      _isCheckingConnection = false;
    }
  }

  Future<bool> _checkInternetConnection() async {
    final NetworkStatusCubit networkStatusCubit = context
        .read<NetworkStatusCubit>();

    await networkStatusCubit.checkConnection();

    if (!mounted) {
      return false;
    }

    return networkStatusCubit.state is NetworkStatusConnected;
  }

  void _createPlayer(String videoId) {
    final YoutubePlayerController controller =
        YoutubePlayerController.fromVideoId(
          videoId: videoId,
          autoPlay: true,
          params: const YoutubePlayerParams(
            interfaceLanguage: 'ar',
            captionLanguage: 'ar',
            playsInline: true,
            enableCaption: false,
            strictRelatedVideos: true,
          ),
        );

    controller.setFullScreenListener(_handleFullScreenChanged);

    if (!mounted) {
      unawaited(controller.close());
      return;
    }

    setState(() {
      _controller = controller;
      _isPlayerActive = true;
    });
  }

  void _handleFullScreenChanged(bool isFullScreen) {
    if (isFullScreen) {
      unawaited(
        SystemChrome.setPreferredOrientations(const [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]),
      );
      return;
    }

    _restorePortraitOrientation();
  }

  void _restorePortraitOrientation() {
    unawaited(
      SystemChrome.setPreferredOrientations(const [
        DeviceOrientation.portraitUp,
      ]),
    );
  }

  void _closePlayer() {
    final YoutubePlayerController? controller = _controller;

    _controller = null;
    _isPlayerActive = false;

    if (controller != null) {
      unawaited(controller.close());
    }
  }

  void _showOfflineSnackBar() {
    if (!mounted || _isOfflineMessageVisible) {
      return;
    }

    _isOfflineMessageVisible = true;

    unawaited(
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              content: Text(
                'لتشغيل الفيديو، تحقق من اتصال الإنترنت',
                style: AppTextStyle.font14TextLightSemiBoldTajawal(),
              ),
              action: SnackBarAction(
                label: 'إعادة المحاولة',
                onPressed: () {
                  _isOfflineMessageVisible = false;
                  unawaited(_activatePlayer());
                },
              ),
            ),
          )
          .closed
          .then<void>((_) {
            _isOfflineMessageVisible = false;
          }),
    );
  }

  void _showPlaybackError() {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تعذر تشغيل الفيديو، حاول مرة أخرى',
          style: AppTextStyle.font14TextLightSemiBoldTajawal(),
        ),
      ),
    );
  }

  String? _extractVideoId(String videoUrl) {
    final String normalizedUrl = videoUrl.trim();

    if (normalizedUrl.isEmpty) {
      return null;
    }

    final String? convertedVideoId = YoutubePlayerController.convertUrlToId(
      normalizedUrl,
    );

    if (convertedVideoId != null && convertedVideoId.trim().isNotEmpty) {
      return convertedVideoId.trim();
    }

    final bool isRawVideoId = RegExp(r'^[a-zA-Z0-9_-]{11}$')
        .hasMatch(normalizedUrl);

    return isRawVideoId ? normalizedUrl : null;
  }

  @override
  Widget build(BuildContext context) {
    final String? videoId = _extractVideoId(widget.videoUrl);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: AspectRatio(
        aspectRatio: _aspectRatio,
        child: _buildContent(videoId),
      ),
    );
  }

  Widget _buildContent(String? videoId) {
    if (videoId == null) {
      return _buildInvalidVideoView();
    }

    if (_isPlayerActive && _controller != null) {
      return _buildPlayer();
    }

    return _buildPreview();
  }

  Widget _buildPreview() {
    return GestureDetector(
      onTap: _activatePlayer,
      child: ColoredBox(
        color: ColorPalette.deepSurface,
        child: Center(
          child: Container(
            width: 62.w,
            height: 62.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorPalette.gold200,
            ),
            child: Icon(
              Icons.play_arrow_rounded,
              size: 38.sp,
              color: ColorPalette.wine700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayer() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: YoutubePlayer(
        controller: _controller!,
        aspectRatio: _aspectRatio,
        backgroundColor: ColorPalette.deepSurface,
        autoFullScreen: false,
        enableFullScreenOnVerticalDrag: false,
      ),
    );
  }

  Widget _buildInvalidVideoView() {
    return ColoredBox(
      color: ColorPalette.deepSurface,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.video_library_outlined,
              size: 34.sp,
              color: ColorPalette.gold200,
            ),
            verticalSpace(8),
            Text(
              'رابط الفيديو غير صالح',
              textDirection: TextDirection.rtl,
              style: AppTextStyle.font14TextLightSemiBoldTajawal(),
            ),
          ],
        ),
      ),
    );
  }
}
