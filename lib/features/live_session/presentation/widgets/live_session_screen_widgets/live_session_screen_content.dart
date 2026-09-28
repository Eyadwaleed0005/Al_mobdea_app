import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/features/live_session/presentation/cubits/live_session_cubit/live_session_cubit.dart';
import 'package:al_mobdea/features/live_session/presentation/widgets/live_session_screen_widgets/live_session_app_bar.dart';
import 'package:al_mobdea/features/live_session/presentation/widgets/live_session_screen_widgets/live_session_screen_states/live_session_empty_view.dart';
import 'package:al_mobdea/features/live_session/presentation/widgets/live_session_screen_widgets/live_session_screen_states/live_session_error_view.dart';
import 'package:al_mobdea/features/live_session/presentation/widgets/live_session_screen_widgets/live_session_screen_states/live_session_loading_view.dart';
import 'package:al_mobdea/features/live_session/presentation/widgets/live_session_screen_widgets/live_session_screen_states/live_session_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveSessionScreenContent extends StatelessWidget {
  const LiveSessionScreenContent({super.key, required this.gradeId});

  final String gradeId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(14),
        const LiveSessionAppBar(),
        Expanded(
          child: SafeArea(
            top: false,
            child: BlocBuilder<LiveSessionCubit, LiveSessionState>(
              builder: (context, state) {
                if (state is LiveSessionFailure) {
                  return LiveSessionErrorView(
                    errorMessage: state.errorMessage,
                    onRetry: () => context
                        .read<LiveSessionCubit>()
                        .getLiveSession(gradeId: gradeId),
                  );
                }

                if (state is LiveSessionEmpty) {
                  return Center(
                    child: Transform.translate(
                      offset: Offset(0, -24.h),
                      child: const LiveSessionEmptyView(),
                    ),
                  );
                }

                if (state is LiveSessionSuccess) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
                    child: LiveSessionSuccessView(
                      liveSession: state.liveSessionEntity,
                    ),
                  );
                }

                return const LiveSessionLoadingView();
              },
            ),
          ),
        ),
      ],
    );
  }
}
