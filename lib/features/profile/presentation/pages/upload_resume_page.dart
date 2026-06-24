import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/profile_form_field.dart';
import '../widgets/profile_inputs.dart';

class UploadResumePage extends StatefulWidget {
  const UploadResumePage({super.key});

  @override
  State<UploadResumePage> createState() => _UploadResumePageState();
}

class _UploadResumePageState extends State<UploadResumePage> {
  String? _fileName;
  String? _filePath;

  Future<void> _pickFile() async {
    // Open the photo gallery and let the user pick an image of their resume.
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _fileName = image.name;
      _filePath = image.path;
    });
  }

  void _save() {
    if (_filePath == null) return;
    // TODO: upload the file at [_filePath] to the backend.
    Navigator.of(context).pop(_filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        child: Column(
          children: [
            const ProfileTopBar(title: 'Upload resume'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
                child: _fileName == null
                    ? _UploadPrompt(onTap: _pickFile)
                    : _ResumeCard(
                        fileName: _fileName!,
                        filePath: _filePath,
                        onReplace: _pickFile,
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 16.h),
              child: ProfileSaveButton(onPressed: _save),
            ),
          ],
        ),
      ),
    );
  }
}

/// Empty state: dashed box prompting the user to pick a document.
class _UploadPrompt extends StatelessWidget {
  const _UploadPrompt({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: AppColors.cardBorderColor,
        radius: 12.r,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 28.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.file_upload_outlined,
                  color: AppColors.whiteColor,
                  size: 32.r,
                ),
                SizedBox(height: 12.h),
                Text(
                  'Upload your resume',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Filled state: dashed box showing the uploaded PDF and a replace action.
class _ResumeCard extends StatelessWidget {
  const _ResumeCard({
    required this.fileName,
    required this.onReplace,
    this.filePath,
  });

  final String fileName;
  final String? filePath;
  final VoidCallback onReplace;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: AppColors.cardBorderColor,
        radius: 12.r,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 14.h),
          child: Column(
            children: [
              if (filePath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.file(
                    File(filePath!),
                    width: 90.w,
                    height: 110.h,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Icon(
                  Icons.picture_as_pdf,
                  color: AppColors.accentPurple,
                  size: 40.r,
                ),
              SizedBox(height: 10.h),
              Text(
                fileName,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: onReplace,
                  child: Icon(
                    Icons.sync,
                    color: AppColors.whiteColor,
                    size: 22.r,
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
