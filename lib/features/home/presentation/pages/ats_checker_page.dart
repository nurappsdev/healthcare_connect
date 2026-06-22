import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../profile/presentation/widgets/profile_inputs.dart';

/// ATS checker tab: lets the user upload their CV and, once uploaded,
/// enables the "Check your CV score" action.
class AtsCheckerPage extends StatefulWidget {
  const AtsCheckerPage({super.key});

  @override
  State<AtsCheckerPage> createState() => _AtsCheckerPageState();
}

class _AtsCheckerPageState extends State<AtsCheckerPage> {
  String? _cvPath;

  bool get _hasCv => _cvPath != null;

  Future<void> _pickCv() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() => _cvPath = image.path);
  }

  void _checkScore() {
    if (!_hasCv) return;
    // TODO: send the CV at [_cvPath] to the ATS scoring backend.
    context.push(AppRoutes.cvScore, extra: _cvPath);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
            child: Text(
              'ATS checker',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
              child: _hasCv
                  ? _CvPreview(path: _cvPath!)
                  : Center(child: _UploadBox(onTap: _pickCv)),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
            child: _CheckScoreButton(
              enabled: _hasCv,
              onPressed: _checkScore,
            ),
          ),
        ],
      ),
    );
  }
}

/// Empty state: dashed box prompting the user to upload their CV.
class _UploadBox extends StatelessWidget {
  const _UploadBox({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: AppColors.cardBorderColor,
        radius: 16.r,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: SizedBox(
          width: double.infinity,
          height: 210.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.cardBorderColor),
                ),
                child: Icon(
                  Icons.arrow_upward,
                  color: AppColors.whiteColor,
                  size: 26.r,
                ),
              ),
              SizedBox(height: 18.h),
              Text(
                'Upload your CV',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Filled state: shows the uploaded CV image.
class _CvPreview extends StatelessWidget {
  const _CvPreview({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Image.file(
        File(path),
        width: double.infinity,
        fit: BoxFit.contain,
        alignment: Alignment.topCenter,
      ),
    );
  }
}

/// "Check your CV score" pill — muted while disabled, purple gradient once a
/// CV has been uploaded.
class _CheckScoreButton extends StatelessWidget {
  const _CheckScoreButton({required this.enabled, required this.onPressed});

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        width: double.infinity,
        height: 54.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: enabled ? null : AppColors.darkCardColor,
          gradient: enabled
              ? const LinearGradient(
                  colors: [Color(0xFF7F1AE8), AppColors.accentPurple],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
        ),
        child: Text(
          'Check your CV score',
          style: TextStyle(
            color: enabled ? AppColors.whiteColor : AppColors.lightHintColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
