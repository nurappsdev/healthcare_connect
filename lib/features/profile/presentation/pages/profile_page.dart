import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const _skills = [
    'Team work',
    'Critical thinking',
    'Analytics skill',
    'Adaptability',
    'Analytics skill',
    'Adaptability',
    'Team work',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ProfileHeader(),
              SizedBox(height: 20.h),
              const Center(child: _ProfileAvatar()),
              SizedBox(height: 7.h),
              Center(
                child: Text(
                  'David',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Center(
                child: Text(
                  'Carpenter expert',
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 9.sp),
                ),
              ),
              SizedBox(height: 20.h),
              _SectionLabel(
                title: 'Short bio',
                onEdit: () => context.push(AppRoutes.addBio),
              ),
              SizedBox(height: 14.h),
              _SectionLabel(
                title: 'Contact information',
                onEdit: () => context.push(AppRoutes.contactInfo),
              ),
              SizedBox(height: 14.h),
              _SectionLabel(
                title: 'Experience',
                onEdit: () => context.push(AppRoutes.jobExperience),
              ),
              SizedBox(height: 5.h),
              const _ExperienceCard(),
              SizedBox(height: 6.h),
              const _ExperienceCard(),
              SizedBox(height: 15.h),
              _SectionLabel(
                title: 'Education',
                onEdit: () => context.push(AppRoutes.educationList),
              ),
              SizedBox(height: 5.h),
              const _EducationCard(),
              SizedBox(height: 15.h),
              _SectionLabel(
                title: 'Skills',
                onEdit: () => context.push(AppRoutes.addSkills),
              ),
              SizedBox(height: 7.h),
              Wrap(
                spacing: 4.w,
                runSpacing: 5.h,
                children: _skills.map((skill) => _SkillChip(skill)).toList(),
              ),
              SizedBox(height: 16.h),
              _SectionLabel(
                title: 'Resume',
                onEdit: () => context.push(AppRoutes.uploadResume),
              ),
              SizedBox(height: 7.h),
              const _DocumentTile(fileName: 'Resume for carpentars.pdf'),
              SizedBox(height: 15.h),
              _SectionLabel(
                title: 'Certificate',
                onEdit: () => context.push(AppRoutes.uploadCertificate),
              ),
              SizedBox(height: 7.h),
              const _DocumentTile(fileName: 'Certificate.pdf'),
              SizedBox(height: 8.h),
              SizedBox(
                width: double.infinity,
                height: 43.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentPurple,
                    foregroundColor: AppColors.whiteColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                  ),
                  child: Text(
                    'Build resume by AI',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            'Profile',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.tight(Size(32.r, 32.r)),
              icon: Icon(
                Icons.settings_outlined,
                color: AppColors.whiteColor,
                size: 19.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62.r,
      height: 62.r,
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(color: const Color(0xFFEDEDED)),
            Positioned(
              top: 9.h,
              child: Icon(
                Icons.person,
                color: const Color(0xFF262626),
                size: 47.r,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 54.r,
                height: 24.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(18.r),
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

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title, this.onEdit});

  final String title;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        GestureDetector(
          onTap: onEdit,
          behavior: HitTestBehavior.opaque,
          child: Icon(
            Icons.edit_outlined,
            color: AppColors.whiteColor,
            size: 17.r,
          ),
        ),
      ],
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(8.w, 9.h, 9.w, 9.h),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.fieldBorderColor, width: 1.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CompanyLogo(),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'McDonnald',
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 8.sp),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Carpenter Specialist',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h),
                const _InfoRow(
                  icon: Icons.location_on_outlined,
                  text: 'Jakarta, Indonesia - On site',
                ),
                SizedBox(height: 8.h),
                const _InfoRow(
                  icon: Icons.calendar_today_outlined,
                  text: 'Dec 2024 to Feb 2026 - 1 year 2 months',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  const _EducationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(8.w, 9.h, 9.w, 9.h),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.fieldBorderColor, width: 1.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CompanyLogo(),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Civil engineering',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'University name here',
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 8.sp),
                ),
                SizedBox(height: 13.h),
                const _InfoRow(
                  icon: Icons.location_on_outlined,
                  text: 'Jakarta, Indonesia',
                ),
                SizedBox(height: 8.h),
                const _InfoRow(
                  icon: Icons.calendar_today_outlined,
                  text: 'Jan 2021 to Feb 2024 - 4 years',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompanyLogo extends StatelessWidget {
  const _CompanyLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.r,
      height: 30.r,
      decoration: BoxDecoration(
        color: const Color(0xFFFF1F14),
        borderRadius: BorderRadius.circular(9.r),
      ),
      alignment: Alignment.center,
      child: Text(
        'M',
        style: TextStyle(
          color: const Color(0xFFFFD200),
          fontSize: 18.sp,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.whiteColor, size: 11.r),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: AppColors.whiteColor, fontSize: 8.sp),
          ),
        ),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.whiteColor, width: 1.w),
      ),
      child: Text(
        text,
        style: TextStyle(color: AppColors.whiteColor, fontSize: 8.sp),
      ),
    );
  }
}

class _DocumentTile extends StatelessWidget {
  const _DocumentTile({required this.fileName});

  final String fileName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 9.h, 10.w, 9.h),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.fieldBorderColor, width: 1.w),
      ),
      child: Row(
        children: [
          Icon(Icons.picture_as_pdf, color: AppColors.accentRed, size: 18.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 8.sp),
                ),
                SizedBox(height: 5.h),
                Text(
                  '12 Mb 3 Jun 2026 at 10 : 43 AM',
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 7.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
