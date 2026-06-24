import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

const _white = AppColors.whiteColor;
const _border = AppColors.cardBorderColor;
const _muted = AppColors.lightHintColor;
const _teal = AppColors.accentTeal;

/// Recruiter "Profile" tab: the company's public profile (logo, contact,
/// about, culture, licenses and social links). Shown as the last bottom-bar
/// item for the recruiter role.
class CompanyProfilePage extends StatelessWidget {
  const CompanyProfilePage({super.key});

  static const _culture = [
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
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 96.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: 24.r),
                Expanded(
                  child: Center(
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        color: _white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Icon(Icons.settings_outlined, color: _white, size: 24.r),
              ],
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => context.push(AppRoutes.editCompanyProfile),
                child: _EditIcon(),
              ),
            ),
            Center(child: _CompanyHeader()),
            SizedBox(height: 16.h),
            _ContactCard(),
            SizedBox(height: 24.h),
            _SectionHeader(
              'About us',
              onEdit: () => context.push(
                AppRoutes.companyInfoEdit,
                extra: 'Write about your company',
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Lorem ipsum dolor sit amet consectetur ut sagittis arcu nunc '
              'commodo morbi sem aliquet. Lorem ipsum dolor sit amet '
              'consectetur ut sagittis arcu nunc commodo morbi sem aliquet. '
              'Lorem ipsum dolor sit amet consectetur ut sagittis arcu nunc '
              'commodo morbi sem aliquet.',
              style: TextStyle(color: _muted, fontSize: 11.sp, height: 1.6),
            ),
            SizedBox(height: 24.h),
            _SectionHeader(
              'Company culture',
              onEdit: () => context.push(
                AppRoutes.companyInfoEdit,
                extra: 'Write your company culture',
              ),
            ),
            SizedBox(height: 10.h),
            ..._culture.map((c) => _Bullet(c)),
            SizedBox(height: 24.h),
            _SectionHeader('Company license'),
            SizedBox(height: 12.h),
            _LicenseCard(),
            SizedBox(height: 14.h),
            _LicenseCard(),
            SizedBox(height: 24.h),
            _SectionHeader(
              'Website and social media',
              onEdit: () => context.push(AppRoutes.socialLinkEdit),
            ),
            SizedBox(height: 16.h),
            _SocialRow(),
          ],
        ),
      ),
    );
  }
}

class _EditIcon extends StatelessWidget {
  const _EditIcon();

  @override
  Widget build(BuildContext context) =>
      Icon(Icons.edit_outlined, color: _white, size: 18.r);
}

class _CompanyHeader extends StatelessWidget {
  const _CompanyHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 92.r,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 80.r,
                width: 80.r,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF1F14),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  'M',
                  style: TextStyle(
                    color: const Color(0xFFFFD200),
                    fontSize: 44.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => context.push(AppRoutes.subscription),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: _white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.workspace_premium_outlined,
                          color: AppColors.accentPurple,
                          size: 14.r,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Basic',
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.north_east,
                          color: AppColors.blackColor,
                          size: 12.r,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'McDonnald',
          style: TextStyle(
            color: _white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Food service company',
          style: TextStyle(color: _muted, fontSize: 12.sp),
        ),
        SizedBox(height: 6.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on, color: _teal, size: 14.r),
            SizedBox(width: 4.w),
            Text(
              'Jakarta, Indonesia',
              style: TextStyle(color: _teal, fontSize: 12.sp),
            ),
          ],
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ContactRow(icon: Icons.people_outline, text: '250 Employees'),
                SizedBox(height: 14.h),
                _ContactRow(icon: Icons.mail_outline, text: 'abc@gmail.com'),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ContactRow(
                  icon: Icons.group_outlined,
                  text: 'Food  service',
                ),
                SizedBox(height: 14.h),
                _ContactRow(
                  icon: Icons.phone_outlined,
                  text: '+880 9445404',
                ),
              ],
            ),
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
      Icon(icon, color: _white, size: 16.r),
      SizedBox(width: 8.w),
      Expanded(
        child: Text(
          text,
          style: TextStyle(color: _white, fontSize: 11.sp),
        ),
      ),
    ],
  );
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title, {this.onEdit});

  final String title;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: TextStyle(
            color: _white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onEdit,
        child: const _EditIcon(),
      ),
    ],
  );
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 6.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6.h, right: 8.w),
          child: Container(
            height: 4.r,
            width: 4.r,
            decoration: const BoxDecoration(
              color: _muted,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: _muted, fontSize: 11.sp, height: 1.5),
          ),
        ),
      ],
    ),
  );
}

class _LicenseCard extends StatelessWidget {
  const _LicenseCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Business license',
                  style: TextStyle(
                    color: _white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(Icons.more_vert, color: _white, size: 18.r),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Get the opportunity to join the best company and grow together '
            'as an employee. Get the opportunity to join the best company '
            'and grow together as an employee.',
            style: TextStyle(color: _muted, fontSize: 11.sp, height: 1.5),
          ),
          SizedBox(height: 14.h),
          Container(
            height: 44.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: _border),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              'license.pdf',
              style: TextStyle(color: _muted, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialRow extends StatelessWidget {
  const _SocialRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SocialIcon(icon: Icons.language, color: const Color(0xFF2E3142)),
        SizedBox(width: 14.w),
        _SocialIcon(icon: Icons.facebook, color: const Color(0xFF1877F2)),
        SizedBox(width: 14.w),
        _SocialIcon(
          icon: Icons.alternate_email,
          color: const Color(0xFF1DA1F2),
        ),
        SizedBox(width: 14.w),
        _SocialIcon(
          icon: Icons.camera_alt_outlined,
          color: const Color(0xFFE1306C),
        ),
        SizedBox(width: 14.w),
        _SocialIcon(icon: Icons.business, color: const Color(0xFF0A66C2)),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    height: 44.r,
    width: 44.r,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    child: Icon(icon, color: _white, size: 22.r),
  );
}
