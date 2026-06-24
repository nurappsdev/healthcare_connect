import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import 'applied_candidates_page.dart';
import 'message_employee_page.dart';

const _white = AppColors.whiteColor;
const _border = AppColors.cardBorderColor;
const _purple = AppColors.accentPurple;
const _teal = AppColors.accentTeal;

/// Recruiter "Shortlisted candidate" screen: the candidates a recruiter has
/// shortlisted for a posted job, reached from the "Shortlisted = N" pill.
class ShortlistedCandidatesPage extends StatefulWidget {
  const ShortlistedCandidatesPage({
    this.candidates = _demoCandidates,
    super.key,
  });

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
  ];

  @override
  State<ShortlistedCandidatesPage> createState() =>
      _ShortlistedCandidatesPageState();
}

class _ShortlistedCandidatesPageState extends State<ShortlistedCandidatesPage> {
  final Set<int> _selected = {};

  bool get _allSelected =>
      widget.candidates.isNotEmpty &&
      _selected.length == widget.candidates.length;

  void _toggleSelectAll() {
    setState(() {
      if (_allSelected) {
        _selected.clear();
      } else {
        _selected
          ..clear()
          ..addAll(List.generate(widget.candidates.length, (i) => i));
      }
    });
  }

  void _toggleOne(int index) {
    setState(() {
      if (!_selected.remove(index)) _selected.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final candidates = widget.candidates;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 6.h, 20.w, 12.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Total candidate : '
                      '${candidates.length.toString().padLeft(2, '0')}',
                      style: TextStyle(color: _white, fontSize: 12.sp),
                    ),
                  ),
                  _SelectAll(value: _allSelected, onToggle: _toggleSelectAll),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
                itemCount: candidates.length,
                separatorBuilder: (_, _) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final candidate = candidates[index];
                  return _CandidateCard(
                    candidate: candidate,
                    selected: _selected.contains(index),
                    onSelectChanged: () => _toggleOne(index),
                    onTap: () => context.push(
                      AppRoutes.messageEmployee,
                      extra: MessageEmployeeArgs(candidate: candidate),
                    ),
                    onDetails: () => context.push(
                      AppRoutes.seeResume,
                      extra: candidate.name,
                    ),
                  );
                },
              ),
            ),
            _NextBar(
              onNext: () {
                final selected = _selected.toList()..sort();
                context.push(
                  AppRoutes.messageEmployee,
                  extra: MessageEmployeeArgs(
                    selected: [for (final i in selected) candidates[i]],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectAll extends StatelessWidget {
  const _SelectAll({required this.value, required this.onToggle});

  final bool value;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onToggle,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select all',
            style: TextStyle(color: _white, fontSize: 12.sp),
          ),
          SizedBox(width: 8.w),
          _CheckBox(value: value),
        ],
      ),
    );
  }
}

class _CheckBox extends StatelessWidget {
  const _CheckBox({required this.value});

  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.r,
      width: 20.r,
      decoration: BoxDecoration(
        color: value ? _purple : Colors.transparent,
        border: Border.all(color: value ? _purple : _border),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: value ? Icon(Icons.check, color: _white, size: 14.r) : null,
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
                'Shortlisted candidate',
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
  const _CandidateCard({
    required this.candidate,
    required this.selected,
    required this.onSelectChanged,
    required this.onTap,
    required this.onDetails,
  });

  final AppliedCandidate candidate;
  final bool selected;
  final VoidCallback onSelectChanged;
  final VoidCallback onTap;
  final VoidCallback onDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: AppColors.blackColor,
          border: Border.all(color: selected ? _purple : _border),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onSelectChanged,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: _CheckBox(value: selected),
                  ),
                ),
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
        border: Border.all(color: _teal),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        'Details',
        style: TextStyle(color: _teal, fontSize: 12.sp),
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

class _NextBar extends StatelessWidget {
  const _NextBar({required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
      child: SizedBox(
        height: 52.h,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: _purple,
            foregroundColor: _white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.r),
            ),
          ),
          child: Text(
            'Next',
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
