import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

/// A single fixable issue surfaced by the ATS scoring.
class _Issue {
  const _Issue(this.title, this.description);

  final String title;
  final String description;
}

/// Result screen for the ATS checker: shows the resume score over a dimmed
/// preview of the uploaded CV, followed by the issues that need fixing.
class CvScorePage extends StatelessWidget {
  const CvScorePage({super.key, this.cvPath, this.score = 83});

  final String? cvPath;
  final int score;

  static const _issues = [
    _Issue(
      'Skills section',
      'Est qui dolorem ipsum quia dolor sit. Est qui dolorem ipsum '
          'quia dolor sit. Est qui dolorem ipsum quia dolor sit. Est qui '
          'dolorem ipsum quia dolor sit',
    ),
    _Issue(
      'Bio section',
      'Est qui dolorem ipsum quia dolor sit. Est qui dolorem ipsum '
          'quia dolor sit. Est qui dolorem ipsum quia dolor sit. Est qui '
          'dolorem ipsum quia dolor sit',
    ),
    _Issue(
      'Experience section',
      'Est qui dolorem ipsum quia dolor sit. Est qui dolorem ipsum '
          'quia dolor sit. Est qui dolorem ipsum quia dolor sit. Est qui '
          'dolorem ipsum quia dolor sit',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const cardOverlap = 70.0;

    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Dimmed CV preview.
                  SizedBox(
                    height: 360.h,
                    width: double.infinity,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withValues(alpha: 0.45),
                        BlendMode.darken,
                      ),
                      child: cvPath != null
                          ? Image.file(
                              File(cvPath!),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            )
                          : Container(color: AppColors.darkCardColor),
                    ),
                  ),
                  // Top bar over the preview.
                  Positioned(
                    top: 8.h,
                    left: 16.w,
                    right: 16.w,
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
                              'ATS checker',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Score card overlapping the bottom of the preview.
                  Positioned(
                    left: 16.w,
                    right: 16.w,
                    bottom: -cardOverlap.h,
                    child: _ScoreCard(score: score),
                  ),
                ],
              ),
              SizedBox(height: (cardOverlap + 20).h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Need to fixed issues',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              ..._issues.map(
                (issue) => Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
                  child: _IssueCard(issue: issue),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}

/// White card showing the headline score with a progress bar and a badge.
class _ScoreCard extends StatelessWidget {
  const _ScoreCard({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Text(
            'Your resume score',
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 22.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: LinearProgressIndicator(
              value: score / 100,
              minHeight: 8.h,
              backgroundColor: const Color(0xFFE3E3E3),
              valueColor: const AlwaysStoppedAnimation(AppColors.accentPurple),
            ),
          ),
          SizedBox(height: 18.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(color: AppColors.accentPurple),
            ),
            child: Text(
              '$score / 100',
              style: TextStyle(
                color: AppColors.accentPurple,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dark card describing one issue that needs fixing.
class _IssueCard extends StatelessWidget {
  const _IssueCard({required this.issue});

  final _Issue issue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColors.darkCardColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            issue.title,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            issue.description,
            style: TextStyle(
              color: AppColors.lightHintColor,
              fontSize: 12.sp,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
