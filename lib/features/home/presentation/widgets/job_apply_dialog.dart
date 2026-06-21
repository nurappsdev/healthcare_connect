import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

Future<void> showJobApplyDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.72),
    builder: (_) => const JobApplyDialog(),
  );
}

class JobApplyDialog extends StatefulWidget {
  const JobApplyDialog({super.key});

  @override
  State<JobApplyDialog> createState() => _JobApplyDialogState();
}

class _JobApplyDialogState extends State<JobApplyDialog> {
  int _selectedResume = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.fromLTRB(28.w, 18.h, 28.w, 42.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F4F4),
          borderRadius: BorderRadius.circular(36.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 3.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E2E2),
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            SizedBox(height: 28.h),
            Text(
              'Apply this job',
              style: TextStyle(
                color: const Color(0xFF00D95F),
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 28.h),
            Text(
              'Before apply the job please select your\nresume which you want to use.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF5D5D5D),
                fontSize: 17.sp,
                height: 1.35,
              ),
            ),
            SizedBox(height: 26.h),
            _ResumeTile(
              title: 'Resume for carpenters.pdf',
              selected: _selectedResume == 0,
              onTap: () => setState(() => _selectedResume = 0),
            ),
            SizedBox(height: 18.h),
            _ResumeTile(
              title: 'Resume for carpenters.pdf ( By AI )',
              selected: _selectedResume == 1,
              onTap: () => setState(() => _selectedResume = 1),
            ),
            SizedBox(height: 28.h),
            Row(
              children: [
                Expanded(
                  child: _DialogActionButton(
                    label: 'Apply',
                    color: const Color(0xFF00D95F),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: _DialogActionButton(
                    label: 'Cancel',
                    color: const Color(0xFFFF0000),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ResumeTile extends StatelessWidget {
  const _ResumeTile({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        height: 67.h,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFBDBDBD)),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.picture_as_pdf,
              color: AppColors.accentPurple,
              size: 23.r,
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: const Color(0xFF858585),
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '1.2 Mb 3 Jun 2026 at 10 : 43 AM',
                    style: TextStyle(
                      color: const Color(0xFF858585),
                      fontSize: 9.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              height: 26.r,
              width: 26.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF9A9A9A)),
              ),
              alignment: Alignment.center,
              child: selected
                  ? Container(
                      height: 12.r,
                      width: 12.r,
                      decoration: const BoxDecoration(
                        color: AppColors.accentPurple,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogActionButton extends StatelessWidget {
  const _DialogActionButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 52.h,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color, width: 1.w),
        shape: const StadiumBorder(),
      ),
      child: Text(label, style: TextStyle(fontSize: 15.sp)),
    ),
  );
}
