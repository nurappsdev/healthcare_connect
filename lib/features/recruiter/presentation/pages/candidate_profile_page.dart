import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

const _white = AppColors.whiteColor;
const _border = AppColors.cardBorderColor;
const _purple = AppColors.accentPurple;
const _muted = AppColors.lightHintColor;

/// Recruiter "Profile Information" screen: a read-only view of a candidate's
/// full profile, reached from "View profile details" on the resume preview.
class CandidateProfilePage extends StatefulWidget {
  const CandidateProfilePage({
    this.name = 'David',
    this.title = 'Carpenter expert',
    super.key,
  });

  final String name;
  final String title;

  @override
  State<CandidateProfilePage> createState() => _CandidateProfilePageState();
}

class _CandidateProfilePageState extends State<CandidateProfilePage> {
  bool _bioOpen = false;
  bool _contactOpen = true;

  static const _skills = [
    'Team work',
    'Critical thinking',
    'Analytics skill',
    'Adaptability',
    'Analytics skill',
    'Adaptability',
    'Team work',
  ];

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
                padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40.r,
                            backgroundColor: AppColors.darkCardColor,
                            child: Icon(
                              Icons.person,
                              color: _white,
                              size: 44.r,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            widget.name,
                            style: TextStyle(
                              color: _white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            widget.title,
                            style: TextStyle(color: _muted, fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _ExpandableRow(
                      title: 'Short bio about ${widget.name}',
                      open: _bioOpen,
                      onToggle: () => setState(() => _bioOpen = !_bioOpen),
                      child: Text(
                        'Experienced carpenter with a passion for precise, '
                        'durable craftsmanship across residential and '
                        'commercial projects.',
                        style: TextStyle(
                          color: _muted,
                          fontSize: 12.sp,
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    _ExpandableRow(
                      title: 'Contact information',
                      open: _contactOpen,
                      onToggle: () =>
                          setState(() => _contactOpen = !_contactOpen),
                      child: _ContactCard(),
                    ),
                    SizedBox(height: 22.h),
                    _SectionTitle('Experience'),
                    SizedBox(height: 12.h),
                    _ExperienceCard(),
                    SizedBox(height: 12.h),
                    _ExperienceCard(),
                    SizedBox(height: 22.h),
                    _SectionTitle('Education'),
                    SizedBox(height: 12.h),
                    _EducationCard(),
                    SizedBox(height: 22.h),
                    _SectionTitle('Skills'),
                    SizedBox(height: 12.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: _skills.map((s) => _SkillChip(s)).toList(),
                    ),
                    SizedBox(height: 22.h),
                    _SectionTitle('RESUME'),
                    SizedBox(height: 12.h),
                    _FileCard(
                      fileName: 'Resume for carpentars.pdf',
                      meta: '1.2 Mb 3 Jun 2026 at 10 : 43 AM',
                    ),
                    SizedBox(height: 22.h),
                    _SectionTitle('Certificate'),
                    SizedBox(height: 12.h),
                    _FileCard(
                      fileName: 'Certificate.pdf',
                      meta: '1.2 Mb 3 Jun 2026 at 10 : 43 AM',
                    ),
                  ],
                ),
              ),
            ),
            _MessageBar(onMessage: () {}),
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
                'Profile Information',
                style: TextStyle(
                  color: _white,
                  fontSize: 18.sp,
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

class _ExpandableRow extends StatelessWidget {
  const _ExpandableRow({
    required this.title,
    required this.open,
    required this.onToggle,
    required this.child,
  });

  final String title;
  final bool open;
  final VoidCallback onToggle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onToggle,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: _white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  open
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: _white,
                  size: 22.r,
                ),
              ],
            ),
          ),
        ),
        if (open)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: child,
          ),
      ],
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          _ContactRow(icon: Icons.phone_outlined, text: '+880 03939443'),
          SizedBox(height: 12.h),
          _ContactRow(icon: Icons.mail_outline, text: 'abc@gmail.com'),
          SizedBox(height: 12.h),
          _ContactRow(
            icon: Icons.link,
            text: 'linkedin profile link',
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: _white, size: 18.r),
      SizedBox(width: 12.w),
      Expanded(
        child: Text(
          text,
          style: TextStyle(color: _white, fontSize: 12.sp),
        ),
      ),
    ],
  );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      color: _white,
      fontSize: 15.sp,
      fontWeight: FontWeight.w700,
    ),
  );
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard();

  @override
  Widget build(BuildContext context) {
    return _OutlinedCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Logo(),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'McDonnald',
                  style: TextStyle(color: _muted, fontSize: 11.sp),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Carpenter Specialist',
                  style: TextStyle(
                    color: _white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                _IconLine(
                  icon: Icons.location_on_outlined,
                  text: 'Jakarta, Indonesia - On site',
                ),
                SizedBox(height: 6.h),
                _IconLine(
                  icon: Icons.calendar_today_outlined,
                  text: 'Dec 2024 to Feb 2026 - 1 year 2 months',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  const _EducationCard();

  @override
  Widget build(BuildContext context) {
    return _OutlinedCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Logo(),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Civil engineering',
                  style: TextStyle(
                    color: _white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'University name here',
                  style: TextStyle(color: _muted, fontSize: 11.sp),
                ),
                SizedBox(height: 8.h),
                _IconLine(
                  icon: Icons.location_on_outlined,
                  text: 'Jakarta, Indonesia',
                ),
                SizedBox(height: 6.h),
                _IconLine(
                  icon: Icons.calendar_today_outlined,
                  text: 'Jan 2021 to Feb 2024 - 4 years',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IconLine extends StatelessWidget {
  const _IconLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: _muted, size: 14.r),
      SizedBox(width: 6.w),
      Expanded(
        child: Text(
          text,
          style: TextStyle(color: _muted, fontSize: 11.sp),
        ),
      ),
    ],
  );
}

class _FileCard extends StatelessWidget {
  const _FileCard({required this.fileName, required this.meta});

  final String fileName;
  final String meta;

  @override
  Widget build(BuildContext context) {
    return _OutlinedCard(
      child: Row(
        children: [
          Container(
            height: 34.r,
            width: 34.r,
            decoration: BoxDecoration(
              color: AppColors.accentRed,
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: Text(
              'PDF',
              style: TextStyle(
                color: _white,
                fontSize: 8.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: TextStyle(
                    color: _white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  meta,
                  style: TextStyle(color: _muted, fontSize: 10.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OutlinedCard extends StatelessWidget {
  const _OutlinedCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.r),
    decoration: BoxDecoration(
      border: Border.all(color: _border),
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: child,
  );
}

class _SkillChip extends StatelessWidget {
  const _SkillChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
    decoration: BoxDecoration(
      border: Border.all(color: _border),
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Text(
      label,
      style: TextStyle(color: _white, fontSize: 11.sp),
    ),
  );
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

class _MessageBar extends StatelessWidget {
  const _MessageBar({required this.onMessage});

  final VoidCallback onMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 16.h),
      child: SizedBox(
        height: 52.h,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onMessage,
          style: ElevatedButton.styleFrom(
            backgroundColor: _purple,
            foregroundColor: _white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.r),
            ),
          ),
          child: Text(
            'Message',
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
