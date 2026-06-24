import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

/// Section label used above the profile input fields.
class ProfileFieldLabel extends StatelessWidget {
  const ProfileFieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

/// Pill-shaped outlined container used to wrap custom field content.
class ProfilePillField extends StatelessWidget {
  const ProfilePillField({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(color: AppColors.cardBorderColor),
      ),
      child: child,
    );
  }
}

/// Dashed-border box prompting the user to upload a logo / image.
class ProfileLogoUploadBox extends StatelessWidget {
  const ProfileLogoUploadBox({super.key, required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: DashedBorderPainter(
          color: AppColors.cardBorderColor,
          radius: 12.r,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 28.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 46.w,
                  height: 46.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.cardBorderColor),
                  ),
                  child: Icon(
                    Icons.file_upload_outlined,
                    color: AppColors.whiteColor,
                    size: 24.r,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  label,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Pill field with a leading location pin and an editable text field.
class ProfileLocationField extends StatelessWidget {
  const ProfileLocationField({
    super.key,
    required this.controller,
    this.hintText = 'Add location',
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return ProfilePillField(
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            color: AppColors.fieldHintColor,
            size: 20.r,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 13.sp,
              ),
              cursorColor: AppColors.accentPurple,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: AppColors.fieldHintColor,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Labelled, tappable date field that shows a calendar icon.
class ProfileDateField extends StatelessWidget {
  const ProfileDateField({
    super.key,
    required this.label,
    required this.valueText,
    required this.isPlaceholder,
    required this.onTap,
  });

  final String label;
  final String valueText;
  final bool isPlaceholder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileFieldLabel(label),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: onTap,
          child: ProfilePillField(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    valueText,
                    style: TextStyle(
                      color: isPlaceholder
                          ? AppColors.fieldHintColor
                          : AppColors.whiteColor,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.fieldHintColor,
                  size: 18.r,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Checkbox + label row used for the "I currently work / study here" toggle.
class ProfileCheckboxRow extends StatelessWidget {
  const ProfileCheckboxRow({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 22.w,
          height: 22.w,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.accentPurple,
            side: const BorderSide(color: AppColors.fieldHintColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          label,
          style: TextStyle(
            color: AppColors.fieldHintColor,
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }
}

/// Formats a date as `MM - DD - YYYY`, or a placeholder when null.
String formatProfileDate(DateTime? date) {
  if (date == null) return 'MM - DD - YYYY';
  final mm = date.month.toString().padLeft(2, '0');
  final dd = date.day.toString().padLeft(2, '0');
  return '$mm - $dd - ${date.year}';
}

/// Shows a dark-themed date picker consistent with the profile screens.
Future<DateTime?> pickProfileDate(
  BuildContext context, {
  DateTime? initialDate,
}) {
  final now = DateTime.now();
  return showDatePicker(
    context: context,
    initialDate: initialDate ?? now,
    firstDate: DateTime(1970),
    lastDate: DateTime(now.year + 10),
    builder: (context, child) => Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accentPurple,
          surface: AppColors.darkCardColor,
          onSurface: AppColors.whiteColor,
        ),
      ),
      child: child!,
    ),
  );
}

/// Paints a dashed rounded-rectangle border.
class DashedBorderPainter extends CustomPainter {
  DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  static const double _dashWidth = 6;
  static const double _dashGap = 4;
  static const double _strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = _strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final source = Path()..addRRect(rrect);

    final dashed = Path();
    for (final metric in source.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        dashed.addPath(
          metric.extractPath(distance, distance + _dashWidth),
          Offset.zero,
        );
        distance += _dashWidth + _dashGap;
      }
    }
    canvas.drawPath(dashed, paint);
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}
