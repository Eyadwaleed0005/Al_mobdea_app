import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/widgets/background/background_student_layout.dart';
import 'package:al_mobdea/core/widgets/custom_app_bar.dart';
import 'package:al_mobdea/core/widgets/custom_search_bar.dart';
import 'package:al_mobdea/features/lessons/presentation/cubit/lessons_cubit.dart';
import 'package:al_mobdea/features/lessons/presentation/cubit/lessons_state.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_screen_widgets/lessons_screen_states/lessons_empty_view.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_screen_widgets/lessons_screen_states/lessons_error_view.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_screen_widgets/lessons_screen_states/lessons_loading_view.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_screen_widgets/lessons_screen_states/lessons_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonsScreenContent extends StatelessWidget {
  const LessonsScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundStudentLayout(
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              verticalSpace(12),
              CustomAppBar(
                title: 'الدروس',
                titleColor: ColorPalette.surface,
                titleBackgroundColor: ColorPalette.primary,
                backgroundColor: Colors.transparent,
                showBackButton: false,
                toolbarHeight: 48.h,
              ),
              Expanded(
                child: BlocBuilder<LessonsCubit, LessonsState>(
                  builder: (context, state) {
                    final cubit = context.read<LessonsCubit>();

                    if (state is LessonsInitial || state is LessonsLoading) {
                      return _buildLoadingView();
                    }

                    if (state is LessonsFailure) {
                      return LessonsErrorView(
                        errorMessage: state.error.message,
                        onRetry: cubit.retry,
                      );
                    }

                    if (state is LessonsEmpty) {
                      return const LessonsEmptyView();
                    }

                    if (state is LessonsDataSuccess) {
                      return LessonsSuccessView(
                        lessons: state.lessons,
                        query: state.query,
                        hasNoResults: state.hasNoResults,
                        onSearchChanged: cubit.search,
                        onSearchClear: () => cubit.search(''),
                        onLessonTap: (lesson) {
                          Navigator.of(context)
                              .pushNamed(RouteNames.lessonDetails, arguments: lesson);
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Column(
      children: [
        verticalSpace(48),
        const AbsorbPointer(child: CustomSearchBar(hintText: 'ابحث عن درس...')),
        verticalSpace(28),
        const Expanded(child: LessonsLoadingView()),
      ],
    );
  }
}
