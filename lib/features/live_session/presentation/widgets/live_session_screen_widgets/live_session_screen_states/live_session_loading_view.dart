import 'package:al_mobdea/features/live_session/presentation/widgets/live_session_screen_widgets/live_session_loading_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveSessionLoadingView extends StatelessWidget {
  const LiveSessionLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: const LiveSessionLoadingSkeleton(),
      ),
    );
  }
}
