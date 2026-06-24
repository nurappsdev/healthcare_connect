import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

/// Success dialog shown after an account is created.
///
/// Returns `true` when the user taps "Yes" (set up profile now) and `false`
/// when they tap "Later". Resolves to `null` if dismissed.
class AccountCreatedDialog extends StatelessWidget {
  const AccountCreatedDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (_) => const AccountCreatedDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF3A3A3A),
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 28.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _SuccessBadge(),
            SizedBox(height: 24.h),
            Text(
              'Congratulation',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Your account create successfully. Are '
              'you want to setup profile now ?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.fieldHintColor,
                fontSize: 13.sp,
                height: 1.4,
              ),
            ),
            SizedBox(height: 28.h),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.whiteColor,
                        side: const BorderSide(
                          color: AppColors.fieldHintColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                      child: Text(
                        'Later',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentPurple,
                        foregroundColor: AppColors.whiteColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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

/// Green circular check mark surrounded by scattered accent dots.
class _SuccessBadge extends StatelessWidget {
  const _SuccessBadge();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.w,
      height: 120.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Scattered decorative dots around the badge.
          _Dot(top: 6.w, left: 30.w, size: 10.w),
          _Dot(top: 14.w, right: 22.w, size: 6.w),
          _Dot(top: 40.w, right: 4.w, size: 9.w),
          _Dot(bottom: 16.w, right: 18.w, size: 6.w),
          _Dot(bottom: 4.w, left: 46.w, size: 8.w),
          _Dot(bottom: 22.w, left: 8.w, size: 6.w),
          _Dot(top: 30.w, left: 6.w, size: 7.w),
          const Center(child: _CheckCircle()),
        ],
      ),
    );
  }
}

class _CheckCircle extends StatelessWidget {
  const _CheckCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76.w,
      height: 76.w,
      decoration: const BoxDecoration(
        color: AppColors.splashAccentColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.done_all,
        color: AppColors.blackColor,
        size: 38.r,
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.size,
  });

  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: AppColors.splashAccentColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
