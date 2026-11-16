import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/widgets/background/background_student_layout.dart';
import 'package:al_mobdea/core/widgets/custom_app_bar.dart';
import 'package:al_mobdea/core/widgets/custom_operation_result_dialog.dart';
import 'package:al_mobdea/core/widgets/custom_search_bar.dart';
import 'package:al_mobdea/features/lessons/domain/entities/lesson_entity.dart';
import 'package:al_mobdea/features/lessons/presentation/cubit/lessons_cubit.dart';
import 'package:al_mobdea/features/lessons/presentation/cubit/lessons_state.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_screen_widgets/lessons_screen_states/lessons_empty_view.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_screen_widgets/lessons_screen_states/lessons_error_view.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_screen_widgets/lessons_screen_states/lessons_loading_view.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_screen_widgets/lessons_screen_states/lessons_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonsScreenContent extends StatefulWidget {
  const LessonsScreenContent({super.key});

  @override
  State<LessonsScreenContent> createState() {
    return _LessonsScreenContentState();
  }
}

class _LessonsScreenContentState extends State<LessonsScreenContent> {
  bool _isOpeningLesson = false;

  Future<void> _openLesson(LessonEntity lesson) async {
    if (_isOpeningLesson) {
      return;
    }

    _isOpeningLesson = true;

    try {
      final result = await context.read<LessonsCubit>().checkLessonAccess(
        lesson: lesson,
      );

      if (!mounted) {
        return;
      }

      await result.fold<Future<void>>(
        (error) {
          return _showAccessDialog(
            title: 'تعذر التحقق من الاشتراك',
            message: error.message,
            icon: Icons.error_outline_rounded,
          );
        },
        (canAccess) async {
          if (!canAccess) {
            await _showAccessDialog(
              title: 'هذا الدرس للمشتركين',
              message:
                  'يتطلب عرض هذا الدرس ومحتوياته اشتراكًا نشطًا. '
                  'يمكنك متابعة الدروس المتاحة في قسم مجاني.',
              icon: Icons.lock_outline_rounded,
            );

            return;
          }

          await Navigator.of(context)
              .pushNamed(RouteNames.lessonDetails, arguments: lesson);
        },
      );
    } finally {
      _isOpeningLesson = false;
    }
  }

  Future<void> _showAccessDialog({
    required String title,
    required String message,
    required IconData icon,
  }) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return CustomOperationResultDialog(
          type: CustomOperationResultType.failure,
          failureIcon: icon,
          title: title,
          message: message,
          actionText: 'حسنًا',
          onActionPressed: () {
            Navigator.of(dialogContext).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundStudentLayout(
      child: SafeArea(
        bottom: false,
        child: BlocBuilder<LessonsCubit, LessonsState>(
          builder: (context, state) {
            final cubit = context.read<LessonsCubit>();

            if (state is LessonsInitial || state is LessonsLoading) {
              return _buildLoadingView();
            }

            if (state is LessonsFailure) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    verticalSpace(12),
                    _buildAppBar(),
                    Expanded(
                      child: LessonsErrorView(
                        errorMessage: state.error.message,
                        onRetry: cubit.retry,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is LessonsEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    verticalSpace(12),
                    _buildAppBar(),
                    const Expanded(child: LessonsEmptyView()),
                  ],
                ),
              );
            }

            if (state is LessonsDataSuccess) {
              return LessonsSuccessView(
                lessons: state.lessons,
                query: state.query,
                showFree: state.showFree,
                hasNoResults: state.hasNoResults,
                hasValidSubscription: state.hasValidSubscription,
                onAccessTypeChanged: cubit.selectAccessType,
                onSearchChanged: cubit.search,
                onSearchClear: () {
                  cubit.search('');
                },
                onLessonTap: _openLesson,
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      title: 'الدروس',
      titleColor: ColorPalette.surface,
      titleBackgroundColor: ColorPalette.primary,
      backgroundColor: Colors.transparent,
      showBackButton: false,
      toolbarHeight: 48.h,
    );
  }

  Widget _buildLoadingView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          verticalSpace(12),
          _buildAppBar(),
          verticalSpace(48),
          const AbsorbPointer(
            child: CustomSearchBar(hintText: 'ابحث عن درس...'),
          ),
          verticalSpace(28),
          const Expanded(child: LessonsLoadingView()),
        ],
      ),
    );
  }
}
