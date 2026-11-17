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
  const LessonsDataSuccess({
    required this.lessons,
    this.query = '',
    this.showFree = true,
    this.hasValidSubscription,
    this.subscriptionError,
  });

  final List<LessonEntity> lessons;
  final String query;
  final bool showFree;
  final bool? hasValidSubscription;
  final AppErrorModel? subscriptionError;

  int get lessonsCount => lessons.length;

  bool get hasActiveQuery => query.trim().isNotEmpty;

  bool get hasNoResults => hasActiveQuery && lessons.isEmpty;

  bool get isSelectedSectionEmpty => !hasActiveQuery && lessons.isEmpty;
}
