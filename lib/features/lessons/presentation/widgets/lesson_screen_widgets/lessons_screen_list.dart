import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_animations.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/custom_search_bar.dart';
import 'package:al_mobdea/features/lessons/domain/entities/lesson_entity.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_screen_widgets/lesson_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonsScreenList extends StatefulWidget {
  const LessonsScreenList({
    super.key,
    required this.lessons,
    required this.onLessonTap,
    this.query = '',
    this.hasNoResults = false,
    this.onSearchChanged,
    this.onSearchClear,
  });

  final List<LessonEntity> lessons;
  final ValueChanged<LessonEntity> onLessonTap;
  final String query;
  final bool hasNoResults;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchClear;

  @override
  State<LessonsScreenList> createState() => _LessonsScreenListState();
}

class _LessonsScreenListState extends State<LessonsScreenList> {
  late final TextEditingController _searchController = TextEditingController(text: widget.query);

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
      padding: EdgeInsets.only(top: 35.h, bottom: 112.h),
      children: [
        CustomSearchBar(
          controller: _searchController,
          hintText: 'ابحث عن درس...',
          onChanged: widget.onSearchChanged,
          onClear: widget.onSearchClear,
        ),
        verticalSpace(28),
        if (widget.hasNoResults)
          _buildNoResultsView()
        else
          for (var index = 0; index < widget.lessons.length; index++) ...[
            AppAnimations.screenSection(
              delay: 60 * index,
              child: LessonPreviewCard(
                title: widget.lessons[index].title,
                subtitle: widget.lessons[index].description,
                onTap: () => widget.onLessonTap(widget.lessons[index]),
              ),
            ),
            if (index != widget.lessons.length - 1) verticalSpace(22),
          ],
      ],
    );
  }

  Widget _buildNoResultsView() {
    return SizedBox(
      height: 320.h,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off_rounded, size: 54.sp, color: ColorPalette.wine200),
            verticalSpace(16),
            Text(
              'لا توجد نتائج تطابق بحثك',
              textDirection: TextDirection.rtl,
              style: AppTextStyle.font16TextPrimarySemiBoldKufam(),
            ),
          ],
        ),
      ),
    );
  }
}
