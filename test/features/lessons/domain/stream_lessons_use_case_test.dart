import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/lessons/domain/entities/lesson_entity.dart';
import 'package:al_mobdea/features/lessons/domain/repositories/lessons_repository.dart';
import 'package:al_mobdea/features/lessons/domain/use_cases/stream_lessons_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLessonsRepository extends Mock implements LessonsRepository {}

void main() {
  late MockLessonsRepository mockLessonsRepository;
  late StreamLessonsUseCase streamLessonsUseCase;

  const tLessons = <LessonEntity>[
    LessonEntity(
      lessonId: 'lesson-1',
      title: 'الدرس الأول',
      description: 'شرح الدرس الأول',
      gradeId: 'grade-1',
      isPublished: true,
      youtubeUrl: 'https://youtube.com/watch?v=lesson-1',
      pdfStoragePath: 'lessons/lesson-1.pdf',
      pdfFileName: 'lesson-1.pdf',
      pdfFileSize: 1024,
    ),
    LessonEntity(
      lessonId: 'lesson-2',
      title: 'الدرس الثاني',
      description: 'شرح الدرس الثاني',
      gradeId: 'grade-1',
      isPublished: true,
      youtubeUrl: '',
      pdfStoragePath: 'lessons/lesson-2.pdf',
      pdfFileName: 'lesson-2.pdf',
      pdfFileSize: 2048,
    ),
  ];

  const tAppError = AppErrorModel(
    code: 'firestore-error',
    message: 'تعذر تحميل الدروس',
    type: AppErrorType.unknown,
    isRetryable: true,
  );

  setUp(() {
    mockLessonsRepository = MockLessonsRepository();
    streamLessonsUseCase = StreamLessonsUseCase(
      repository: mockLessonsRepository,
    );
  });

  group('StreamLessonsUseCase', () {
    test(
      'should return stream of Right(lessons) when repository call succeeds',
      () async {
        // arrange
        when(
          () => mockLessonsRepository.streamLessons(),
        ).thenAnswer((_) => Stream.value(const Right(tLessons)));

        // act
        final result = await streamLessonsUseCase().first;

        // assert
        expect(result, const Right(tLessons));
        verify(() => mockLessonsRepository.streamLessons()).called(1);
        verifyNoMoreInteractions(mockLessonsRepository);
      },
    );

    test(
      'should return AppErrorModel when repository fails',
      () async {
        // arrange
        when(
          () => mockLessonsRepository.streamLessons(),
        ).thenAnswer((_) => Stream.value(const Left(tAppError)));

        // act
        final result = await streamLessonsUseCase().first;

        // assert
        expect(result, const Left(tAppError));
        verify(() => mockLessonsRepository.streamLessons()).called(1);
        verifyNoMoreInteractions(mockLessonsRepository);
      },
    );
  });
}
