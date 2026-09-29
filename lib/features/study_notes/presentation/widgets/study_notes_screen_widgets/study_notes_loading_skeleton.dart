import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudyNotesLoadingSkeleton extends StatelessWidget {
  const StudyNotesLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 112.h),
      itemCount: 4,
      separatorBuilder: (_, _) => verticalSpace(14),
      itemBuilder: (_, _) {
        return Container(
          height: 96.h,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: ColorPalette.surface,
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(color: ColorPalette.border, width: 1.w),
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                width: 62.w,
                height: 62.h,
                decoration: BoxDecoration(
                  color: ColorPalette.primarySoftBackground,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              horizontalSpace(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150.w,
                      height: 14.h,
                      decoration: BoxDecoration(
                        color: ColorPalette.borderWarm.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    verticalSpace(10),
                    Container(
                      width: 120.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: ColorPalette.borderWarm.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ],
                ),
              ),
              horizontalSpace(14),
              Container(
                width: 54.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: ColorPalette.primarySoftBackground,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
