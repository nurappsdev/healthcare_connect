import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/brand_logo.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _confirm() {
    // TODO: wire up the reset-password use case.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar: back, centered title, menu
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      Icons.chevron_left,
                      color: AppColors.whiteColor,
                      size: 28.r,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Reset password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      Icons.menu,
                      color: AppColors.whiteColor,
                      size: 22.r,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(flex: 3),
                    BrandLogo(),
                    SizedBox(height: 64.h),
                    AuthTextField(
                      controller: _newPasswordController,
                      hintText: 'New Password',
                      icon: Icons.vpn_key_outlined,
                      obscureText: _obscureNew,
                      textInputAction: TextInputAction.next,
                      suffix: _VisibilityToggle(
                        obscured: _obscureNew,
                        onTap: () =>
                            setState(() => _obscureNew = !_obscureNew),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    AuthTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      icon: Icons.vpn_key_outlined,
                      obscureText: _obscureConfirm,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _confirm(),
                      suffix: _VisibilityToggle(
                        obscured: _obscureConfirm,
                        onTap: () =>
                            setState(() => _obscureConfirm = !_obscureConfirm),
                      ),
                    ),
                    const Spacer(flex: 2),
                    SizedBox(
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: _confirm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentPurple,
                          foregroundColor: AppColors.whiteColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VisibilityToggle extends StatelessWidget {
  const _VisibilityToggle({required this.obscured, required this.onTap});

  final bool obscured;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: AppColors.fieldHintColor,
        size: 22.r,
      ),
    );
  }
}
