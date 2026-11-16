import 'package:al_mobdea/core/widgets/app_error_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileErrorView extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const ProfileErrorView({super.key, required this.errorMessage, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: AppErrorState(message: errorMessage, onRetry: onRetry),
      ),
    );
  }
}
