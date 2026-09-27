import 'package:al_mobdea/app/dependency_injection/service_locator.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/app_error_state.dart';
import 'package:al_mobdea/core/widgets/app_loading_indicator.dart';
import 'package:al_mobdea/core/widgets/background/background_student_layout.dart';
import 'package:al_mobdea/features/home/presentation/screens/home_screen.dart';
import 'package:al_mobdea/features/main_navigation/presentation/cubit/bottom_navigation_cubit.dart';
import 'package:al_mobdea/features/main_navigation/presentation/cubit/student_grade_sync_cubit.dart';
import 'package:al_mobdea/features/main_navigation/presentation/cubit/student_grade_sync_state.dart';
import 'package:al_mobdea/features/main_navigation/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          create: (_) =>
              getIt<BottomNavigationCubit>()..changeIndex(validInitialIndex),
        ),
        BlocProvider<StudentGradeSyncCubit>(
          create: (_) => getIt<StudentGradeSyncCubit>()..initialize(),
        ),
      ],
      child: Scaffold(
        extendBody: true,
        backgroundColor: ColorPalette.background,
        body: BlocBuilder<StudentGradeSyncCubit, StudentGradeSyncState>(
          builder: (context, gradeState) {
            return BlocBuilder<BottomNavigationCubit, int>(
              builder: (context, selectedIndex) {
                final currentIndex = selectedIndex
                    .clamp(0, _screensCount - 1)
                    .toInt();

                return IndexedStack(
                  index: currentIndex,
                  children: List<Widget>.generate(_screensCount, (index) {
                    return KeyedSubtree(
                      key: ValueKey<String>(
                        _screenKey(index: index, gradeState: gradeState),
                      ),
                      child: _buildScreen(
                        context: context,
                        index: index,
                        gradeState: gradeState,
                      ),
                    );
                  }),
                );
              },
            );
          },
        ),
        bottomNavigationBar: const CustomBottomNavBar(),
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
        return const _NavigationPlaceholderScreen(
          title: 'حسابي',
          description: 'ستظهر بيانات حسابك هنا عند إضافة صفحة الحساب.',
          icon: Icons.person_outline_rounded,
        );
      case 1:
        return const _NavigationPlaceholderScreen(
          title: 'المذكرات',
          description: 'ستظهر مذكراتك الدراسية هنا عند إضافة صفحة المذكرات.',
          icon: Icons.note_alt_outlined,
        );
      case 2:
        return HomeScreen(gradeId: _gradeIdFrom(gradeState));
      case 3:
        return const _NavigationPlaceholderScreen(
          title: 'الدروس',
          description: 'ستظهر دروسك هنا عند إضافة صفحة الدروس.',
          icon: Icons.menu_book_outlined,
        );
      case _examsScreenIndex:
        return _buildExamsPlaceholder(context, gradeState);
      default:
        return HomeScreen(gradeId: _gradeIdFrom(gradeState));
    }
  }

  Widget _buildExamsPlaceholder(
    BuildContext context,
    StudentGradeSyncState gradeState,
  ) {
    return switch (gradeState) {
      StudentGradeSyncSuccess() => const _NavigationPlaceholderScreen(
        title: 'الامتحانات',
        description: 'ستظهر امتحانات صفك هنا عند إضافة صفحة الامتحانات.',
        icon: Icons.assignment_outlined,
      ),
      StudentGradeSyncFailure(:final error) => BackgroundStudentLayout(
        child: SafeArea(
          bottom: false,
          child: AppErrorState(
            message: error.message,
            onRetry: context.read<StudentGradeSyncCubit>().retry,
          ),
        ),
      ),
      StudentGradeSyncInitial() ||
      StudentGradeSyncLoading() => const BackgroundStudentLayout(
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

  String _screenKey({
    required int index,
    required StudentGradeSyncState gradeState,
  }) {
    if (index != _examsScreenIndex) return index.toString();

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

class _NavigationPlaceholderScreen extends StatelessWidget {
  const _NavigationPlaceholderScreen({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return BackgroundStudentLayout(
      child: SafeArea(
        bottom: false,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 44, color: ColorPalette.primary),
                verticalSpace(14),
                Text(
                  title,
                  textDirection: TextDirection.rtl,
                  style: AppTextStyle.font20TextPrimarySemiBoldKufam(),
                ),
                verticalSpace(8),
                Text(
                  description,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.font14TextSecondaryRegularTajawal()
                      .copyWith(height: 1.6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
