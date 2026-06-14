import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/theme/app_colors.dart';

/// Six-box OTP entry used on the OTP verification screen.
///
/// Wraps [PinCodeTextField] with the app's dark-theme styling and exposes a
/// small, focused API for the common callbacks.
class OtpInputField extends StatelessWidget {
  const OtpInputField({
    super.key,
    required this.controller,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
  });

  final TextEditingController controller;
  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      controller: controller,
      autoDisposeControllers: false,
      length: length,
      autoFocus: false,
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      cursorColor: AppColors.accentPurple,
      textStyle: const TextStyle(
        color: AppColors.whiteColor,
        fontSize: 16,
      ),
      // Allow pasting the code.
      beforeTextPaste: (text) => true,
      inputFormatters: const [],
      onChanged: (value) => onChanged?.call(value),
      onCompleted: (value) => onCompleted?.call(value),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 50,
        fieldWidth: 50,
        borderWidth: 1,
        activeColor: AppColors.accentPurple,
        inactiveColor: AppColors.mutedTextColor,
        selectedColor: AppColors.accentPurple,
        activeFillColor: AppColors.loginBackground,
        inactiveFillColor: AppColors.loginBackground,
        selectedFillColor: AppColors.loginBackground,
      ),
    );
  }
}
