import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

const _green = AppColors.splashAccentColor;
const _border = AppColors.cardBorderColor;
const _white = Colors.white;

/// A job-seeker summary card shown on the teacher home feed.
///
/// Mirrors the design in `devImg/img_51.png`: avatar + name, skill chips, a
/// short bio and a full-width "Message" button.
class JobSeekerCard extends StatelessWidget {
  const JobSeekerCard({
    required this.name,
    required this.title,
    this.skills = const [
      'Team work',
      'Critical thinking',
      'Analytics skill',
      '+5 more',
    ],
    this.onTap,
    this.onMessage,
    super.key,
  });

  final String name;
  final String title;
  final List<String> skills;
  final VoidCallback? onTap;
  final VoidCallback? onMessage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: _border),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const _SeekerAvatar(),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: _white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        title,
                        style: TextStyle(color: _white, fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 5.h,
              children: skills.map((skill) => _SkillChip(skill)).toList(),
            ),
            SizedBox(height: 14.h),
            Text(
              'Lorem ipsum dolor sit amet consectetur ut sagittis arcu nunc '
              'commodo morbi sem aliquet. Lorem ipsum dolor sit amet '
              'consectetur ut sagittis arcu nunc commodo morbi sem aliqu...',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: _white, fontSize: 9.sp, height: 1.45),
            ),
            SizedBox(height: 18.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: onMessage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentPurple,
                  foregroundColor: _white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                ),
                child: Text(
                  'Message',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SeekerAvatar extends StatelessWidget {
  const _SeekerAvatar();

  @override
  Widget build(BuildContext context) => Container(
    height: 38.r,
    width: 38.r,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: _green, width: 1.6.w),
      gradient: const LinearGradient(
        colors: [Color(0xFFE7D6B5), Color(0xFF8FBC4D)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: Icon(Icons.person, color: _white, size: 22.r),
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
