import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

/// A labelled, outlined input used across the profile setup screens
/// (add bio, contact info, ...).
///
/// Single-line fields render as a pill; pass a larger [maxLines] for a
/// rounded multi-line text area.
class ProfileFormField extends StatelessWidget {
  const ProfileFormField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText = 'Write here...',
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int maxLines;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    final isMultiline = maxLines > 1;
    final radius = isMultiline ? 16.r : 100.r;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          minLines: minLines,
          style: TextStyle(color: AppColors.whiteColor, fontSize: 13.sp),
          cursorColor: AppColors.accentPurple,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.fieldHintColor,
              fontSize: 13.sp,
            ),
            filled: false,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: isMultiline ? 18.h : 16.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: AppColors.cardBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: AppColors.accentPurple),
            ),
          ),
        ),
      ],
    );
  }
}

/// Full-width purple "Save" pill used at the bottom of the profile screens.
class ProfileSaveButton extends StatelessWidget {
  const ProfileSaveButton({super.key, required this.onPressed, this.label = 'Save'});

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentPurple,
          foregroundColor: AppColors.whiteColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

/// Shared top bar (back button + centered title) for the profile screens.
class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              Icons.chevron_left,
              color: AppColors.whiteColor,
              size: 28.r,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 28.r),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
