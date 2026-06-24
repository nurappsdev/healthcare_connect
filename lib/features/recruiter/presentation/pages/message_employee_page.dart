import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import 'applied_candidates_page.dart';

const _white = AppColors.whiteColor;
const _border = AppColors.cardBorderColor;
const _purple = AppColors.accentPurple;
const _teal = AppColors.accentTeal;
const _muted = AppColors.lightHintColor;

/// Arguments for [MessageEmployeePage]. Pass [candidate] to message a single
/// shortlisted person, or [selected] to message a batch chosen via "Select all".
class MessageEmployeeArgs {
  const MessageEmployeeArgs({this.candidate, this.selected = const []});

  final AppliedCandidate? candidate;
  final List<AppliedCandidate> selected;
}

/// Recruiter "Message employee" screen: compose a message and pick an
/// interview date for a single candidate or a batch of selected candidates.
class MessageEmployeePage extends StatefulWidget {
  const MessageEmployeePage({this.args = const MessageEmployeeArgs(), super.key});

  final MessageEmployeeArgs args;

  @override
  State<MessageEmployeePage> createState() => _MessageEmployeePageState();
}

class _MessageEmployeePageState extends State<MessageEmployeePage> {
  final _messageController = TextEditingController();
  DateTime _interviewDate = DateTime(2026, 6, 3);

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _interviewDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) setState(() => _interviewDate = picked);
  }

  String get _formattedDate {
    String two(int v) => v.toString().padLeft(2, '0');
    return '${two(_interviewDate.day)} – ${two(_interviewDate.month)} – '
        '${_interviewDate.year}';
  }

  @override
  Widget build(BuildContext context) {
    final candidate = widget.args.candidate;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            _Header(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (candidate != null)
                      _CandidateCard(candidate: candidate)
                    else
                      _SelectionSummary(count: widget.args.selected.length),
                    SizedBox(height: 22.h),
                    Text(
                      'Message',
                      style: TextStyle(
                        color: _white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      height: 230.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: _border),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: TextField(
                        controller: _messageController,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        style: TextStyle(color: _white, fontSize: 13.sp),
                        cursorColor: _purple,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText: 'Write here...',
                          hintStyle: TextStyle(color: _muted, fontSize: 13.sp),
                        ),
                      ),
                    ),
                    SizedBox(height: 22.h),
                    Text(
                      'Interview date',
                      style: TextStyle(
                        color: _white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _pickDate,
                      child: Container(
                        height: 54.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: _border),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _formattedDate,
                                style: TextStyle(
                                  color: _white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.calendar_month_outlined,
                              color: _white,
                              size: 22.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _SendBar(onSend: () {}),
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
                'Message employee',
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

class _SelectionSummary extends StatelessWidget {
  const _SelectionSummary({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: BoxDecoration(
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Text(
            'Totlal selected candiate : $count',
            style: TextStyle(
              color: _white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'if you need see the candidates',
            style: TextStyle(color: _muted, fontSize: 10.sp),
          ),
          SizedBox(height: 14.h),
          SizedBox(
            width: double.infinity,
            height: 46.h,
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).maybePop(),
              style: OutlinedButton.styleFrom(
                foregroundColor: _white,
                side: const BorderSide(color: _purple),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.r),
                ),
              ),
              child: Text(
                'See all candidate',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CandidateCard extends StatelessWidget {
  const _CandidateCard({required this.candidate});

  final AppliedCandidate candidate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
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
                      style: TextStyle(color: _muted, fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  border: Border.all(color: _teal),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'Details',
                  style: TextStyle(color: _teal, fontSize: 12.sp),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          _MatchBar(percent: candidate.matchPercent),
        ],
      ),
    );
  }
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

class _SendBar extends StatelessWidget {
  const _SendBar({required this.onSend});

  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
      child: SizedBox(
        height: 52.h,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onSend,
          style: ElevatedButton.styleFrom(
            backgroundColor: _purple,
            foregroundColor: _white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.r),
            ),
          ),
          child: Text(
            'Send',
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
