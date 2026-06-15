import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/home_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final jobs = List.generate(4, (_) => 'McDonald');

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
              const HomeSearchField(),
              SizedBox(height: 22.h),
              const HomeSectionTitle('Matches with your skills'),
              SizedBox(height: 18.h),
              SizedBox(
                height: 260.h,
                child: ListView.separated(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
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
          ),
        ),
      ),
    );
  }
}
