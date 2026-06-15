import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/education.dart';
import '../widgets/profile_form_field.dart';

class EducationListPage extends StatefulWidget {
  const EducationListPage({super.key});

  @override
  State<EducationListPage> createState() => _EducationListPageState();
}

class _EducationListPageState extends State<EducationListPage> {
  final List<Education> _entries = [
    Education(
      subject: 'Civil engineering',
      universityName: 'University name here',
      location: 'Jakarta, Indonesia',
      from: DateTime(2021, 1),
      to: DateTime(2024, 2),
    ),
    Education(
      subject: 'Civil engineering',
      universityName: 'University name here',
      location: 'Jakarta, Indonesia',
      from: DateTime(2021, 1),
    ),
  ];

  Future<void> _addEducation() async {
    final result = await context.push<Education>(AppRoutes.addEducation);
    if (result == null) return;
    setState(() => _entries.add(result));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        child: Column(
          children: [
            const ProfileTopBar(title: 'Add your education'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
                child: Column(
                  children: [
                    for (final entry in _entries) ...[
                      _EducationCard(entry: entry),
                      SizedBox(height: 16.h),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
              child: SizedBox(
                height: 52.h,
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _addEducation,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: AppColors.splashAccentColor,
                      width: 1.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    color: AppColors.splashAccentColor,
                    size: 26.r,
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

/// Card summarising one education entry.
class _EducationCard extends StatelessWidget {
  const _EducationCard({required this.entry});

  final Education entry;

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String _monthYear(DateTime date) => '${_months[date.month - 1]} ${date.year}';

  String get _dateRange {
    final start = _monthYear(entry.from);
    final to = entry.to;
    if (to == null) return '$start to  Continue';
    final years = (to.difference(entry.from).inDays / 365).floor();
    final suffix = years > 0 ? ' - $years year${years == 1 ? '' : 's'}' : '';
    return '$start to ${_monthYear(to)}$suffix';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.fieldBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo placeholder
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.school_outlined,
                  color: AppColors.loginBackground,
                  size: 24.r,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.subject,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      entry.universityName,
                      style: TextStyle(
                        color: AppColors.fieldHintColor,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.more_vert,
                color: AppColors.whiteColor,
                size: 20.r,
              ),
            ],
          ),
          SizedBox(height: 14.h),
          _InfoRow(icon: Icons.location_on_outlined, text: entry.location),
          SizedBox(height: 10.h),
          _InfoRow(icon: Icons.calendar_today_outlined, text: _dateRange),
        ],
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
        Icon(icon, color: AppColors.fieldHintColor, size: 18.r),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.mutedTextColor,
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }
}
