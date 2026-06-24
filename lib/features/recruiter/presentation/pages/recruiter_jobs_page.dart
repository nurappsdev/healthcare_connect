import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

const _green = AppColors.splashAccentColor;
const _border = AppColors.cardBorderColor;
const _white = AppColors.whiteColor;
const _purple = AppColors.accentPurple;

/// Recruiter "Jobs" screen: Posted jobs / History lists of the jobs a
/// recruiter has published, with applicant counts and shortlist totals.
class RecruiterJobsPage extends StatefulWidget {
  const RecruiterJobsPage({super.key});

  @override
  State<RecruiterJobsPage> createState() => _RecruiterJobsPageState();
}

class _RecruiterJobsPageState extends State<RecruiterJobsPage> {
  static const _tabs = ['Posted jobs', 'History'];
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          Column(
            children: [
              _Header(),
              SizedBox(height: 10.h),
              Row(
                children: List.generate(_tabs.length, (index) {
                  final selected = index == _tab;
                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => setState(() => _tab = index),
                      child: Column(
                        children: [
                          Text(
                            _tabs[index],
                            style: TextStyle(
                              color: selected ? _white : AppColors.lightHintColor,
                              fontSize: 14.sp,
                              fontWeight:
                                  selected ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            height: 2.h,
                            color: selected ? _green : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              Container(height: 1, color: _border.withValues(alpha: 0.4)),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 90.h),
                  itemCount: 4,
                  separatorBuilder: (_, _) => SizedBox(height: 18.h),
                  itemBuilder: (_, index) =>
                      _PostedJobCard(history: _tab == 1),
                ),
              ),
            ],
          ),
          Positioned(
            right: 20.w,
            bottom: 24.h,
            child: _AddJobButton(onTap: () {}),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
      child: Row(
        children: [
          if (canPop)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).maybePop(),
              child: Icon(Icons.arrow_back_ios_new, color: _white, size: 20.r),
            )
          else
            SizedBox(width: 20.r),
          Expanded(
            child: Center(
              child: Text(
                'Jobs',
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

class _PostedJobCard extends StatelessWidget {
  const _PostedJobCard({this.history = false});

  final bool history;

  static const _skills = [
    'Team work',
    'Critical thinking',
    'Analytics skill',
    '+5 more',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Logo(),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'McDonnald',
                      style: TextStyle(
                        color: _white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Jakarta • Indonesia',
                      style: TextStyle(
                        color: AppColors.lightHintColor,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.more_vert, color: _white, size: 20.r),
            ],
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _skills.map((skill) => _SkillChip(skill)).toList(),
          ),
          SizedBox(height: 14.h),
          Text(
            'Lorem ipsum dolor sit amet consectetur ut sagittis arcu nunc '
            'commodo morbi sem aliquet. Lorem ipsum dolor sit amet '
            'consectetur ut sagittis arcu nunc commodo morbi sem aliqu...',
            style: TextStyle(
              color: AppColors.lightHintColor,
              fontSize: 11.sp,
              height: 1.5,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              _DateLabel(label: 'Posted date', value: '2 May 2026'),
              SizedBox(width: 24.w),
              _DateLabel(label: 'Deadline', value: '2 May 2026'),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'On Site',
                      style: TextStyle(
                        color: AppColors.accentTeal,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 24.w),
                    Text(
                      'Full time',
                      style: TextStyle(
                        color: AppColors.accentTeal,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.attach_money, color: _white, size: 18.r),
              SizedBox(width: 2.w),
              Text(
                '12, 000',
                style: TextStyle(
                  color: _white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Row(
            children: [
              Expanded(
                child: _AppliedPill(
                  count: 32,
                  onTap: () => context.push(AppRoutes.appliedCandidates),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _ShortlistedPill(
                  count: 12,
                  onTap: () => context.push(AppRoutes.shortlistedCandidates),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DateLabel extends StatelessWidget {
  const _DateLabel({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Text.rich(
    TextSpan(
      children: [
        TextSpan(text: '$label : '),
        TextSpan(
          text: value,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ],
    ),
    style: TextStyle(
      color: AppColors.accentTeal,
      fontSize: 11.sp,
      fontWeight: FontWeight.w500,
    ),
  );
}

class _AppliedPill extends StatelessWidget {
  const _AppliedPill({required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 17.r,
            backgroundColor: AppColors.darkCardColor,
            child: Icon(Icons.person, color: _white, size: 20.r),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              '+ $count applied already',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: _white, fontSize: 11.sp),
            ),
          ),
          Icon(Icons.chevron_right, color: _white, size: 20.r),
        ],
      ),
    ),
  );
}

class _ShortlistedPill extends StatelessWidget {
  const _ShortlistedPill({required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 48.h,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: _purple,
        foregroundColor: _white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.r),
        ),
      ),
      child: Text(
        'Shortlisted = $count',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
      ),
    ),
  );
}

class _AddJobButton extends StatelessWidget {
  const _AddJobButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 56.r,
      width: 56.r,
      decoration: BoxDecoration(
        color: _purple,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: _purple.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(Icons.add, color: _white, size: 30.r),
    ),
  );
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) => Container(
    height: 38.r,
    width: 38.r,
    decoration: BoxDecoration(
      color: const Color(0xFFFF1F14),
      borderRadius: BorderRadius.circular(10.r),
    ),
    alignment: Alignment.center,
    child: Text(
      'M',
      style: TextStyle(
        color: const Color(0xFFFFD200),
        fontSize: 22.sp,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}

class _SkillChip extends StatelessWidget {
  const _SkillChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
    decoration: BoxDecoration(
      border: Border.all(color: _border),
      borderRadius: BorderRadius.circular(6.r),
    ),
    child: Text(
      label,
      style: TextStyle(color: _white, fontSize: 10.sp),
    ),
  );
}
