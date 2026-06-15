import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileInformationPage extends StatelessWidget {
  const ProfileInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar: back + centered title
            Padding(
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
                      // Offset the title so it stays optically centered
                      // against the leading back button.
                      padding: EdgeInsets.only(right: 28.r),
                      child: Text(
                        'Profile information',
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
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ProfileSection(
                      label: 'Short Bio',
                      actionLabel: 'Add bio',
                      onTap: () => context.push(AppRoutes.addBio),
                    ),
                    _ProfileSection(
                      label: 'Contact information',
                      actionLabel: 'Add contact info',
                      onTap: () => context.push(AppRoutes.contactInfo),
                    ),
                    _ProfileSection(
                      label: 'Education',
                      actionLabel: 'Add education',
                      onTap: () => context.push(AppRoutes.educationList),
                    ),
                    _ProfileSection(
                      label: 'Add skills',
                      actionLabel: 'Add skills',
                      onTap: () => context.push(AppRoutes.addSkills),
                    ),
                    _ProfileSection(
                      label: 'Job experience',
                      actionLabel: 'Add job experience',
                      onTap: () => context.push(AppRoutes.jobExperience),
                    ),
                    _ProfileSection(
                      label: 'RESUME',
                      actionLabel: 'Upload documents',
                      onTap: () => context.push(AppRoutes.uploadResume),
                    ),
                    _ProfileSection(
                      label: 'Certification',
                      actionLabel: 'Upload certificate',
                      onTap: () => context.push(AppRoutes.uploadCertificate),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A labelled row with a pill-shaped outlined "add" button, used for each
/// section of the profile information screen.
class _ProfileSection extends StatelessWidget {
  const _ProfileSection({
    required this.label,
    required this.actionLabel,
    required this.onTap,
  });

  final String label;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 48.h,
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.whiteColor,
              side: BorderSide(color: AppColors.cardBorderColor, width: 1.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  actionLabel,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 12.w),
                Icon(
                  Icons.add,
                  color: AppColors.whiteColor,
                  size: 18.r,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 18.h),
      ],
    );
  }
}
