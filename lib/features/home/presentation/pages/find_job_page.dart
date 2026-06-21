import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/home_widgets.dart';

/// Full listing of top companies, reached from the "View More" action of the
/// home screen's "Top company's" section.
class FindJobPage extends StatefulWidget {
  const FindJobPage({this.jobs, super.key});

  /// Optional list of company names passed from the home screen. Falls back to
  /// a default set when navigated to directly.
  final List<String>? jobs;

  @override
  State<FindJobPage> createState() => _FindJobPageState();
}

class _FindJobPageState extends State<FindJobPage> {
  static const _fallbackJobs = [
    'McDonald',
    'Starbucks',
    'Google',
    'Amazon',
    'Microsoft',
    'Netflix',
  ];

  final _searchController = TextEditingController();
  String _query = '';

  late final List<String> _allJobs = widget.jobs == null || widget.jobs!.isEmpty
      ? _fallbackJobs
      : widget.jobs!;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<String> get _jobs {
    if (_query.isEmpty) return _allJobs;
    final q = _query.toLowerCase();
    return _allJobs.where((job) => job.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final jobs = _jobs;

    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24.r,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Text(
                    'Find a new job',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 22.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: HomeSearchField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                onClear: () {
                  _searchController.clear();
                  setState(() => _query = '');
                },
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: jobs.isEmpty
                  ? Center(
                      child: Text(
                        'No results for "$_query"',
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 24.h),
                      itemCount: jobs.length,
                      separatorBuilder: (_, _) => SizedBox(height: 14.h),
                      itemBuilder: (_, index) => HomeJobCard(title: jobs[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
