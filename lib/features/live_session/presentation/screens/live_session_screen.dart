import 'package:al_mobdea/app/dependency_injection/service_locator.dart';
import 'package:al_mobdea/core/helper/app_system_ui.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/widgets/background/background_student_layout.dart';
import 'package:al_mobdea/features/live_session/presentation/cubits/live_session_cubit/live_session_cubit.dart';
import 'package:al_mobdea/features/live_session/presentation/widgets/live_session_screen_widgets/live_session_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveSessionScreen extends StatelessWidget {
  const LiveSessionScreen({super.key, required this.gradeId});

  final String gradeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LiveSessionCubit>(
      create: (_) => getIt<LiveSessionCubit>()..getLiveSession(gradeId: gradeId),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),
        child: Scaffold(
          backgroundColor: ColorPalette.background,
          body: BackgroundStudentLayout(
            child: LiveSessionScreenContent(gradeId: gradeId),
          ),
        ),
      ),
    );
  }
}
