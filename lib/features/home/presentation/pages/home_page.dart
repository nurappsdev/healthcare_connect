import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helpers/prefs_helper.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_constant.dart';
import '../../../auth/presentation/pages/signup_page.dart';
import '../../../recruiter/presentation/pages/company_profile_page.dart';
import '../../../recruiter/presentation/pages/recruiter_jobs_page.dart';
import '../../../recruiter/presentation/pages/recruiters_home_screen.dart';
import 'ats_checker_page.dart';
import 'jobs_page.dart';
import 'message_page.dart';
import '../widgets/home_bottom_bar.dart';
import '../widgets/home_widgets.dart';
import '../widgets/job_apply_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({this.isRecruiter = false, super.key});

  final bool isRecruiter;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _searchController = TextEditingController();
  String _query = '';
  late bool _isRecruiter = widget.isRecruiter;

  static const _allJobs = [
    'McDonald',
    'Starbucks',
    'Google',
    'Amazon',
    'Microsoft',
    'Netflix',
  ];

  static const _recruiterBottomItems = [
    Icons.home_outlined,
    Icons.message_outlined,
    Icons.work_outline,
    Icons.person_outline,
  ];

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    try {
      final roleName = await PrefsHelper.getString(AppConstants.role);
      if (!mounted) return;
      final savedIsRecruiter =
          SignupRoleX.fromName(roleName)?.isRecruiter ?? false;
      setState(() => _isRecruiter = widget.isRecruiter || savedIsRecruiter);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isRecruiter = widget.isRecruiter);
    }
  }

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
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      bottomNavigationBar: HomeBottomBar(
        currentIndex: _currentIndex,
        onChanged: (index) => setState(() => _currentIndex = index),
        items: _isRecruiter
            ? _recruiterBottomItems
            : HomeBottomBar.defaultItems,
      ),
      body: switch (_currentIndex) {
        1 => _isRecruiter ? const MessagePage() : const AtsCheckerPage(),
        2 => _isRecruiter ? const RecruiterJobsPage() : const JobsPage(),
        3 => _isRecruiter ? const CompanyProfilePage() : const MessagePage(),
        _ => _isRecruiter ? const RecruitersHomeScreen() : _buildHomeBody(),
      },
    );
  }

  Widget _buildHomeBody() {
    final jobs = _jobs;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(onProfileTap: () => context.push(AppRoutes.userProfile)),
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
                    child: HomeJobCard(
                      title: jobs[index],
                      compact: true,
                      onTap: () => context.push(
                        AppRoutes.jobDetails,
                        extra: jobs[index],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 22.h),
              HomeSectionTitle(
                "Top company's",
                onViewMore: () =>
                    context.push(AppRoutes.findJob, extra: _allJobs),
              ),
              SizedBox(height: 16.h),
              ...jobs.map(
                (job) => Padding(
                  padding: EdgeInsets.only(bottom: 14.h),
                  child: HomeJobCard(
                    title: job,
                    onTap: () => context.push(AppRoutes.jobDetails, extra: job),
                    onApply: () => showJobApplyDialog(context),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
