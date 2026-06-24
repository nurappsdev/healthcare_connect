import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helpers/prefs_helper.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_constant.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/brand_logo.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    // Read the role saved at sign-up and open the app for that role.
    String roleName;
    try {
      roleName = await PrefsHelper.getString(AppConstants.role);
    } catch (_) {
      roleName = '';
    }
    if (!mounted) return;
    context.go(AppRoutes.home, extra: SignupRoleX.fromName(roleName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        child: Stack(
          children: [
            // Back button
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
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
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Brand logo + tagline
                  BrandLogo(),
                  SizedBox(height: 64.h),
                  // Email field
                  AuthTextField(
                    controller: _emailController,
                    hintText: 'Enter email',
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 16.h),
                  // Password field
                  AuthTextField(
                    controller: _passwordController,
                    hintText: 'Enter Password',
                    icon: Icons.vpn_key_outlined,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submit(),
                    suffix: IconButton(
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.fieldHintColor,
                        size: 22.r,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => context.push(AppRoutes.emailVerification),
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: AppColors.accentRed,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 36.h),
                  // Login button
                  SizedBox(
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentPurple,
                        disabledBackgroundColor: AppColors.accentPurple
                            .withValues(alpha: 0.6),
                        foregroundColor: AppColors.whiteColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Sign up prompt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: AppColors.mutedTextColor,
                          fontSize: 12.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.push(AppRoutes.signup),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: AppColors.accentRed,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
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
