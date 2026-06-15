import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/brand_logo.dart';
import '../widgets/otp_input_field.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key, this.email});

  /// Address the code was sent to (used when resending).
  final String? email;

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  static const _resendDuration = Duration(seconds: 83); // 01:23

  final _otpController = TextEditingController();
  Timer? _timer;
  Duration _remaining = _resendDuration;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    setState(() => _remaining = _resendDuration);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining.inSeconds <= 1) {
        timer.cancel();
        setState(() => _remaining = Duration.zero);
      } else {
        setState(() => _remaining -= const Duration(seconds: 1));
      }
    });
  }

  bool get _canResend => _remaining == Duration.zero;

  String get _formattedRemaining {
    final minutes = _remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = _remaining.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes : $seconds s';
  }

  void _resend() {
    if (!_canResend) return;
    // TODO: wire up the resend-OTP use case for widget.email.
    _startCountdown();
  }

  void _verify() {
    // TODO: wire up the verify-OTP use case with _otpController.text.
    context.push(AppRoutes.resetPassword);
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
                      'OTP Verification',
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
                    OtpInputField(
                      controller: _otpController,
                      onCompleted: (_) => _verify(),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Didn’t got the code?',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 12.sp,
                          ),
                        ),
                        _canResend
                            ? GestureDetector(
                                onTap: _resend,
                                child: Text(
                                  'Resend',
                                  style: TextStyle(
                                    color: AppColors.accentRed,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  Text(
                                    'Resend in',
                                    style: TextStyle(
                                      color: AppColors.accentRed,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    _formattedRemaining,
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    const Spacer(flex: 2),
                    SizedBox(
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: _verify,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentPurple,
                          foregroundColor: AppColors.whiteColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                        child: Text(
                          'Verify',
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
