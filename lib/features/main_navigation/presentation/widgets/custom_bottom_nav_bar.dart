import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/features/main_navigation/presentation/cubit/bottom_navigation_cubit.dart';
import 'package:al_mobdea/features/main_navigation/presentation/widgets/nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key, this.currentIndex, this.onItemSelected});

  final int? currentIndex;
  final ValueChanged<int>? onItemSelected;

  static const List<BottomNavItemData> items = [
    BottomNavItemData(
      index: 2,
      label: 'الرئيسية',
      iconPath: 'assets/icons/home.svg',
    ),
    BottomNavItemData(
      index: 3,
      label: 'الدروس',
      iconPath: 'assets/icons/lessons.svg',
    ),
    BottomNavItemData(
      index: 1,
      label: 'المذكرات',
      iconPath: 'assets/icons/study_notes.svg',
    ),
    BottomNavItemData(
      index: 4,
      label: 'الامتحانات',
      iconPath: 'assets/icons/exam.svg',
    ),
    BottomNavItemData(
      index: 0,
      label: 'حسابي',
      iconPath: 'assets/icons/profile.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex =
        currentIndex ?? context.watch<BottomNavigationCubit>().state;

    void handleTap(int index) {
      if (onItemSelected != null) {
        onItemSelected!(index);
      } else {
        context.read<BottomNavigationCubit>().changeIndex(index);
      }
    }

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 6.h),
        child: SizedBox(
          height: 62.h,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: ColorPalette.surface,
              borderRadius: BorderRadius.circular(50.r),
              boxShadow: [
                BoxShadow(
                  color: ColorPalette.cardShadow.withValues(alpha: 0.12),
                  blurRadius: 18.r,
                  offset: Offset(0, 5.h),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final unitWidth = constraints.maxWidth / 6;
                    var rightOffset = 0.0;
                    final positionedItems = <Widget>[];

                    for (final item in items) {
                      positionedItems.add(
                        _buildPositionedItem(
                          item: item,
                          selectedIndex: selectedIndex,
                          unitWidth: unitWidth,
                          rightOffset: rightOffset,
                          onTap: () => handleTap(item.index),
                        ),
                      );
                      rightOffset +=
                          unitWidth * (item.index == selectedIndex ? 2 : 1);
                    }

                    return Stack(
                      clipBehavior: Clip.none,
                      children: positionedItems,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPositionedItem({
    required BottomNavItemData item,
    required int selectedIndex,
    required double unitWidth,
    required double rightOffset,
    required VoidCallback onTap,
  }) {
    final isSelected = item.index == selectedIndex;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      right: rightOffset,
      top: 0,
      bottom: 0,
      width: unitWidth * (isSelected ? 2 : 1),
      child: NavItem(data: item, isSelected: isSelected, onTap: onTap),
    );
  }
}
