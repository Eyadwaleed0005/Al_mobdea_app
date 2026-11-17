import 'package:al_mobdea/core/helper/app_date_time_formatter.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/features/profile/domain/entities/my_subscription_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySubscriptionDetailsCard extends StatelessWidget {
  const MySubscriptionDetailsCard({super.key, required this.subscription});

  final MySubscriptionEntity subscription;

  @override
  Widget build(BuildContext context) {
    final startAt = subscription.subscriptionStartAt;
    final endAt = subscription.subscriptionEndAt;

    if (startAt == null && endAt == null) {
      return const SizedBox.shrink();
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: ColorPalette.cardBackground,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: ColorPalette.border),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'تفاصيل الاشتراك',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: AppTextStyle.font16TextPrimarySemiBoldKufam(),
            ),
            verticalSpace(22),
            if (startAt != null)
              _buildDateRow(
                label: 'بداية الاشتراك',
                date: startAt,
                icon: Icons.event_available_outlined,
              ),
            if (startAt != null && endAt != null) ...[
              verticalSpace(18),
              const Divider(height: 1, color: ColorPalette.divider),
              verticalSpace(18),
            ],
            if (endAt != null)
              _buildDateRow(
                label: 'نهاية الاشتراك',
                date: endAt,
                icon: Icons.event_outlined,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRow({
    required String label,
    required DateTime date,
    required IconData icon,
  }) {
    final formattedDate = AppDateTimeFormatter.formatDateWithSlash(
      date.toLocal(),
      useArabicDigits: false,
    );

    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Icon(icon, color: ColorPalette.primary, size: 24.sp),
        horizontalSpace(12),
        Expanded(
          child: Text(
            label,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: AppTextStyle.font13TextSecondaryRegularTajawal(),
          ),
        ),
        horizontalSpace(12),
        Flexible(
          child: Text(
            formattedDate,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.left,
            style: AppTextStyle.font15PrimaryBoldTajawal(),
          ),
        ),
      ],
    );
  }
}
