import 'dart:async';

import 'package:al_mobdea/features/exams/data/data_source/remote/student_exams_remote_data_source.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_attempt_entity.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_attempt_status.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_entity.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_question_entity.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_result_entity.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_session_entity.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_status.dart';
import 'package:al_mobdea/features/exams/domain/entities/submit_student_exam_entity.dart';

//! TODO: remove this file when firebase is initialized and start using
//! [FirebaseStudentExamsRemoteDataSource]
class PreviewStudentExamsRemoteDataSource implements StudentExamsRemoteDataSource {
  PreviewStudentExamsRemoteDataSource();

  static const String _examId = 'preview-nahw-exam';
  static const Duration _attemptDuration = Duration(minutes: 30);

  final String _resultId = 'preview-nahw-result-${DateTime.now().millisecondsSinceEpoch}';
  final DateTime _startedAt = DateTime.now().toUtc();

  bool _isExamSubmitted = false;

  DateTime get _expiresAt => _startedAt.add(_attemptDuration);

  StudentExamEntity get _exam {
    return StudentExamEntity(
      examId: _examId,
      gradeId: 'preview-grade',
      examName: 'اختبار النحو العربي',
      questionCount: 20,
      durationMinutes: 30,
      totalScore: 40,
      status: StudentExamStatus.published,
      createdAt: _previewCreatedAt,
      updatedAt: _previewCreatedAt,
    );
  }

  static final DateTime _previewCreatedAt = DateTime(2026, 9, 20);

  List<StudentExamQuestionEntity> get _questions {
    return List<StudentExamQuestionEntity>.generate(20, (int index) {
      return StudentExamQuestionEntity(
        questionId: 'preview-question-${index + 1}',
        examId: _examId,
        questionText: _questionTextFor(index),
        choices: _choicesFor(index),
        degree: 2,
        questionOrder: index,
      );
    });
  }

  String _questionTextFor(int index) {
    const List<String> sampleQuestions = <String>[
      'أي الجمل التالية خبرها شبه جملة؟',
      'ما نوع الخبر في جملة: الطالبُ مجتهدٌ؟',
      'ما الذي يأخذ حكم المبتدأ من الجملة؟',
      'أي الكلمات التالية مبتدأ مؤخر؟',
      'علام يدل الفعل "يبدو" في بداية الجملة؟',
    ];

    return sampleQuestions[index % sampleQuestions.length];
  }

  List<String> _choicesFor(int index) {
    const List<List<String>> sampleChoices = <List<String>>[
      <String>['الطالبُ في الفصل', 'العلمُ نورٌ', 'المعلمُ نشيطٌ', 'الكتابُ مفيدٌ'],
      <String>['خبر مفرد', 'خبر جملة فعلية', 'خبر جملة اسمية', 'خبر شبه جملة'],
      <String>['الفعل', 'الفاعل', 'المفعول', 'الحال'],
      <String>['في الفصل طالبٌ', 'طالبٌ في الفصل', 'الفصلُ طالبٌ', 'طالبٌ مجتهدٌ'],
      <String>['التقديم', 'التأخير', 'النفي', 'الإثبات'],
    ];

    return sampleChoices[index % sampleChoices.length];
  }

  StudentExamAttemptEntity get _inProgressAttempt {
    return StudentExamAttemptEntity(
      resultId: _resultId,
      examId: _examId,
      studentId: 'preview-student',
      status: StudentExamAttemptStatus.inProgress,
      totalScore: _exam.totalScore,
      startedAt: _startedAt,
      expiresAt: _expiresAt,
    );
  }

  StudentExamResultEntity get _previewResult {
    return StudentExamResultEntity(
      resultId: _resultId,
      examId: _examId,
      examName: _exam.examName,
      score: 0,
      totalScore: _exam.totalScore,
      correctAnswers: 0,
      wrongAnswers: 0,
      unansweredQuestions: _exam.questionCount,
      submittedAt: DateTime.now().toUtc(),
    );
  }

  @override
  Stream<List<StudentExamEntity>> streamGradeExams({required String gradeId}) {
    if (_isExamSubmitted) {
      return Stream<List<StudentExamEntity>>.value(const <StudentExamEntity>[]);
    }

    return Stream<List<StudentExamEntity>>.value(<StudentExamEntity>[_exam]);
  }

  @override
  Stream<List<StudentExamAttemptEntity>> streamStudentAttempts() {
    if (_isExamSubmitted) {
      return Stream<List<StudentExamAttemptEntity>>.value(const <StudentExamAttemptEntity>[]);
    }

    return Stream<List<StudentExamAttemptEntity>>.value(<StudentExamAttemptEntity>[
      _inProgressAttempt,
    ]);
  }

  @override
  Future<StudentExamSessionEntity> startExam({required String examId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));

    return _buildSession();
  }

  @override
  Future<StudentExamSessionEntity> resumeExam({
    required String examId,
    required String resultId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));

    return _buildSession();
  }

  @override
  Future<StudentExamResultEntity> submitExam({required SubmitStudentExamEntity submission}) async {
    await Future<void>.delayed(const Duration(milliseconds: 900));

    _isExamSubmitted = true;

    return _previewResult;
  }

  StudentExamSessionEntity _buildSession() {
    return StudentExamSessionEntity(
      exam: _exam,
      attempt: _inProgressAttempt,
      questions: List<StudentExamQuestionEntity>.unmodifiable(_questions),
    );
  }
}
