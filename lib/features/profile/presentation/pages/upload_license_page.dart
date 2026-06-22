import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/helpers/prefs_helper.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_constant.dart';
import '../widgets/profile_form_field.dart';

class UploadLicensePage extends StatefulWidget {
  const UploadLicensePage({super.key});

  @override
  State<UploadLicensePage> createState() => _UploadLicensePageState();
}

class _UploadLicensePageState extends State<UploadLicensePage> {
  final _licenseNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imagePicker = ImagePicker();

  String? _fileName;
  String? _filePath;

  @override
  void dispose() {
    _licenseNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDocument() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      _fileName = image.name;
      _filePath = image.path;
    });
  }

  Future<void> _save() async {
    if (_filePath == null) return;
    // TODO: upload license data and [_filePath] when company profile API is ready.
    try {
      await PrefsHelper.setString(AppConstants.role, 'hiring');
    } catch (_) {
      // Do not block navigation if local preferences are unavailable.
    }
    if (!mounted) return;
    context.go(AppRoutes.home, extra: 'hiring');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const ProfileTopBar(title: 'Upload license'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(14.w, 20.h, 14.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileFormField(
                      label: 'License name',
                      controller: _licenseNameController,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 17.h),
                    ProfileFormField(
                      label: 'Short description about license',
                      controller: _descriptionController,
                      maxLines: 4,
                      minLines: 4,
                      textInputAction: TextInputAction.newline,
                    ),
                    SizedBox(height: 13.h),
                    Text(
                      'Upload documents',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: _pickDocument,
                      borderRadius: BorderRadius.circular(100.r),
                      child: Container(
                        height: 31.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          border: Border.all(
                            color: AppColors.cardBorderColor,
                            width: 1.w,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_upload_outlined,
                              color: AppColors.fieldHintColor,
                              size: 14.r,
                            ),
                            SizedBox(width: 12.w),
                            Flexible(
                              child: Text(
                                _fileName ?? 'Upload documents',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.fieldHintColor,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 15.h),
          child: SizedBox(
            width: double.infinity,
            height: 45.h,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF333333),
                foregroundColor: AppColors.whiteColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              child: Text(
                'Save',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
