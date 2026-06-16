import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/home_bottom_bar.dart';
import '../widgets/home_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _searchController = TextEditingController();
  String _query = '';

  static const _allJobs = [
    'McDonald',
    'Starbucks',
    'Google',
    'Amazon',
    'Microsoft',
    'Netflix',
  ];

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
      bottomNavigationBar: HomeBottomBar(
        currentIndex: _currentIndex,
        onChanged: (index) => setState(() => _currentIndex = index),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              SizedBox(height: 26.h),
              HomeSearchField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                onClear: () {
                  _searchController.clear();
                  setState(() => _query = '');
                },
              ),
              SizedBox(height: 22.h),
              if (jobs.isEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: Center(
                    child: Text(
                      'No results for "$_query"',
                      style: TextStyle(color: Colors.white, fontSize: 13.sp),
                    ),
                  ),
                )
              else ...[
                const HomeSectionTitle('Matches with your skills'),
                SizedBox(height: 18.h),
                SizedBox(
                  height: 260.h,
                  child: ListView.separated(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    itemCount: jobs.length,
                    separatorBuilder: (_, index) => SizedBox(width: 12.w),
                    itemBuilder: (_, index) => SizedBox(
                      width: 268.w,
                      child: HomeJobCard(title: jobs[index], compact: true),
                    ),
                  ),
                ),
                SizedBox(height: 22.h),
                const HomeSectionTitle("Top company's"),
                SizedBox(height: 16.h),
                ...jobs.map(
                  (job) => Padding(
                    padding: EdgeInsets.only(bottom: 14.h),
                    child: HomeJobCard(title: job),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
