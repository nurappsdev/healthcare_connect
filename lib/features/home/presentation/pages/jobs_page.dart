import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

const _green = AppColors.splashAccentColor;
const _border = AppColors.cardBorderColor;
const _white = AppColors.whiteColor;

/// Footer layout for a job card, depending on which tab it belongs to.
enum JobCardVariant { saved, applied, history }

/// Jobs tab: Saved / Applied / History lists of job postings.
class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  static const _tabs = ['Saved', 'Applied', 'History'];
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
            child: Text(
              'Jobs',
              style: TextStyle(
                color: _white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 6.h),
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
              padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 24.h),
              itemCount: 4,
              separatorBuilder: (_, _) => SizedBox(height: 18.h),
              itemBuilder: (_, index) => switch (_tab) {
                1 => _JobCard(
                  variant: JobCardVariant.applied,
                  statusLabel: index.isEven ? 'Viewed' : 'Shortlisted',
                ),
                2 => const _JobCard(variant: JobCardVariant.history),
                _ => const _JobCard(),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  const _JobCard({this.variant = JobCardVariant.saved, this.statusLabel});

  final JobCardVariant variant;
  final String? statusLabel;

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
              Icon(Icons.attach_money, color: _white, size: 18.r),
              SizedBox(width: 4.w),
              Text(
                '12, 000',
                style: TextStyle(
                  color: _white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _skills.map((skill) => _SkillChip(skill)).toList(),
          ),
          SizedBox(height: 16.h),
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
          SizedBox(height: 16.h),
          Row(
            children: [
              Text(
                'On Site',
                style: TextStyle(
                  color: _green,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 28.w),
              Text(
                'Full time',
                style: TextStyle(
                  color: _green,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          if (variant != JobCardVariant.history) ...[
            SizedBox(height: 18.h),
            Row(
              children: [
                SizedBox(
                  height: 56.h,
                  width: 72.w,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: _green, width: 1.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child:
                        Icon(Icons.bookmark_border, color: _green, size: 24.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: SizedBox(
                    height: 56.h,
                    child: variant == JobCardVariant.applied
                        ? OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: _green, width: 1.w),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                            ),
                            child: Text(
                              statusLabel ?? 'Applied',
                              style: TextStyle(
                                color: _white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accentPurple,
                              foregroundColor: _white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                            ),
                            child: Text(
                              'Apply',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
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
