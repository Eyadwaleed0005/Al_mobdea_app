import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/lesson_quiz/domain/entity/lesson_quiz_entity.dart';
import 'package:al_mobdea/features/lesson_quiz/domain/repositories/lesson_quiz_repo.dart';
import 'package:al_mobdea/features/lesson_quiz/domain/usecase/lesson_quiz_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockLessonQuizRepository extends Mock implements LessonQuizRepository {}

void main() {
  late MockLessonQuizRepository repository;
  late GetLessonQuizUseCase useCase;

  setUp(() {
    repository = MockLessonQuizRepository();
    useCase = GetLessonQuizUseCase(repository: repository);
  });

  final tLessonId = 'lesson_001';
  final tEntity = LessonQuizEntity(
    lessonId: tLessonId,
    questions: const [],
  );

  test('should return LessonQuizEntity for given lessonId', () async {
    when(() => repository.getLessonQuiz(lessonId: tLessonId))
        .thenAnswer((_) async => right(tEntity));

    final result = await useCase(lessonId: tLessonId);

    expect(result, right(tEntity));
    verify(() => repository.getLessonQuiz(lessonId: tLessonId)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return Left(AppErrorModel) when repository fails', () async {
    final tError = AppErrorModel(
      code: 'error',
      message: 'something went wrong',
      type: AppErrorType.server,
      isRetryable: false,
    );
    when(() => repository.getLessonQuiz(lessonId: tLessonId))
        .thenAnswer((_) async => left(tError));

    final result = await useCase(lessonId: tLessonId);

    expect(result, left(tError));
    verify(() => repository.getLessonQuiz(lessonId: tLessonId)).called(1);
    verifyNoMoreInteractions(repository);
  });
}