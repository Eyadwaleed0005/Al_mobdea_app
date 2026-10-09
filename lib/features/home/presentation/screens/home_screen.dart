import 'package:al_mobdea/app/dependency_injection/service_locator.dart';
import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/core/helper/app_system_ui.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/widgets/background/background_student_layout.dart';
import 'package:al_mobdea/core/widgets/app_toast.dart';
import 'package:al_mobdea/features/authentication/data/data_source/cache/login_local_data_source.dart';
import 'package:al_mobdea/features/home/presentation/widgets/home_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.gradeId});

  final String? gradeId;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<String?> _gradeId;

  @override
  void initState() {
    super.initState();
    _gradeId = _loadGradeId();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.gradeId != widget.gradeId) {
      _gradeId = _loadGradeId();
    }
  }

  Future<String?> _loadGradeId() async {
    final routeGradeId = widget.gradeId?.trim();
    if (routeGradeId != null && routeGradeId.isNotEmpty) return routeGradeId;

    try {
      final savedGradeId = await getIt<LoginLocalDataSource>().getGradeId();
      final normalizedGradeId = savedGradeId?.trim();
      return normalizedGradeId == null || normalizedGradeId.isEmpty
          ? null
          : normalizedGradeId;
    } catch (_) {
      return null;
    }
  }

  Future<void> _openLiveSession() async {
    final gradeId = await _gradeId;
    if (!mounted) return;

    if (gradeId == null || gradeId.isEmpty) {
      showAppToast(
        context,
        message: 'تعذر تحديد الصف الدراسي، سجّل الدخول مرة أخرى.',
        icon: Icons.error_outline_rounded,
      );
      return;
    }

    Navigator.of(context).pushNamed(
      RouteNames.liveSessionScreen,
      arguments: gradeId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.dark(),
      child: Scaffold(
        extendBody: true,
        backgroundColor: ColorPalette.background,
        body: BackgroundStudentLayout(
          child: SafeArea(
            bottom: false,
            child: HomeScreenContent(onLiveSessionPressed: _openLiveSession),
          ),
        ),
      ),
    );
  }
}
