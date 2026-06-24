import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

const _white = AppColors.whiteColor;
const _border = AppColors.cardBorderColor;
const _purple = AppColors.accentPurple;

/// Candidate that applied to a posted job, shown on [AppliedCandidatesPage].
class AppliedCandidate {
  const AppliedCandidate({
    required this.name,
    required this.applyDate,
    required this.matchPercent,
    this.photoUrl,
  });

  final String name;
  final String applyDate;

  /// Skills-matching percentage in the 0–100 range.
  final int matchPercent;
  final String? photoUrl;
}

/// Recruiter screen listing the candidates that applied to a posted job,
/// reached by tapping the "applied already" pill on the Jobs screen.
class AppliedCandidatesPage extends StatelessWidget {
  const AppliedCandidatesPage({this.candidates = _demoCandidates, super.key});

  final List<AppliedCandidate> candidates;

  static const _demoCandidates = [
    AppliedCandidate(
      name: 'Abdullah',
      applyDate: '2 June 2026',
      matchPercent: 65,
    ),
    AppliedCandidate(
      name: 'Steve Smith',
      applyDate: '2 June 2026',
      matchPercent: 65,
    ),
    AppliedCandidate(
      name: 'Abdullah',
      applyDate: '2 June 2026',
      matchPercent: 65,
    ),
    AppliedCandidate(
      name: 'Steve Smith',
      applyDate: '2 June 2026',
      matchPercent: 65,
    ),
    AppliedCandidate(
      name: 'Abdullah',
      applyDate: '2 June 2026',
      matchPercent: 65,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 6.h, 20.w, 12.h),
              child: Text(
                'Total apply : ${candidates.length.toString().padLeft(2, '0')}',
                style: TextStyle(color: _white, fontSize: 12.sp),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
                itemCount: candidates.length,
                separatorBuilder: (_, _) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final candidate = candidates[index];
                  return _CandidateCard(
                    candidate: candidate,
                    onDetails: () => context.push(
                      AppRoutes.seeResume,
                      extra: candidate.name,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).maybePop(),
            child: Icon(Icons.arrow_back_ios_new, color: _white, size: 20.r),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Applied candidate',
                style: TextStyle(
                  color: _white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: 20.r),
        ],
      ),
    );
  }
}

class _CandidateCard extends StatelessWidget {
  const _CandidateCard({required this.candidate, required this.onDetails});

  final AppliedCandidate candidate;
  final VoidCallback onDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundColor: AppColors.darkCardColor,
                backgroundImage: candidate.photoUrl != null
                    ? NetworkImage(candidate.photoUrl!)
                    : null,
                child: candidate.photoUrl == null
                    ? Icon(Icons.person, color: _white, size: 24.r)
                    : null,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidate.name,
                      style: TextStyle(
                        color: _white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Appy date : ${candidate.applyDate}',
                      style: TextStyle(
                        color: AppColors.lightHintColor,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
              _DetailsButton(onTap: onDetails),
            ],
          ),
          SizedBox(height: 14.h),
          _MatchBar(percent: candidate.matchPercent),
        ],
      ),
    );
  }
}

class _DetailsButton extends StatelessWidget {
  const _DetailsButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        'Details',
        style: TextStyle(color: _white, fontSize: 12.sp),
      ),
    ),
  );
}

class _MatchBar extends StatelessWidget {
  const _MatchBar({required this.percent});

  final int percent;

  @override
  Widget build(BuildContext context) {
    final fraction = (percent.clamp(0, 100)) / 100;
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: fraction,
            child: Container(
              decoration: BoxDecoration(
                color: _purple,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Skills matching percentage',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: _white, fontSize: 12.sp),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  '$percent %',
                  style: TextStyle(
                    color: _white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
