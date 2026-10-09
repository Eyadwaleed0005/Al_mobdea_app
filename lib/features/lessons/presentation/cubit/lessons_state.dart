import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/lessons/domain/entities/lesson_entity.dart';

sealed class LessonsState {
  const LessonsState();
}

final class LessonsInitial extends LessonsState {
  const LessonsInitial();
}

final class LessonsLoading extends LessonsState {
  const LessonsLoading();
}

final class LessonsEmpty extends LessonsState {
  const LessonsEmpty();
}

final class LessonsFailure extends LessonsState {
  const LessonsFailure({required this.error});
  final AppErrorModel error;
}

final class LessonsDataSuccess extends LessonsState {
  const LessonsDataSuccess({required this.lessons, this.query = ''});

  final List<LessonEntity> lessons;
  final String query;

  bool get hasActiveQuery => query.trim().isNotEmpty;

  bool get hasNoResults => hasActiveQuery && lessons.isEmpty;
}
