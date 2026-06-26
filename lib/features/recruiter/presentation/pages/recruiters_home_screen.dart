import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class RecruitersHomeScreen extends StatefulWidget {
  const RecruitersHomeScreen({this.onViewJobs, super.key});

  /// Called when the recruiter taps "View all" on the Total jobs card.
  final VoidCallback? onViewJobs;

  @override
  State<RecruitersHomeScreen> createState() => _RecruitersHomeScreenState();
}

class _RecruitersHomeScreenState extends State<RecruitersHomeScreen> {
  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  DateTime _selectedMonth = DateTime(2025, 8);

  String get _selectedMonthLabel =>
      '${_months[_selectedMonth.month - 1]} ${_selectedMonth.year}';

  Future<void> _pickMonth() async {
    final picked = await showDialog<DateTime>(
      context: context,
      builder: (_) => _MonthPickerDialog(initial: _selectedMonth),
    );
    if (picked != null) {
      setState(() => _selectedMonth = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(12.w, 17.h, 12.w, 96.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _RecruiterHeader(
                  onProfileTap: () => context.push(AppRoutes.userProfile),
                ),
                SizedBox(height: 55.h),
                Row(
                  children: [
                    Expanded(
                      child: _RecruiterStatCard(
                        title: 'Total jobs',
                        value: '65',
                        onViewAll: widget.onViewJobs,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: _RecruiterStatCard(
                        title: 'Application',
                        value: '65',
                        onViewAll: () =>
                            context.push(AppRoutes.appliedCandidates),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 49.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Application analytics',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _pickMonth,
                      child: Container(
                        height: 44.h,
                        padding: EdgeInsets.symmetric(horizontal: 19.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
                          border: Border.all(color: AppColors.cardBorderColor),
                        ),
                        child: Row(
                          children: [
                            Text(
                              _selectedMonthLabel,
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(width: 22.w),
                            Icon(
                              Icons.calendar_month_outlined,
                              color: AppColors.whiteColor,
                              size: 19.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  height: 205.h,
                  width: double.infinity,
                  child: const _RecruiterAnalyticsChart(),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 28.w,
          bottom: 16.h,
          child: SafeArea(
            child: GestureDetector(
              onTap: () => context.push(AppRoutes.postJob),
              child: Container(
                width: 67.r,
                height: 67.r,
                decoration: const BoxDecoration(
                  color: AppColors.accentPurple,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: AppColors.whiteColor, size: 34.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RecruiterHeader extends StatelessWidget {
  const _RecruiterHeader({required this.onProfileTap});

  final VoidCallback onProfileTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onProfileTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 41.r,
            height: 41.r,
            decoration: BoxDecoration(
              color: const Color(0xFFFF1F14),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.splashAccentColor, width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              'M',
              style: TextStyle(
                color: const Color(0xFFFFD200),
                fontSize: 25.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        SizedBox(width: 9.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'McDonnald',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'welcome to GeniusRX',
                style: TextStyle(color: AppColors.whiteColor, fontSize: 9.sp),
              ),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              Icons.notifications_none,
              color: AppColors.whiteColor,
              size: 25.r,
            ),
            Positioned(
              right: -1.w,
              top: -3.h,
              child: CircleAvatar(
                radius: 6.r,
                backgroundColor: AppColors.accentRed,
                child: Text(
                  '0',
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 7.sp),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RecruiterStatCard extends StatelessWidget {
  const _RecruiterStatCard({
    required this.title,
    required this.value,
    this.onViewAll,
  });

  final String title;
  final String value;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 204.h,
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(11.r),
        border: Border.all(color: AppColors.accentPurple, width: 1.w),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 9.h),
          Text(
            value,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 21.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 14.h),
          SizedBox(
            width: 95.w,
            height: 29.h,
            child: ElevatedButton(
              onPressed: onViewAll,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentPurple,
                foregroundColor: AppColors.whiteColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
              child: Text(
                'View all',
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Month + year picker shown when tapping the analytics month button.
class _MonthPickerDialog extends StatefulWidget {
  const _MonthPickerDialog({required this.initial});

  final DateTime initial;

  @override
  State<_MonthPickerDialog> createState() => _MonthPickerDialogState();
}

class _MonthPickerDialogState extends State<_MonthPickerDialog> {
  static const _shortMonths = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  late int _year = widget.initial.year;
  late int _month = widget.initial.month;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.blackColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: const BorderSide(color: AppColors.accentPurple),
      ),
      child: Padding(
        padding: EdgeInsets.all(18.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                _ArrowButton(
                  icon: Icons.chevron_left,
                  onTap: () => setState(() => _year--),
                ),
                Expanded(
                  child: Text(
                    '$_year',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _ArrowButton(
                  icon: Icons.chevron_right,
                  onTap: () => setState(() => _year++),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.w,
              childAspectRatio: 1.6,
              children: List.generate(12, (index) {
                final monthNo = index + 1;
                final selected = monthNo == _month;
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _month = monthNo),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.accentPurple
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.cardBorderColor),
                    ),
                    child: Text(
                      _shortMonths[index],
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 12.sp,
                        fontWeight:
                            selected ? FontWeight.w700 : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 18.h),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppColors.lightHintColor,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pop(DateTime(_year, _month)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentPurple,
                      foregroundColor: AppColors.whiteColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Apply',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onTap,
    child: Container(
      width: 36.r,
      height: 36.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.cardBorderColor),
      ),
      child: Icon(icon, color: AppColors.whiteColor, size: 22.r),
    ),
  );
}

class _RecruiterAnalyticsChart extends StatelessWidget {
  const _RecruiterAnalyticsChart();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RecruiterAnalyticsPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _RecruiterAnalyticsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final labelStyle = TextStyle(color: AppColors.whiteColor, fontSize: 9.sp);
    final axisPaint = Paint()
      ..color = AppColors.whiteColor.withValues(alpha: 0.18)
      ..strokeWidth = 1;
    final baselinePaint = Paint()
      ..color = AppColors.whiteColor.withValues(alpha: 0.55)
      ..strokeWidth = 1;
    final barPaint = Paint()
      ..shader = const LinearGradient(
        colors: [AppColors.accentPurple, Color(0xFF2F2F2F)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 20, size.width, size.height - 50));

    const left = 28.0;
    final top = 5.h;
    final bottom = size.height - 40.h;
    final chartHeight = bottom - top;
    const maxValue = 25.0;
    const yValues = [25, 20, 15, 10, 5];

    for (final value in yValues) {
      final y = top + chartHeight * (1 - value / maxValue);
      _drawText(canvas, value.toString(), Offset(9.w, y - 6.h), labelStyle);
      _drawDashedLine(
        canvas,
        Offset(left, y),
        Offset(size.width - 6.w, y),
        axisPaint,
      );
    }

    canvas.drawLine(
      Offset(left, bottom),
      Offset(size.width - 6.w, bottom),
      baselinePaint,
    );

    final bars = [
      (label: '7', value: 17.0),
      (label: '15', value: 23.0),
      (label: '23', value: 20.0),
      (label: '', value: 24.0),
    ];
    final centers = [74.w, 150.w, 226.w, 302.w];
    final barWidth = 43.w;

    for (var i = 0; i < bars.length; i++) {
      final barHeight = chartHeight * (bars[i].value / maxValue);
      final rect = Rect.fromLTWH(
        centers[i] - barWidth / 2,
        bottom - barHeight,
        barWidth,
        barHeight,
      );
      final radius = Radius.circular(20.r);
      canvas.drawRRect(
        RRect.fromRectAndCorners(rect, topLeft: radius, topRight: radius),
        barPaint,
      );
      if (bars[i].label.isNotEmpty) {
        _drawText(
          canvas,
          bars[i].label,
          Offset(centers[i] - 4.w, bottom + 16.h),
          labelStyle,
        );
      }
    }

    _drawText(canvas, 'Date', Offset(9.w, bottom + 16.h), labelStyle);
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashWidth = 2.0;
    const dashSpace = 3.0;
    var x = start.dx;
    while (x < end.dx) {
      canvas.drawLine(
        Offset(x, start.dy),
        Offset((x + dashWidth).clamp(start.dx, end.dx), end.dy),
        paint,
      );
      x += dashWidth + dashSpace;
    }
  }

  void _drawText(Canvas canvas, String text, Offset offset, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
