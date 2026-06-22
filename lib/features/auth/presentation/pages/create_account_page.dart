import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/account_created_dialog.dart';
import '../widgets/auth_text_field.dart';
import 'signup_page.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({this.role, super.key});

  final SignupRole? role;

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreed = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    // TODO: wire up the register use case.
    final setupNow = await AccountCreatedDialog.show(context);
    if (setupNow == null || !mounted) return;
    if (setupNow) {
      _goToSetupScreen();
    } else {
      _goToRoleHome();
    }
  }

  void _goToSetupScreen() {
    if (widget.role == SignupRole.hiring) {
      context.push(AppRoutes.companyInformation);
    } else {
      context.push(AppRoutes.profileInformation);
    }
  }

  void _goToRoleHome() {
    if (widget.role == SignupRole.hiring) {
      context.go(AppRoutes.home, extra: 'hiring');
    } else {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Back button
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
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
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      'Create Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Enter this information properly and get excited '
                      'service properly !!!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.fieldHintColor,
                        fontSize: 12.sp,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    AuthTextField(
                      controller: _nameController,
                      hintText: 'Name',
                      icon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 16.h),
                    AuthTextField(
                      controller: _emailController,
                      hintText: 'Enter E-mail',
                      icon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 16.h),
                    AuthTextField(
                      controller: _phoneController,
                      hintText: 'Phone number',
                      icon: Icons.call_outlined,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 16.h),
                    AuthTextField(
                      controller: _passwordController,
                      hintText: 'Enter Password',
                      icon: Icons.vpn_key_outlined,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.next,
                      suffix: _VisibilityToggle(
                        obscured: _obscurePassword,
                        onTap: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    AuthTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      icon: Icons.vpn_key_outlined,
                      obscureText: _obscureConfirm,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _register(),
                      suffix: _VisibilityToggle(
                        obscured: _obscureConfirm,
                        onTap: () =>
                            setState(() => _obscureConfirm = !_obscureConfirm),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _AgreementRow(
                      value: _agreed,
                      onChanged: (value) =>
                          setState(() => _agreed = value ?? false),
                      onTermsTap: () => context.push(AppRoutes.termsOfService),
                      onPrivacyTap: () => context.push(AppRoutes.privacyPolicy),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: _agreed ? _register : null,
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
                          'Register',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an account ? ',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 12.sp,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.go(AppRoutes.login),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: AppColors.accentRed,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
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

class _AgreementRow extends StatefulWidget {
  const _AgreementRow({
    required this.value,
    required this.onChanged,
    required this.onTermsTap,
    required this.onPrivacyTap,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;

  @override
  State<_AgreementRow> createState() => _AgreementRowState();
}

class _AgreementRowState extends State<_AgreementRow> {
  late final TapGestureRecognizer _termsRecognizer;
  late final TapGestureRecognizer _privacyRecognizer;

  @override
  void initState() {
    super.initState();
    _termsRecognizer = TapGestureRecognizer()..onTap = widget.onTermsTap;
    _privacyRecognizer = TapGestureRecognizer()..onTap = widget.onPrivacyTap;
  }

  @override
  void dispose() {
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 22.w,
          height: 22.w,
          child: Checkbox(
            value: widget.value,
            onChanged: widget.onChanged,
            activeColor: AppColors.accentPurple,
            side: const BorderSide(color: AppColors.fieldHintColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text.rich(
            TextSpan(
              style: TextStyle(color: AppColors.whiteColor, fontSize: 12.sp),
              children: [
                const TextSpan(text: 'Agree with '),
                TextSpan(
                  text: 'Terms of Services',
                  style: const TextStyle(color: AppColors.accentRed),
                  recognizer: _termsRecognizer,
                ),
                const TextSpan(text: ' & '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(color: AppColors.accentRed),
                  recognizer: _privacyRecognizer,
                ),
              ],
            ),
          ),
        ),
      ],
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
