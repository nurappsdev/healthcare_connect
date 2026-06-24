import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

const _white = AppColors.whiteColor;
const _purple = AppColors.accentPurple;
const _border = AppColors.cardBorderColor;

// Resume-specific palette (the printed-CV look from the design).
const _sidebar = Color(0xFF2E3142);
const _ink = Color(0xFF2E3142);
const _muted = Color(0xFF8A8A8A);
const _hairline = Color(0xFFE2E2E2);

/// Recruiter "See resume" screen: a printed-style CV preview for an applied
/// candidate, reached from the Details button on the Applied candidate list.
class SeeResumePage extends StatelessWidget {
  const SeeResumePage({this.candidateName = 'Mariana Anderson', super.key});

  final String candidateName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            _Header(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 16.h),
                child: _ResumeCard(name: candidateName),
              ),
            ),
            _BottomBar(
              onShortlist: () {},
              onViewProfile: () => context.push(
                AppRoutes.candidateProfile,
                extra: candidateName,
              ),
            ),
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
                'See resume',
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

class _ResumeCard extends StatelessWidget {
  const _ResumeCard({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(width: 130.w, child: const _Sidebar()),
            Expanded(child: _MainColumn(name: name)),
          ],
        ),
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _sidebar,
      padding: EdgeInsets.fromLTRB(14.w, 18.h, 12.w, 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 34.r,
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, color: _white, size: 38.r),
            ),
          ),
          SizedBox(height: 22.h),
          const _SidebarHeading('Contact'),
          _SidebarField(label: 'Phone', value: '123-456-7890'),
          _SidebarField(label: 'Email', value: 'hello@reallygreatsite.com'),
          _SidebarField(
            label: 'Address',
            value: '123 Anywhere St., Any City',
          ),
          SizedBox(height: 18.h),
          const _SidebarHeading('Education'),
          _SidebarField(
            label: '2008',
            value: 'Enter Your Degree\nUniversity/College',
          ),
          _SidebarField(
            label: '2008',
            value: 'Enter Your Degree\nUniversity/College',
          ),
          SizedBox(height: 18.h),
          const _SidebarHeading('Expertise'),
          ...const [
            'UI/UX',
            'Visual Design',
            'Wireframes',
            'Storyboards',
            'User Flows',
            'Process Flows',
          ].map((e) => _Bullet(e)),
          SizedBox(height: 18.h),
          const _SidebarHeading('Language'),
          SizedBox(height: 6.h),
          Text('English', style: _sidebarValueStyle()),
          SizedBox(height: 4.h),
          Text('Spanish', style: _sidebarValueStyle()),
        ],
      ),
    );
  }
}

TextStyle _sidebarValueStyle() =>
    TextStyle(color: Colors.white70, fontSize: 7.5.sp, height: 1.3);

class _SidebarHeading extends StatelessWidget {
  const _SidebarHeading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 6.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            color: _white,
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.h),
        Container(height: 1, color: Colors.white24),
      ],
    ),
  );
}

class _SidebarField extends StatelessWidget {
  const _SidebarField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: _white,
            fontSize: 8.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 1.h),
        Text(value, style: _sidebarValueStyle()),
      ],
    ),
  );
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 3.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('• ', style: _sidebarValueStyle()),
        Expanded(child: Text(text, style: _sidebarValueStyle())),
      ],
    ),
  );
}

class _MainColumn extends StatelessWidget {
  const _MainColumn({required this.name});

  final String name;

  static const _summary =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam '
      'pharetra in lorem at laoreet. Donec hendrerit libero eget est tempus, '
      'quis congue arcu elementum.';

  @override
  Widget build(BuildContext context) {
    final parts = name.split(' ');
    final first = parts.first;
    final rest = parts.length > 1 ? ' ${parts.sublist(1).join(' ')}' : '';
    return Container(
      color: _white,
      padding: EdgeInsets.fromLTRB(14.w, 18.h, 14.w, 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: first,
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: rest,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            style: TextStyle(color: _ink, fontSize: 16.sp),
          ),
          SizedBox(height: 2.h),
          Text(
            'MARKETING MANAGER',
            style: TextStyle(
              color: _muted,
              fontSize: 9.sp,
              letterSpacing: 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _summary,
            style: TextStyle(color: _muted, fontSize: 7.5.sp, height: 1.4),
          ),
          SizedBox(height: 16.h),
          const _SectionTitle('Experience'),
          _Experience(range: '2019 - 2022'),
          _Experience(range: '2017 - 2019'),
          _Experience(range: '2015 - 2017'),
          SizedBox(height: 10.h),
          const _SectionTitle('Reference'),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(child: _Reference()),
              SizedBox(width: 12),
              Expanded(child: _Reference()),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            color: _ink,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.h),
        Container(height: 1, color: _hairline),
      ],
    ),
  );
}

class _Experience extends StatelessWidget {
  const _Experience({required this.range});

  final String range;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          range,
          style: TextStyle(
            color: _ink,
            fontSize: 8.5.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Company Name | 123 Anywhere St., Any City',
          style: TextStyle(color: _muted, fontSize: 7.sp),
        ),
        SizedBox(height: 3.h),
        Text(
          'Job position here',
          style: TextStyle(
            color: _ink,
            fontSize: 8.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam '
          'pharetra in lorem at laoreet. Donec hendrerit libero eget est '
          'tempus, quis congue arcu elementum.',
          style: TextStyle(color: _muted, fontSize: 7.sp, height: 1.4),
        ),
      ],
    ),
  );
}

class _Reference extends StatelessWidget {
  const _Reference();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Name Surname',
        style: TextStyle(
          color: _ink,
          fontSize: 8.5.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      SizedBox(height: 1.h),
      Text(
        'Job position, Company Name',
        style: TextStyle(color: _muted, fontSize: 7.sp),
      ),
      SizedBox(height: 4.h),
      Text(
        'Phone : 123-456-7890',
        style: TextStyle(color: _muted, fontSize: 7.sp),
      ),
      SizedBox(height: 1.h),
      Text(
        'Email : hello@reallygreatsite.com',
        style: TextStyle(color: _muted, fontSize: 7.sp),
      ),
    ],
  );
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.onShortlist, required this.onViewProfile});

  final VoidCallback onShortlist;
  final VoidCallback onViewProfile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 52.h,
              child: OutlinedButton(
                onPressed: onShortlist,
                style: OutlinedButton.styleFrom(
                  foregroundColor: _white,
                  side: const BorderSide(color: _border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                ),
                child: Text(
                  'Shortlist',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: SizedBox(
              height: 52.h,
              child: ElevatedButton(
                onPressed: onViewProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _purple,
                  foregroundColor: _white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'View profile details',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(Icons.chevron_right, size: 20.r),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
