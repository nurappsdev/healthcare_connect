import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

const _green = AppColors.splashAccentColor;
const _border = AppColors.cardBorderColor;
const _white = Colors.white;

class HomeHeader extends StatelessWidget {
  const HomeHeader({this.onProfileTap, super.key});

  final VoidCallback? onProfileTap;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      GestureDetector(
        onTap: onProfileTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
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
  const HomeSearchField({
    this.controller,
    this.onChanged,
    this.onClear,
    super.key,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

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
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            textInputAction: TextInputAction.search,
            cursorColor: _green,
            style: TextStyle(color: _white, fontSize: 12.sp),
            decoration: InputDecoration(
              isCollapsed: true,
              border: InputBorder.none,
              hintText: 'Search here.',
              hintStyle: TextStyle(color: _white, fontSize: 12.sp),
            ),
          ),
        ),
        if (controller != null)
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller!,
            builder: (context, value, _) => value.text.isEmpty
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: onClear,
                    child: Icon(Icons.close, color: _white, size: 19.r),
                  ),
          ),
      ],
    ),
  );
}

class HomeSectionTitle extends StatelessWidget {
  const HomeSectionTitle(this.title, {this.onViewMore, super.key});

  final String title;
  final VoidCallback? onViewMore;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: TextStyle(color: _white, fontSize: 16.sp),
        ),
      ),
      GestureDetector(
        onTap: onViewMore,
        behavior: HitTestBehavior.opaque,
        child: Text(
          'View More',
          style: TextStyle(color: _green, fontSize: 8.sp),
        ),
      ),
    ],
  );
}

class HomeJobCard extends StatelessWidget {
  const HomeJobCard({
    required this.title,
    this.compact = false,
    this.onTap,
    this.onApply,
    super.key,
  });

  final String title;
  final bool compact;
  final VoidCallback? onTap;
  final VoidCallback? onApply;

  @override
  Widget build(BuildContext context) {
    final skills = compact
        ? ['Critical thinking', 'Analytics skill', '+5 more']
        : ['Team work', 'Critical thinking', 'Analytics skill', '+5 more'];

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
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
                  Expanded(child: _ApplyButton(onPressed: onApply)),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
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
  const _ApplyButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 50.h,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentPurple,
        foregroundColor: _white,
        shape: const StadiumBorder(),
      ),
      child: Text('Apply', style: TextStyle(fontSize: 13.sp)),
    ),
  );
}
