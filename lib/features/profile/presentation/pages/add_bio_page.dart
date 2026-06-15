import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/profile_form_field.dart';

class AddBioPage extends StatefulWidget {
  const AddBioPage({super.key});

  @override
  State<AddBioPage> createState() => _AddBioPageState();
}

class _AddBioPageState extends State<AddBioPage> {
  final _titleController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _save() {
    // TODO: persist the bio, then return to the profile screen.
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ProfileTopBar(title: 'Add your bio'),
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 0),
                child: ProfileFormField(
                  label: 'Profile title or job designation',
                  controller: _titleController,
                  hintText: 'Ex. Carpenter specialist',
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(height: 24.h),
              // The bio box stretches to fill the space above the Save button.
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add short bio about you.',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Expanded(
                        child: TextField(
                          controller: _bioController,
                          keyboardType: TextInputType.multiline,
                          textAlignVertical: TextAlignVertical.top,
                          expands: true,
                          maxLines: null,
                          minLines: null,
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 13.sp,
                          ),
                          cursorColor: AppColors.accentPurple,
                          decoration: InputDecoration(
                            hintText: 'Write here...',
                            hintStyle: TextStyle(
                              color: AppColors.fieldHintColor,
                              fontSize: 13.sp,
                            ),
                            filled: false,
                            contentPadding: EdgeInsets.all(20.r),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: const BorderSide(
                                color: AppColors.cardBorderColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: const BorderSide(
                                color: AppColors.accentPurple,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: ProfileSaveButton(onPressed: _save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
