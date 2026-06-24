import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class ReportUserPage extends StatelessWidget {
  const ReportUserPage({super.key});

  static const reasons = [
    ReportReason(
      title: 'Hate Speech',
      description:
          'Hate speech involves harmful communication that targets individuals '
          'or groups based on characteristics like race, religion, or gender. '
          'It fosters division, discrimination, and violence. Combating hate '
          'speech requires a balance between free expression and public safety.',
    ),
    ReportReason(
      title: 'Threat',
      description:
          'Threats include messages that suggest harm, intimidation, or unsafe '
          'behavior toward another person.',
    ),
    ReportReason(
      title: 'Harassment',
      description:
          'Harassment includes repeated unwanted contact, insults, pressure, or '
          'behavior intended to make someone feel unsafe.',
    ),
    ReportReason(
      title: 'Pretending to be something',
      description:
          'This report is for accounts pretending to be another person, company, '
          'or service in a misleading way.',
    ),
    ReportReason(
      title: 'Fraud Or Scam',
      description:
          'Fraud or scam reports help identify deceptive activity, false offers, '
          'payment tricks, or attempts to steal personal information.',
    ),
    ReportReason(
      title: 'Fake Identity',
      description:
          'Fake identity reports cover profiles using false names, photos, or '
          'details to misrepresent who they are.',
    ),
    ReportReason(
      title: 'Something Else',
      description:
          'Use this option when the problem does not match the listed report '
          'categories but still needs review.',
    ),
    ReportReason(
      title: 'Other',
      description:
          'Share this report when you need to flag another issue for support.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ReportHeader(onBack: () => context.pop()),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: const _ReportIntro(),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: reasons.length,
                  separatorBuilder: (_, _) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) => ReportReasonTile(
                    reason: reasons[index],
                    selected: index == 0,
                    onTap: () => context.push(
                      AppRoutes.reportUserDetails,
                      extra: reasons[index],
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

class ReportUserDetailsPage extends StatelessWidget {
  const ReportUserDetailsPage({required this.reason, super.key});

  final ReportReason reason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ReportHeader(onBack: () => context.pop()),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: const _ReportIntro(),
              ),
              SizedBox(height: 20.h),
              ReportReasonTile(reason: reason, selected: true),
              SizedBox(height: 24.h),
              Text(
                'Describe your Complain',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 11.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 14.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.accentPurple, width: 1.w),
                ),
                child: Text(
                  reason.description,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 11.sp,
                    height: 1.35,
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

class _ReportHeader extends StatelessWidget {
  const _ReportHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: onBack,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.tight(Size(32.r, 32.r)),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.whiteColor,
                size: 20.r,
              ),
            ),
          ),
          Text(
            'Report',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportIntro extends StatelessWidget {
  const _ReportIntro();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Find Support or Report User',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Help us understanding what's happening",
          style: TextStyle(color: AppColors.whiteColor, fontSize: 13.sp),
        ),
      ],
    );
  }
}

class ReportReasonTile extends StatelessWidget {
  const ReportReasonTile({
    required this.reason,
    required this.selected,
    this.onTap,
    super.key,
  });

  final ReportReason reason;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9.r),
      child: Container(
        height: 43.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.r),
          border: Border.all(color: AppColors.accentPurple, width: 1.w),
        ),
        child: Row(
          children: [
            Container(
              width: 18.r,
              height: 18.r,
              padding: EdgeInsets.all(3.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.accentPurple, width: 2.w),
              ),
              child: selected
                  ? const DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.accentPurple,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Text(
                reason.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportReason {
  const ReportReason({required this.title, required this.description});

  final String title;
  final String description;
}
