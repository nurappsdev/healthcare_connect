import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

const _green = AppColors.splashAccentColor;
const _border = AppColors.cardBorderColor;
const _white = Colors.white;

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        height: 48.r,
        width: 48.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: _green, width: 2.w),
          gradient: const LinearGradient(
            colors: [Color(0xFFE7D6B5), Color(0xFF8FBC4D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Icon(Icons.person, color: _white, size: 26.r),
      ),
      SizedBox(width: 10.w),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sophia',
              style: TextStyle(color: _white, fontSize: 16.sp),
            ),
            SizedBox(height: 3.h),
            Text(
              'Welcome to GeniuxRX',
              style: TextStyle(color: _white, fontSize: 9.sp),
            ),
          ],
        ),
      ),
      Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(Icons.notifications_none, color: _white, size: 25.r),
          Positioned(
            right: -1.w,
            top: -3.h,
            child: CircleAvatar(
              radius: 6.r,
              backgroundColor: AppColors.accentRed,
              child: Text('0', style: TextStyle(fontSize: 7.sp)),
            ),
          ),
        ],
      ),
    ],
  );
}

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key});

  @override
  Widget build(BuildContext context) => Container(
    height: 50.h,
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    decoration: BoxDecoration(
      border: Border.all(color: _border),
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: Row(
      children: [
        Icon(Icons.search, color: _white, size: 21.r),
        SizedBox(width: 10.w),
        Text(
          'Search here.',
          style: TextStyle(color: _white, fontSize: 12.sp),
        ),
      ],
    ),
  );
}

class HomeSectionTitle extends StatelessWidget {
  const HomeSectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: TextStyle(color: _white, fontSize: 16.sp),
        ),
      ),
      Text(
        'View More',
        style: TextStyle(color: _green, fontSize: 8.sp),
      ),
    ],
  );
}

class HomeJobCard extends StatelessWidget {
  const HomeJobCard({required this.title, this.compact = false, super.key});

  final String title;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final skills = compact
        ? ['Critical thinking', 'Analytics skill', '+5 more']
        : ['Team work', 'Critical thinking', 'Analytics skill', '+5 more'];

    return Container(
      padding: EdgeInsets.all(compact ? 14.r : 18.r),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const _Logo(),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: _white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Jakarta - Indonesia',
                      style: TextStyle(color: _white, fontSize: 9.sp),
                    ),
                  ],
                ),
              ),
              const _Score(),
            ],
          ),
          SizedBox(height: compact ? 14.h : 20.h),
          Wrap(
            spacing: 6.w,
            runSpacing: 5.h,
            children: skills.map((skill) => _SkillChip(skill)).toList(),
          ),
          SizedBox(height: compact ? 10.h : 14.h),
          Text(
            'Lorem ipsum dolor sit amet consectetur ut sagittis arcu nunc '
            'commodo morbi sem aliquet. Lorem ipsum dolor sit amet...',
            maxLines: compact ? 2 : 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: _white, fontSize: 9.sp, height: 1.45),
          ),
          SizedBox(height: compact ? 8.h : 10.h),
          const _MetaRow(),
          SizedBox(height: compact ? 12.h : 16.h),
          Row(
            children: [
              Icon(Icons.attach_money, color: _white, size: 16.r),
              SizedBox(width: 8.w),
              Text(
                '12, 000',
                style: TextStyle(
                  color: _white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          if (!compact) ...[
            SizedBox(height: 16.h),
            Row(
              children: [
                const _SaveButton(),
                SizedBox(width: 12.w),
                const Expanded(child: _ApplyButton()),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({
    required this.currentIndex,
    required this.onChanged,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;

  static const _items = [
    Icons.home_outlined,
    Icons.article_outlined,
    Icons.work_outline,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.paddingOf(context).bottom;
    final navHeight = 60.h;
    final barHeight = 51.h;
    final circleSize = 50.r;
    final selectedIndex = currentIndex.clamp(0, _items.length - 1);

    return SizedBox(
      height: navHeight + safeBottom,
      child: Padding(
        padding: EdgeInsets.only(bottom: safeBottom),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / _items.length;
            final selectedLeft =
                (itemWidth * selectedIndex) + ((itemWidth - circleSize) / 2);

            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: barHeight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F2F2F),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10.r),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: barHeight,
                  child: Row(
                    children: List.generate(_items.length, (index) {
                      final selected = index == selectedIndex;
                      return Expanded(
                        child: _BottomBarIcon(
                          icon: _items[index],
                          selected: selected,
                          onTap: () => onChanged(index),
                        ),
                      );
                    }),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeOutCubic,
                  left: selectedLeft,
                  top: 0,
                  child: GestureDetector(
                    onTap: () => onChanged(selectedIndex),
                    child: Container(
                      height: circleSize,
                      width: circleSize,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF2F2F2F),
                          width: 4.w,
                        ),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 160),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        child: Icon(
                          _items[selectedIndex],
                          key: ValueKey(selectedIndex),
                          color: _white,
                          size: 23.r,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BottomBarIcon extends StatelessWidget {
  const _BottomBarIcon({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    customBorder: const CircleBorder(),
    child: Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        height: 42.r,
        width: 42.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.transparent : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 120),
          opacity: selected ? 0 : 1,
          child: Icon(icon, color: _white, size: 24.r),
        ),
      ),
    ),
  );
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) => Container(
    height: 34.r,
    width: 34.r,
    decoration: BoxDecoration(
      color: const Color(0xFFFF1F14),
      borderRadius: BorderRadius.circular(9.r),
    ),
    alignment: Alignment.center,
    child: Text(
      'M',
      style: TextStyle(
        color: const Color(0xFFFFD200),
        fontSize: 20.sp,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}

class _Score extends StatelessWidget {
  const _Score();

  @override
  Widget build(BuildContext context) => Container(
    height: 48.r,
    width: 48.r,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: _green, width: 1.4.w),
    ),
    child: Text(
      '76 %',
      style: TextStyle(color: _white, fontSize: 10.sp),
    ),
  );
}

class _SkillChip extends StatelessWidget {
  const _SkillChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
    decoration: BoxDecoration(border: Border.all(color: _border)),
    child: Text(
      label,
      style: TextStyle(color: _white, fontSize: 8.sp),
    ),
  );
}

class _MetaRow extends StatelessWidget {
  const _MetaRow();

  @override
  Widget build(BuildContext context) => Row(
    children: ['On Site', 'Full time', '23 Applied already'].map((text) {
      return Expanded(
        child: Text(
          text,
          style: TextStyle(
            color: _green,
            fontSize: 9.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }).toList(),
  );
}

class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 50.h,
    width: 70.w,
    child: OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: _green, width: 1.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Icon(Icons.bookmark_border, color: _green, size: 23.r),
    ),
  );
}

class _ApplyButton extends StatelessWidget {
  const _ApplyButton();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 50.h,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentPurple,
        foregroundColor: _white,
        shape: const StadiumBorder(),
      ),
      child: Text('Apply', style: TextStyle(fontSize: 13.sp)),
    ),
  );
}
