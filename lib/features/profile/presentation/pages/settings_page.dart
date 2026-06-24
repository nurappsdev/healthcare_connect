import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(17.w, 14.h, 17.w, 18.h),
          child: Column(
            children: [
              const _SettingsHeader(title: 'Settings'),
              SizedBox(height: 39.h),
              _SettingsTile(
                icon: Icons.support_agent,
                title: 'Admin support',
                onTap: () => context.push(AppRoutes.adminSupport),
              ),
              _SettingsTile(
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () => context.push(AppRoutes.changePassword),
              ),
              _SettingsTile(
                icon: Icons.help_outline,
                title: 'About Us',
                onTap: () => context.push(AppRoutes.aboutCompany),
              ),
              _SettingsTile(
                icon: Icons.shield_outlined,
                title: 'Privacy Policy',
                onTap: () => context.push(AppRoutes.privacyPolicy),
              ),
              _SettingsTile(
                icon: Icons.info_outline,
                title: 'Terms of service',
                onTap: () => context.push(AppRoutes.termsOfService),
              ),
              _SettingsTile(
                icon: Icons.logout,
                title: 'Logout',
                destructive: true,
                onTap: () => _showSettingsConfirmDialog(
                  context,
                  icon: Icons.logout,
                  title: 'Logout',
                  message: 'Are you sure you want to logout?',
                  actionLabel: 'Logout',
                    logOut: () => context.push(AppRoutes.login),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: OutlinedButton.icon(
                  onPressed: () => _showSettingsConfirmDialog(
                    context,
                    icon: Icons.delete_outline,
                    title: 'Delete Account',
                    message:
                        'Are you sure you want to delete your account? This action cannot be undone.',
                    actionLabel: 'Delete',
                    logOut: (){}
                  ),
                  icon: Icon(
                    Icons.delete_outline,
                    color: AppColors.accentRed,
                    size: 22.r,
                  ),
                  label: Text(
                    'Delete Account',
                    style: TextStyle(
                      color: AppColors.accentRed,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.accentRed, width: 1.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showSettingsConfirmDialog(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String message,
    required String actionLabel,
        required VoidCallback logOut,
  }) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: const Color(0xFF171717),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
          side: BorderSide(color: AppColors.fieldBorderColor, width: 1.w),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48.r,
                height: 48.r,
                decoration: const BoxDecoration(
                  color: AppColors.accentRed,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.whiteColor, size: 25.r),
              ),
              SizedBox(height: 16.h),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.lightHintColor,
                  fontSize: 13.sp,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 22.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: AppColors.fieldBorderColor,
                            width: 1.w,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: logOut,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentRed,
                          foregroundColor: AppColors.whiteColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                        child: Text(
                          actionLabel,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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
}

class AdminSupportPage extends StatelessWidget {
  const AdminSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(17.w, 14.h, 17.w, 0),
          child: Column(
            children: [
              const _SettingsHeader(title: 'Admin support'),
              SizedBox(height: 152.h),
              const _PeopleIllustration(),
              SizedBox(height: 89.h),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(14.w, 21.h, 14.w, 25.h),
                    decoration: BoxDecoration(
                      color: AppColors.blackColor,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppColors.accentPurple,
                        width: 1.w,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Support',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 9.h),
                        Text(
                          'If you have any questions, need assistance, or want\n'
                          'to discuss your progress, feel free to reach out to your\n'
                          "coach. We're here to help you achieve your fitness\n"
                          'goals!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 11.sp,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(left: 77.w, top: -5.r, child: const _PurpleDot()),
                  Positioned(right: 77.w, top: -5.r, child: const _PurpleDot()),
                  Positioned(
                    top: 111.h,
                    child: Container(
                      width: 245.w,
                      padding: EdgeInsets.fromLTRB(25.w, 18.h, 25.w, 15.h),
                      decoration: BoxDecoration(
                        color: AppColors.accentPurple,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(13.r),
                        ),
                      ),
                      child: Column(
                        children: [
                          _ContactRow(
                            icon: Icons.call_outlined,
                            text: '(609)327-7992',
                          ),
                          SizedBox(height: 14.h),
                          _ContactRow(
                            icon: Icons.mail_outline,
                            text: 'abc@gmail.com',
                          ),
                        ],
                      ),
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
}

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.w, 14.h, 15.w, 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SettingsHeader(title: 'Change password'),
              SizedBox(height: 42.h),
              _PasswordField(
                label: 'Current Password',
                hintText: 'Enter old password',
                controller: _currentController,
              ),
              SizedBox(height: 16.h),
              _PasswordField(
                label: 'New Password',
                hintText: 'Enter new password',
                controller: _newController,
              ),
              SizedBox(height: 16.h),
              _PasswordField(
                label: 'Password',
                hintText: 'Re-enter new password',
                controller: _confirmController,
              ),
              SizedBox(height: 8.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.push(AppRoutes.resetPassword),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                      color: AppColors.accentRed,
                      fontSize: 12.sp,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.accentRed,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 46.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentPurple,
                    foregroundColor: AppColors.whiteColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                  ),
                  child: Text(
                    'Update password',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => context.pop(),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.tight(Size(32.r, 32.r)),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.whiteColor,
                size: 20.r,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.destructive = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? AppColors.accentRed : AppColors.whiteColor;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: destructive
                  ? AppColors.accentRed
                  : AppColors.fieldBorderColor,
              width: 1.w,
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 16.w),
            Icon(icon, color: color, size: 21.r),
            SizedBox(width: 17.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: color, size: 27.r),
            SizedBox(width: 12.w),
          ],
        ),
      ),
    );
  }
}

class _PeopleIllustration extends StatelessWidget {
  const _PeopleIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210.w,
      height: 115.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 10.w,
            bottom: 20.h,
            child: _Person(size: 58.r),
          ),
          Positioned(
            right: 10.w,
            bottom: 20.h,
            child: _Person(size: 58.r),
          ),
          Positioned(
            left: 44.w,
            bottom: 35.h,
            child: _Person(size: 72.r),
          ),
          Positioned(
            right: 44.w,
            bottom: 35.h,
            child: _Person(size: 72.r),
          ),
          Positioned(bottom: 0, child: _Person(size: 103.r)),
        ],
      ),
    );
  }
}

class _Person extends StatelessWidget {
  const _Person({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 0,
            child: Container(
              width: size * 0.45,
              height: size * 0.45,
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: size,
              height: size * 0.58,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(size * 0.34),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PurpleDot extends StatelessWidget {
  const _PurpleDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.r,
      height: 10.r,
      decoration: const BoxDecoration(
        color: AppColors.accentPurple,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 10.r,
          backgroundColor: AppColors.whiteColor,
          child: Icon(icon, color: AppColors.accentPurple, size: 13.r),
        ),
        SizedBox(width: 18.w),
        Text(
          text,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _PasswordField extends StatefulWidget {
  const _PasswordField({
    required this.label,
    required this.hintText,
    required this.controller,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: 53.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13.r),
            border: Border.all(color: AppColors.cardBorderColor, width: 1.w),
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: _obscure,
            style: TextStyle(color: AppColors.whiteColor, fontSize: 13.sp),
            cursorColor: AppColors.accentPurple,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 13.sp,
              ),
              contentPadding: EdgeInsets.fromLTRB(14.w, 16.h, 6.w, 0),
              suffixIcon: IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(
                  _obscure ? Icons.visibility_off_outlined : Icons.visibility,
                  color: AppColors.whiteColor,
                  size: 21.r,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
