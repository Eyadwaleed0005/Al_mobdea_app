import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/background/background_student_layout.dart';
import 'package:al_mobdea/core/widgets/custom_app_bar.dart';
import 'package:al_mobdea/features/study_notes/presentation/cubit/study_notes_cubit.dart';
import 'package:al_mobdea/features/study_notes/presentation/cubit/study_notes_state.dart';
import 'package:al_mobdea/features/study_notes/presentation/widgets/study_notes_screen_widgets/study_notes_list_view.dart';
import 'package:al_mobdea/features/study_notes/presentation/widgets/study_notes_screen_widgets/study_notes_loading_skeleton.dart';
import 'package:al_mobdea/features/study_notes/presentation/widgets/study_notes_screen_widgets/study_notes_screen_states/study_notes_empty_view.dart';
import 'package:al_mobdea/features/study_notes/presentation/widgets/study_notes_screen_widgets/study_notes_screen_states/study_notes_error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudyNotesScreenContent extends StatelessWidget {
  const StudyNotesScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundStudentLayout(
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              verticalSpace(10),
              CustomAppBar(
                titleWidget: Container(
                  width: 168.w,
                  height: 44.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorPalette.primary,
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  child: Text(
                    'المذكرات',
                    textDirection: TextDirection.rtl,
                    style: AppTextStyle.font22TextLightBoldKufam(),
                  ),
                ),
                backgroundColor: ColorPalette.background.withValues(alpha: 0),
                showBackButton: false,
                toolbarHeight: 56.h,
              ),
              Expanded(
                child: BlocBuilder<StudyNotesCubit, StudyNotesState>(
                  builder: (context, state) {
                    if (state is StudyNotesEmpty) {
                      return const StudyNotesEmptyView();
                    }
                    if (state is StudyNotesFailure) {
                      return Column(
                        children: [
                          verticalSpace(14),
                          _buildSubtitle(),
                          verticalSpace(14),
                          Expanded(
                            child: StudyNotesErrorView(
                              errorMessage: state.error.message,
                              onRetry: context.read<StudyNotesCubit>().retry,
                            ),
                          ),
                        ],
                      );
                    }
                    if (state is StudyNotesSuccess) {
                      return Column(
                        children: [
                          verticalSpace(14),
                          _buildSubtitle(),
                          verticalSpace(14),
                          Expanded(
                            child: StudyNotesListView(
                              notes: state.notes,
                              onNoteTap: (note) {
                                Navigator.of(
                                  context,
                                ).pushNamed(RouteNames.studyNotePdfReaderScreen, arguments: note);
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        verticalSpace(14),
                        _buildSubtitle(),
                        verticalSpace(14),
                        const Expanded(child: StudyNotesLoadingSkeleton()),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'ملخصات منظمة ترجع لها في أي وقت',
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      style: AppTextStyle.font14TextSecondaryRegularTajawal(),
    );
  }
}
