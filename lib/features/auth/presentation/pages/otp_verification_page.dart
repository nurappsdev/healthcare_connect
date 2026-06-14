import 'dart:async';

import 'package:flutter/material.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.chevron_left,
                      color: AppColors.whiteColor,
                      size: 28,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'OTP Verification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.menu,
                      color: AppColors.whiteColor,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(flex: 3),
                    const BrandLogo(),
                    const SizedBox(height: 64),
                    OtpInputField(
                      controller: _otpController,
                      onCompleted: (_) => _verify(),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Didn’t got the code?',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 12,
                          ),
                        ),
                        _canResend
                            ? GestureDetector(
                                onTap: _resend,
                                child: const Text(
                                  'Resend',
                                  style: TextStyle(
                                    color: AppColors.accentRed,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  const Text(
                                    'Resend in',
                                    style: TextStyle(
                                      color: AppColors.accentRed,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _formattedRemaining,
                                    style: const TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    const Spacer(flex: 2),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _verify,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentPurple,
                          foregroundColor: AppColors.whiteColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: const Text(
                          'Verify',
                          style: TextStyle(
                            fontSize: 14,
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
