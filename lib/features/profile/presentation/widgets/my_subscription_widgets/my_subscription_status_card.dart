import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySubscriptionStatusCard extends StatelessWidget {
  const MySubscriptionStatusCard({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ColorPalette.primary,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 26.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              textDirection: TextDirection.rtl,
              children: [
                SizedBox(
                  width: 48.r,
                  height: 48.r,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: ColorPalette.wine600,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Icon(
                      Icons.card_membership_outlined,
                      color: ColorPalette.gold200,
                      size: 28.sp,
                    ),
                  ),
                ),
                horizontalSpace(12),
                Expanded(
                  child: Text(
                    'اشتراكك على المبدع',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: AppTextStyle.font15TextLightSemiBoldKufam(),
                  ),
                ),
              ],
            ),
            verticalSpace(26),
            Align(
              alignment: Alignment.centerRight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: isActive ? ColorPalette.gold100 : ColorPalette.wine600,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 7.h,
                  ),
                  child: Text(
                    isActive ? 'اشتراك نشط' : 'اشتراك غير نشط',
                    textDirection: TextDirection.rtl,
                    style: AppTextStyle.font12TextPrimaryBoldTajawal().copyWith(
                      color: isActive
                          ? ColorPalette.primary
                          : ColorPalette.cream50,
                    ),
                  ),
                ),
              ),
            ),
            verticalSpace(16),
            Text(
              isActive ? 'محتوى اشتراكك متاح ليك' : 'تابع تعلّمك مع المبدع',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: AppTextStyle.font20TextLightBoldKufam().copyWith(
                height: 1.6,
              ),
            ),
            verticalSpace(10),
            Text(
              isActive
                  ? 'تقدر تتابع الدروس والمذكرات المتاحة ضمن اشتراكك في صفّك الدراسي.'
                  : 'مفيش اشتراك نشط لحسابك حاليًا. تقدر تتابع المحتوى المجاني المتاح لصفّك الدراسي.',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: AppTextStyle.font14CreamRegularTajawal().copyWith(
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
