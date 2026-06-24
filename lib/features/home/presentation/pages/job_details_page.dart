import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/job_apply_dialog.dart';

class JobDetailsPage extends StatelessWidget {
  const JobDetailsPage({required this.companyName, super.key});

  final String companyName;

  static const _skills = [
    'Team work',
    'Critical thinking',
    'Analytics skill',
    'Adaptability',
    'Analytics skill',
    'Adaptability',
    'Team work',
  ];

  static const _bullets = [
    'Proven experience as a Carpenter or in a similar role.',
    'Strong knowledge of carpentry methods, materials, and tools.',
    'Ability to read technical drawings and blueprints.',
    'Good physical stamina and manual dexterity.',
    'Attention to detail and problem-solving skills.',
    'Ability to work independently and as part of a team.',
    'Knowledge of workplace safety practices.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.fromLTRB(18.w, 8.h, 18.w, 14.h),
        child: Row(
          children: [
            SizedBox(
              height: 50.h,
              width: 70.w,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: AppColors.splashAccentColor,
                    width: 1.w,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Icon(
                  Icons.bookmark_border,
                  color: AppColors.splashAccentColor,
                  size: 23.r,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: SizedBox(
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () => showJobApplyDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentPurple,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  child: Text('Apply', style: TextStyle(fontSize: 13.sp)),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    behavior: HitTestBehavior.opaque,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20.r,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Job details',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.r),
                ],
              ),
              SizedBox(height: 34.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const _CompanyLogo(size: 38),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        companyName,
                        style: TextStyle(color: Colors.white, fontSize: 9.sp),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Carpenter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 28.h),
              const _IconTextRow(
                icon: Icons.location_on_outlined,
                text: 'Jakarta, Indonesia - On site',
              ),
              SizedBox(height: 14.h),
              const _IconTextRow(icon: Icons.attach_money, text: '12, 000'),
              SizedBox(height: 24.h),
              const _JobFactsRow(),
              SizedBox(height: 24.h),
              _SectionTitle('Must have skills'),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 6.w,
                runSpacing: 8.h,
                children: _skills.map((skill) => _SkillChip(skill)).toList(),
              ),
              SizedBox(height: 26.h),
              _SectionTitle('Job description'),
              SizedBox(height: 14.h),
              Text(
                'Lorem ipsum dolor sit amet consectetur ut sagittis arcu nunc '
                'commodo morbi sem aliquet. Lorem ipsum dolor sit amet '
                'consectetur ut sagittis arcu nunc commodo morbi sem aliquet. '
                'Lorem ipsum dolor sit amet consectetur ut sagittis arcu nunc '
                'commodo morbi sem aliquet.',
                style: _bodyStyle,
              ),
              SizedBox(height: 24.h),
              _SectionTitle('Responsibilities'),
              SizedBox(height: 12.h),
              const _BulletList(items: _bullets),
              SizedBox(height: 24.h),
              _SectionTitle('Requirements'),
              SizedBox(height: 12.h),
              const _BulletList(items: _bullets),
              SizedBox(height: 24.h),
              _SectionTitle('Benefits'),
              SizedBox(height: 12.h),
              const _BulletList(items: _bullets),
              SizedBox(height: 26.h),
              _SectionTitle('About the company'),
              SizedBox(height: 16.h),
              _CompanyRow(
                companyName: companyName,
                onTap: () =>
                    context.push(AppRoutes.aboutCompany, extra: companyName),
              ),
              SizedBox(height: 22.h),
              _SectionTitle('Office address'),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Jakarta, Indonesia - On site',
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                    ),
                  ),
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                    size: 22.r,
                  ),
                ],
              ),
              SizedBox(height: 26.h),
              Row(
                children: [
                  Icon(Icons.work_outline, color: Colors.white, size: 16.r),
                  SizedBox(width: 12.w),
                  Text(
                    'View more jobs about the company',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.sp,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle get _bodyStyle =>
      TextStyle(color: Colors.white, fontSize: 10.sp, height: 1.35);
}

class _CompanyLogo extends StatelessWidget {
  const _CompanyLogo({this.size = 34});

  final double size;

  @override
  Widget build(BuildContext context) => Container(
    height: size.r,
    width: size.r,
    decoration: BoxDecoration(
      color: const Color(0xFFFF1F14),
      borderRadius: BorderRadius.circular(9.r),
    ),
    alignment: Alignment.center,
    child: Text(
      'M',
      style: TextStyle(
        color: const Color(0xFFFFD200),
        fontSize: (size * 0.58).sp,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}

class _IconTextRow extends StatelessWidget {
  const _IconTextRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: Colors.white, size: 17.r),
      SizedBox(width: 14.w),
      Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 10.sp),
      ),
    ],
  );
}

class _JobFactsRow extends StatelessWidget {
  const _JobFactsRow();

  @override
  Widget build(BuildContext context) {
    const items = [
      ('Experience', '2-6 years'),
      ('Job type', 'Full time'),
      ('Level', 'Entry level'),
    ];

    return Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          Expanded(
            child: Column(
              children: [
                Text(
                  items[i].$1,
                  style: TextStyle(color: Colors.white, fontSize: 8.sp),
                ),
                SizedBox(height: 8.h),
                Text(
                  items[i].$2,
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          if (i != items.length - 1)
            Container(height: 42.h, width: 1.w, color: Colors.white),
        ],
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      color: Colors.white,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),
  );
}

class _SkillChip extends StatelessWidget {
  const _SkillChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.cardBorderColor),
    ),
    child: Text(
      label,
      style: TextStyle(color: Colors.white, fontSize: 8.sp),
    ),
  );
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: items
        .map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text(
              '- $item',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9.sp,
                height: 1.25,
              ),
            ),
          ),
        )
        .toList(),
  );
}

class _CompanyRow extends StatelessWidget {
  const _CompanyRow({required this.companyName, required this.onTap});

  final String companyName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10.r),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          const _CompanyLogo(size: 34),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 7.h),
                Text(
                  'Food business 200 - 300 employees',
                  style: TextStyle(color: Colors.white, fontSize: 9.sp),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.white, size: 22.r),
        ],
      ),
    ),
  );
}
