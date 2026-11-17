import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_animations.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/custom_app_bar.dart';
import 'package:al_mobdea/core/widgets/custom_search_bar.dart';
import 'package:al_mobdea/features/lessons/domain/entities/lesson_entity.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_screen_widgets/lesson_access_filter.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_screen_widgets/lesson_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonsScreenList extends StatefulWidget {
  const LessonsScreenList({
    super.key,
    required this.lessons,
    required this.onLessonTap,
    required this.showFree,
    required this.onAccessTypeChanged,
    this.hasValidSubscription,
    this.query = '',
    this.hasNoResults = false,
    this.onSearchChanged,
    this.onSearchClear,
  });

  final List<LessonEntity> lessons;
  final ValueChanged<LessonEntity> onLessonTap;
  final bool showFree;
  final ValueChanged<bool> onAccessTypeChanged;
  final bool? hasValidSubscription;
  final String query;
  final bool hasNoResults;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchClear;

  @override
  State<LessonsScreenList> createState() => _LessonsScreenListState();
}

class _LessonsScreenListState extends State<LessonsScreenList> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController(text: widget.query);
  }

  @override
  void didUpdateWidget(covariant LessonsScreenList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.query != widget.query &&
        _searchController.text.trim() != widget.query) {
      _searchController.value = TextEditingValue(
        text: widget.query,
        selection: TextSelection.collapsed(offset: widget.query.length),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 112.h),
      children: [
        verticalSpace(12),
        CustomAppBar(
          title: 'الدروس',
          titleColor: ColorPalette.surface,
          titleBackgroundColor: ColorPalette.primary,
          backgroundColor: Colors.transparent,
          showBackButton: false,
          toolbarHeight: 48.h,
        ),
        verticalSpace(35),
        CustomSearchBar(
          controller: _searchController,
          hintText: 'ابحث عن درس...',
          onChanged: widget.onSearchChanged,
          onClear: () {
            _searchController.clear();
            widget.onSearchClear?.call();
          },
        ),
        verticalSpace(20),
        LessonAccessFilter(
          showFree: widget.showFree,
          onChanged: widget.onAccessTypeChanged,
        ),
        verticalSpace(24),
        if (widget.lessons.isEmpty)
          _buildEmptySection()
        else
          for (var index = 0; index < widget.lessons.length; index++) ...[
            AppAnimations.screenSection(
              delay: 60 * index,
              child: LessonPreviewCard(
                key: ValueKey(widget.lessons[index].lessonId),
                lessonId: widget.lessons[index].lessonId,
                title: widget.lessons[index].title,
                subtitle: widget.lessons[index].description,
                youtubeUrl: widget.lessons[index].youtubeUrl,
                isFree: widget.lessons[index].isFree,
                hasValidSubscription: widget.hasValidSubscription,
                onTap: () {
                  widget.onLessonTap(widget.lessons[index]);
                },
              ),
            ),
            if (index != widget.lessons.length - 1) verticalSpace(22),
          ],
      ],
    );
  }

  Widget _buildEmptySection() {
    final hasSearch = widget.hasNoResults || widget.query.trim().isNotEmpty;

    final message = hasSearch
        ? 'لا توجد نتائج تطابق بحثك'
        : widget.showFree
        ? 'لا توجد دروس مجانية حاليًا'
        : 'لا توجد دروس باشتراك حاليًا';

    return SizedBox(
      height: 280.h,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              hasSearch ? Icons.search_off_rounded : Icons.menu_book_outlined,
              size: 54.sp,
              color: ColorPalette.wine200,
            ),
            verticalSpace(16),
            Text(
              message,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: AppTextStyle.font16TextPrimarySemiBoldKufam(),
            ),
          ],
        ),
      ),
    );
  }
}
