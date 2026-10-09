import 'dart:async';

import 'package:al_mobdea/app/dependency_injection/service_locator.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/widgets/app_error_state.dart';
import 'package:al_mobdea/core/widgets/app_loading_indicator.dart';
import 'package:al_mobdea/core/widgets/background/background_student_layout.dart';
import 'package:al_mobdea/features/exams/presentation/screens/exams_screen.dart';
import 'package:al_mobdea/features/home/presentation/screens/home_screen.dart';
import 'package:al_mobdea/features/lessons/presentation/screens/lessons_screen.dart';
import 'package:al_mobdea/features/study_notes/presentation/screens/study_notes_screen.dart';
import 'package:al_mobdea/features/main_navigation/presentation/cubit/bottom_navigation_cubit.dart';
import 'package:al_mobdea/features/profile/presentation/screens/profile_screen.dart';
import 'package:al_mobdea/features/main_navigation/presentation/cubit/student_grade_sync_cubit.dart';
import 'package:al_mobdea/features/main_navigation/presentation/cubit/student_grade_sync_state.dart';
import 'package:al_mobdea/features/main_navigation/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:al_mobdea/features/main_navigation/presentation/widgets/exit_app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key, this.initialIndex = 2});

  final int initialIndex;

  static const int _screensCount = 5;
  static const int _examsScreenIndex = 4;

  @override
  Widget build(BuildContext context) {
    final validInitialIndex = initialIndex.clamp(0, _screensCount - 1).toInt();

    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavigationCubit>(
          create: (_) => getIt<BottomNavigationCubit>()..changeIndex(validInitialIndex),
        ),
        BlocProvider<StudentGradeSyncCubit>(
          create: (_) => getIt<StudentGradeSyncCubit>()..initialize(),
        ),
      ],
      child: _MainNavigationBackHandler(
        child: Scaffold(
          extendBody: true,
          backgroundColor: ColorPalette.background,
          body: BlocBuilder<StudentGradeSyncCubit, StudentGradeSyncState>(
            builder: (context, gradeState) {
              return BlocBuilder<BottomNavigationCubit, int>(
                builder: (context, selectedIndex) {
                  final currentIndex = selectedIndex.clamp(0, _screensCount - 1).toInt();

                  return IndexedStack(
                    index: currentIndex,
                    children: List<Widget>.generate(_screensCount, (index) {
                      return KeyedSubtree(
                        key: ValueKey<String>(_screenKey(index: index, gradeState: gradeState)),
                        child: _buildScreen(context: context, index: index, gradeState: gradeState),
                      );
                    }),
                  );
                },
              );
            },
          ),
          bottomNavigationBar: const CustomBottomNavBar(),
        ),
      ),
    );
  }

  Widget _buildScreen({
    required BuildContext context,
    required int index,
    required StudentGradeSyncState gradeState,
  }) {
    switch (index) {
      case 0:
        return const ProfileScreen();
      case 1:
        return _buildStudyNotesScreen(context, gradeState);
      case 2:
        return HomeScreen(gradeId: _gradeIdFrom(gradeState));
      case 3:
        return _buildLessonsScreen(context, gradeState);
      case _examsScreenIndex:
        return _buildExamsScreen(context, gradeState);
      default:
        return HomeScreen(gradeId: _gradeIdFrom(gradeState));
    }
  }

  Widget _buildExamsScreen(BuildContext context, StudentGradeSyncState gradeState) {
    return switch (gradeState) {
      StudentGradeSyncSuccess(:final gradeId) => ExamsScreen(gradeId: gradeId),
      StudentGradeSyncFailure(:final error) => BackgroundStudentLayout(
        child: SafeArea(
          bottom: false,
          child: AppErrorState(
            message: error.message,
            onRetry: context.read<StudentGradeSyncCubit>().retry,
          ),
        ),
      ),
      StudentGradeSyncInitial() || StudentGradeSyncLoading() => const BackgroundStudentLayout(
        child: Center(
          child: AppLoadingIndicator(
            color: ColorPalette.primary,
            size: 34,
            strokeWidth: 4,
            wavelength: 16,
            waveSpeed: 10,
          ),
        ),
      ),
    };
  }

  Widget _buildLessonsScreen(BuildContext context, StudentGradeSyncState gradeState) {
    return switch (gradeState) {
      StudentGradeSyncSuccess() => const LessonsScreen(),
      StudentGradeSyncFailure(:final error) => BackgroundStudentLayout(
        child: SafeArea(
          bottom: false,
          child: AppErrorState(
            message: error.message,
            onRetry: context.read<StudentGradeSyncCubit>().retry,
          ),
        ),
      ),
      StudentGradeSyncInitial() || StudentGradeSyncLoading() => const BackgroundStudentLayout(
        child: Center(
          child: AppLoadingIndicator(
            color: ColorPalette.primary,
            size: 34,
            strokeWidth: 4,
            wavelength: 16,
            waveSpeed: 10,
          ),
        ),
      ),
    };
  }

  Widget _buildStudyNotesScreen(BuildContext context, StudentGradeSyncState gradeState) {
    return switch (gradeState) {
      StudentGradeSyncSuccess() => const StudyNotesScreen(),
      StudentGradeSyncFailure(:final error) => BackgroundStudentLayout(
        child: SafeArea(
          bottom: false,
          child: AppErrorState(
            message: error.message,
            onRetry: context.read<StudentGradeSyncCubit>().retry,
          ),
        ),
      ),
      StudentGradeSyncInitial() || StudentGradeSyncLoading() => const BackgroundStudentLayout(
        child: Center(
          child: AppLoadingIndicator(
            color: ColorPalette.primary,
            size: 34,
            strokeWidth: 4,
            wavelength: 16,
            waveSpeed: 10,
          ),
        ),
      ),
    };
  }

  String _screenKey({required int index, required StudentGradeSyncState gradeState}) {
    if (index != _examsScreenIndex && index != 3 && index != 1) {
      return index.toString();
    }

    return switch (gradeState) {
      StudentGradeSyncSuccess(:final gradeId) => '$index-${gradeId.trim()}',
      _ => '$index-${gradeState.runtimeType}',
    };
  }

  String? _gradeIdFrom(StudentGradeSyncState gradeState) {
    return switch (gradeState) {
      StudentGradeSyncSuccess(:final gradeId) => gradeId,
      _ => null,
    };
  }
}

class _MainNavigationBackHandler extends StatefulWidget {
  const _MainNavigationBackHandler({required this.child});

  final Widget child;

  @override
  State<_MainNavigationBackHandler> createState() =>
      _MainNavigationBackHandlerState();
}

class _MainNavigationBackHandlerState
    extends State<_MainNavigationBackHandler> {
  static const int _homeIndex = 2;
  static const Duration _exitWindow = Duration(seconds: 2);

  Timer? _exitTimer;
  bool _waitingForSecondBack = false;
  bool _isExiting = false;

  void _resetExitAttempt() {
    _exitTimer?.cancel();
    _exitTimer = null;
    _waitingForSecondBack = false;

    dismissExitAppToast();
  }

  Future<void> _handleBack() async {
    if (_isExiting) {
      return;
    }

    final navigationCubit = context.read<BottomNavigationCubit>();

    if (navigationCubit.state != _homeIndex) {
      _resetExitAttempt();
      navigationCubit.changeIndex(_homeIndex);
      return;
    }

    if (_waitingForSecondBack) {
      _resetExitAttempt();
      _isExiting = true;

      try {
        await SystemNavigator.pop();
      } finally {
        _isExiting = false;
      }

      return;
    }

    _waitingForSecondBack = true;

    _exitTimer = Timer(_exitWindow, _resetExitAttempt);

    showExitAppToast(context, duration: _exitWindow);
  }

  @override
  void dispose() {
    _resetExitAttempt();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BottomNavigationCubit, int>(
      listener: (context, state) {
        _resetExitAttempt();
      },
      child: PopScope<Object?>(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          }

          unawaited(_handleBack());
        },
        child: widget.child,
      ),
    );
  }
}
