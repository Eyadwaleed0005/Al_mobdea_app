import 'package:al_mobdea/features/study_notes/domain/entities/study_note_entity.dart';
import 'package:al_mobdea/features/study_notes/presentation/cubit/study_note_pdf_cubit.dart';
import 'package:al_mobdea/features/study_notes/presentation/cubit/study_note_pdf_state.dart';
import 'package:al_mobdea/features/study_notes/presentation/widgets/study_note_pdf_reader_screen_widgets/study_note_pdf_error_view.dart';
import 'package:al_mobdea/features/study_notes/presentation/widgets/study_note_pdf_reader_screen_widgets/study_note_pdf_loading_view.dart';
import 'package:al_mobdea/features/study_notes/presentation/widgets/study_note_pdf_reader_screen_widgets/study_note_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudyNotePdfBody extends StatelessWidget {
  const StudyNotePdfBody({super.key, required this.note});

  final StudyNoteEntity note;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudyNotePdfCubit, StudyNotePdfState>(
      builder: (context, state) {
        if (state is StudyNotePdfError) {
          return StudyNotePdfErrorView(
            errorMessage: state.error.message,
            onRetry: () => context.read<StudyNotePdfCubit>().retry(note: note),
          );
        }
        if (state is StudyNotePdfReady) {
          return StudyNotePdfViewer(pdfBytes: state.pdfBytes);
        }
        return const StudyNotePdfLoadingView();
      },
    );
  }
}
