import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonPreviewCard extends StatelessWidget {
  const LessonPreviewCard({
    super.key,
    required this.lessonId,
    required this.title,
    required this.subtitle,
    required this.youtubeUrl,
    required this.isFree,
    required this.hasValidSubscription,
    required this.onTap,
  });

  final String lessonId;
  final String title;
  final String subtitle;
  final String youtubeUrl;
  final bool isFree;
  final bool? hasValidSubscription;
  final VoidCallback onTap;

  bool get _isLocked => !isFree && hasValidSubscription == false;

  String get _accessLabel {
    if (isFree) {
      return 'مجاني';
    }

    if (hasValidSubscription == true) {
      return 'متاح باشتراكك';
    }

    if (hasValidSubscription == false) {
      return 'يتطلب اشتراكًا نشطًا';
    }

    return 'محتوى للمشتركين';
  }

  String? get _thumbnailUrl {
    final uri = Uri.tryParse(youtubeUrl.trim());

    if (uri == null) {
      return null;
    }

    final host = uri.host.toLowerCase();
    final segments = uri.pathSegments;

    String? videoId;

    if (host == 'youtu.be' || host == 'www.youtu.be') {
      if (segments.isNotEmpty) {
        videoId = segments.first;
      }
    } else if (host == 'youtube.com' ||
        host.endsWith('.youtube.com') ||
        host == 'youtube-nocookie.com' ||
        host.endsWith('.youtube-nocookie.com')) {
      videoId = uri.queryParameters['v'];

      if (videoId == null &&
          segments.length >= 2 &&
          const ['embed', 'shorts', 'live'].contains(segments.first)) {
        videoId = segments[1];
      }
    }

    if (videoId == null || !RegExp(r'^[a-zA-Z0-9_-]{11}$').hasMatch(videoId)) {
      return null;
    }

    return 'https://i.ytimg.com/vi/$videoId/hqdefault.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(22.r);
    final thumbnailUrl = _thumbnailUrl;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: ColorPalette.cardShadow.withValues(alpha: 0.13),
            blurRadius: 14.r,
            offset: Offset(0, 7.h),
          ),
        ],
      ),
      child: Material(
        color: ColorPalette.primary,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'lesson-thumbnail-$lessonId',
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (thumbnailUrl != null)
                        Image.network(
                          thumbnailUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) {
                              return child;
                            }

                            return const ColoredBox(
                              color: ColorPalette.cream200,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: ColorPalette.primary,
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return _buildPlaceholder();
                          },
                        )
                      else
                        _buildPlaceholder(),
                      if (_isLocked)
                        ColoredBox(
                          color: ColorPalette.deepSurface.withValues(
                            alpha: 0.30,
                          ),
                        ),
                      if (thumbnailUrl != null || _isLocked)
                        Center(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: ColorPalette.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: ColorPalette.cream200),
                            ),
                            child: SizedBox(
                              width: 48.r,
                              height: 48.r,
                              child: Icon(
                                _isLocked
                                    ? Icons.lock_outline_rounded
                                    : Icons.play_arrow_rounded,
                                color: ColorPalette.textLight,
                                size: _isLocked ? 25.sp : 32.sp,
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.font15TextLightSemiBoldKufam()
                          .copyWith(height: 1.6),
                    ),
                    if (subtitle.trim().isNotEmpty) ...[
                      verticalSpace(8),
                      Text(
                        subtitle.trim(),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.font14CreamRegularTajawal()
                            .copyWith(height: 1.5),
                      ),
                    ],
                    verticalSpace(16),
                    _buildAccessStatus(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccessStatus() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _isLocked ? ColorPalette.gold100 : ColorPalette.wine600,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLocked) ...[
              Icon(
                Icons.lock_outline_rounded,
                size: 18.sp,
                color: ColorPalette.primary,
              ),
              horizontalSpace(8),
            ],
            Flexible(
              child: Text(
                _accessLabel,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: AppTextStyle.font14TextPrimaryBoldTajawal().copyWith(
                  color: _isLocked
                      ? ColorPalette.primary
                      : ColorPalette.cream50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return ColoredBox(
      color: ColorPalette.cream200,
      child: Center(
        child: Icon(
          Icons.video_library_outlined,
          size: 44.sp,
          color: ColorPalette.primary,
        ),
      ),
    );
  }
}
