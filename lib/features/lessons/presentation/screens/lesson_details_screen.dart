import 'package:al_mobdea/core/connection/cubit/network_status_cubit.dart';
import 'package:al_mobdea/core/helper/app_system_ui.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/features/lessons/domain/entities/lesson_entity.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_details_screen_widgets/lesson_details_content_screen.dart';
import 'package:al_mobdea/features/security_screens/presentation/cubit/secure_screen_cubit.dart';
import 'package:al_mobdea/features/security_screens/presentation/widgets/secure_screen_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/dependency_injection/service_locator.dart';

class LessonDetailsScreen extends StatelessWidget {
  const LessonDetailsScreen({super.key, required this.lesson});

  final LessonEntity lesson;

  @override
  Widget build(BuildContext context) {
    return SecureScreenScope(
      cubit: getIt<SecureScreenCubit>(),
      child: BlocProvider<NetworkStatusCubit>(
        create: (_) {
          return getIt<NetworkStatusCubit>()..startMonitoring();
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: AppSystemUi.dark(),
          child: Scaffold(
            backgroundColor: ColorPalette.background,
            body: LessonDetailsContentScreen(lesson: lesson),
          ),
        ),
      ),
    );
  }
}
