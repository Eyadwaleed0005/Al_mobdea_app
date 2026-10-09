import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/profile_loading_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileLoadingView extends StatelessWidget {
  const ProfileLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [verticalSpace(24), const ProfileLoadingSkeleton(), verticalSpace(20)],
      ),
    );
  }
}
