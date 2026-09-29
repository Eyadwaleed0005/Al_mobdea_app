import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/core/widgets/app_error_state.dart';
import 'package:al_mobdea/features/study_notes/domain/entities/study_note_entity.dart';
import 'package:al_mobdea/features/study_notes/presentation/screens/study_note_pdf_reader_screen.dart';
import 'package:al_mobdea/features/study_notes/presentation/screens/study_notes_screen.dart';
import 'package:flutter/material.dart';

abstract final class StudyNotesRoutes {
  const StudyNotesRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.studyNotesScreen:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const StudyNotesScreen(),
        );
      case RouteNames.studyNotePdfReaderScreen:
        final note = settings.arguments;
        if (note is! StudyNoteEntity) return _invalidRoute(settings);
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => StudyNotePdfReaderScreen(note: note),
        );
      default:
        return null;
    }
  }

  static Route<dynamic> _invalidRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => const Scaffold(
        body: AppErrorState(message: 'المذكرة غير متاحة حاليًا'),
      ),
    );
  }
}
