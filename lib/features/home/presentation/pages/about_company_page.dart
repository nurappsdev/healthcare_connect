import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/job_apply_dialog.dart';

class AboutCompanyPage extends StatelessWidget {
  const AboutCompanyPage({required this.companyName, super.key});

  final String companyName;

  static const _cultureBullets = [
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
                        'About company',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.r),
                ],
              ),
              SizedBox(height: 36.h),
              Row(
                children: [
                  const _CompanyLogo(size: 38),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        companyName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 7.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                            size: 12.r,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Jakarta, Indonesia - On site',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 34.h),
              const _IconInfoRow(
                icon: Icons.person_outline,
                text: '250 Employees',
              ),
              SizedBox(height: 18.h),
              const _IconInfoRow(
                icon: Icons.groups_outlined,
                text: 'Food service',
              ),
              SizedBox(height: 26.h),
              _SectionTitle('About McDonald'),
              SizedBox(height: 14.h),
              Text(
                'Lorem ipsum dolor sit amet consectetur ut sagittis arcu nunc '
                'commodo morbi sem aliquet. Lorem ipsum dolor sit amet '
                'consectetur ut sagittis arcu nunc commodo morbi sem aliquet. '
                'Lorem ipsum dolor sit amet consectetur ut sagittis arcu nunc '
                'commodo morbi sem aliquet.',
                style: _bodyStyle,
              ),
              SizedBox(height: 26.h),
              _SectionTitle('Company culture'),
              SizedBox(height: 14.h),
              const _BulletList(items: _cultureBullets),
              SizedBox(height: 26.h),
              _SectionTitle('Website and social media'),
              SizedBox(height: 22.h),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _SocialButton(
                    color: Colors.white,
                    icon: Icons.language,
                    iconColor: Color(0xFF828282),
                  ),
                  _SocialButton(color: Color(0xFF1877F2), label: 'f'),
                  _SocialButton(color: Color(0xFF1DA1F2), label: 't'),
                  _SocialButton(
                    color: Color(0xFFF6039B),
                    icon: Icons.camera_alt_outlined,
                  ),
                  _SocialButton(color: Color(0xFF0A66C2), label: 'in'),
                ],
              ),
              SizedBox(height: 28.h),
              _SectionTitle('Current openings'),
              SizedBox(height: 16.h),
              _OpeningCard(companyName: companyName),
              SizedBox(height: 14.h),
              _OpeningCard(companyName: companyName),
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

class _IconInfoRow extends StatelessWidget {
  const _IconInfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: Colors.white, size: 15.r),
      SizedBox(width: 18.w),
      Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 10.sp),
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
      color: Colors.white,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
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

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.color,
    this.icon,
    this.iconColor = Colors.white,
    this.label,
  });

  final Color color;
  final IconData? icon;
  final Color iconColor;
  final String? label;

  @override
  Widget build(BuildContext context) => Container(
    height: 48.r,
    width: 48.r,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    alignment: Alignment.center,
    child: icon != null
        ? Icon(icon, color: iconColor, size: 25.r)
        : Text(
            label!,
            style: TextStyle(
              color: Colors.white,
              fontSize: label == 'in' ? 18.sp : 30.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
  );
}

class _OpeningCard extends StatelessWidget {
  const _OpeningCard({required this.companyName});

  final String companyName;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(18.r),
    decoration: BoxDecoration(
      color: Colors.black,
      border: Border.all(color: AppColors.cardBorderColor),
      borderRadius: BorderRadius.circular(18.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
                  SizedBox(height: 3.h),
                  Text(
                    'Jakarta - Indonesia',
                    style: TextStyle(color: Colors.white, fontSize: 9.sp),
                  ),
                ],
              ),
            ),
            Icon(Icons.attach_money, color: Colors.white, size: 16.r),
            SizedBox(width: 6.w),
            Text(
              '12, 000',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        Wrap(
          spacing: 6.w,
          runSpacing: 6.h,
          children: const [
            _SkillChip('Team work'),
            _SkillChip('Critical thinking'),
            _SkillChip('Analytics skill'),
            _SkillChip('+5 more'),
          ],
        ),
        SizedBox(height: 14.h),
        Text(
          'Lorem ipsum dolor sit amet consectetur ut sagittis arcu nunc '
          'commodo morbi sem aliquet. Lorem ipsum dolor sit amet '
          'consectetur ut sagittis arcu nunc commodo morbi sem aliqu...',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white, fontSize: 9.sp, height: 1.45),
        ),
        SizedBox(height: 12.h),
        Row(
          children: ['On Site', 'Full time'].map((text) {
            return Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Text(
                text,
                style: TextStyle(
                  color: AppColors.splashAccentColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 14.h),
        Row(
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
      ],
    ),
  );
}

class _SkillChip extends StatelessWidget {
  const _SkillChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.cardBorderColor),
    ),
    child: Text(
      label,
      style: TextStyle(color: Colors.white, fontSize: 8.sp),
    ),
  );
}
