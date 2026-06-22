import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helpers/prefs_helper.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_constant.dart';

/// The role a person selects when signing up.
enum SignupRole { lookingForWork, hiring, teaching }

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupRole? _selectedRole = SignupRole.hiring;

  Future<void> _selectRole(SignupRole role) async {
    setState(() => _selectedRole = role);
    try {
      await PrefsHelper.setString(AppConstants.role, role.name);
    } catch (_) {
      // Navigation should not be blocked by local preference channel issues.
    }
    if (!mounted) return;
    context.push(AppRoutes.createAccount, extra: role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
              child: IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  Icons.chevron_left,
                  color: AppColors.whiteColor,
                  size: 28.r,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Are you looking for new Opportunities',
                    style: TextStyle(
                      color: AppColors.accentTeal,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 28.h),
                  _RoleCard(
                    title: 'Yes, I am actively looking for',
                    description:
                        'Get the opportunity to join the best company and '
                        'grow together as an employee.',
                    selected: _selectedRole == SignupRole.lookingForWork,
                    onTap: () => _selectRole(SignupRole.lookingForWork),
                  ),
                  SizedBox(height: 12.h),
                  _RoleCard(
                    title: 'Im open job for seeking',
                    description:
                        'Choose the best candidate you want and grow big '
                        'together.',
                    selected: _selectedRole == SignupRole.hiring,
                    onTap: () => _selectRole(SignupRole.hiring),
                  ),
                  SizedBox(height: 12.h),
                  _RoleCard(
                    title: 'Im open teaching',
                    description:
                        'Provide instruction based on your license or '
                        'anything needed.',
                    selected: _selectedRole == SignupRole.teaching,
                    onTap: () => _selectRole(SignupRole.teaching),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: selected ? AppColors.accentPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          border: selected
              ? null
              : Border.all(color: AppColors.cardBorderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              description,
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
