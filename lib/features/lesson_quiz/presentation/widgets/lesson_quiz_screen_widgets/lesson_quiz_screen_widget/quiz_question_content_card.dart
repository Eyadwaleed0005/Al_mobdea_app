import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizQuestionContentCard extends StatelessWidget {
  const QuizQuestionContentCard({
    super.key,
    required this.questionText,
    this.questionContext,
    this.questionImageUrl,
  });

  final String questionText;
  final String? questionContext;
  final String? questionImageUrl;

  bool get _hasContext => questionContext?.trim().isNotEmpty == true;

  bool get _hasImage => questionImageUrl?.trim().isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorPalette.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: ColorPalette.borderWarm.withValues(alpha: 0.6),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.cardShadow.withValues(alpha: 0.04),
            blurRadius: 16.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            questionText,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: AppTextStyle.font18TextPrimaryBoldKufam(),
          ),
          if (_hasImage) ...[
            verticalSpace(16),
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl: questionImageUrl!,
                  fit: BoxFit.fill,
                  placeholder: (context, url) {
                    return Container(color: ColorPalette.divider);
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      color: ColorPalette.divider,
                      child: Icon(
                        Icons.broken_image_outlined,
                        color: ColorPalette.textMuted,
                        size: 32.sp,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
          if (_hasContext) ...[
            verticalSpace(32),
            _buildContextHighlightBox(),
          ],
        ],
      ),
    );
  }

  Widget _buildContextHighlightBox() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 44.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: ColorPalette.goldPale,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          questionContext!,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: AppTextStyle.font16TextPrimaryBoldTajawal().copyWith(
            color: ColorPalette.primary,
            fontFamily: 'Kufam',
          ),
        ),
      ),
    );
  }
}
