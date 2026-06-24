import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/brand_logo.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendOtp() {
    // TODO: wire up the send-OTP use case.
    context.push(AppRoutes.otpVerification, extra: _emailController.text.trim());
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
                      'E-mail Verification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
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
                      controller: _emailController,
                      hintText: 'Email',
                      icon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _sendOtp(),
                    ),
                    const Spacer(flex: 2),
                    SizedBox(
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: _sendOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentPurple,
                          foregroundColor: AppColors.whiteColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                        child: Text(
                          'Send OTP',
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
