import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

const _white = AppColors.whiteColor;
const _border = AppColors.cardBorderColor;
const _purple = AppColors.accentPurple;
const _muted = AppColors.lightHintColor;

/// Recruiter "Edit profile" screen: edit the company's core profile fields,
/// reached from the edit icon on the company Profile tab.
class EditCompanyProfilePage extends StatefulWidget {
  const EditCompanyProfilePage({super.key});

  @override
  State<EditCompanyProfilePage> createState() => _EditCompanyProfilePageState();
}

class _EditCompanyProfilePageState extends State<EditCompanyProfilePage> {
  final _name = TextEditingController();
  final _tagline = TextEditingController();
  final _location = TextEditingController();
  final _phone = TextEditingController();
  final _employees = TextEditingController();
  final _serviceType = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _tagline.dispose();
    _location.dispose();
    _phone.dispose();
    _employees.dispose();
    _serviceType.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            _Header(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
                child: Column(
                  children: [
                    _AvatarPicker(),
                    SizedBox(height: 24.h),
                    _Field(
                      icon: Icons.person_outline,
                      hint: 'Name',
                      controller: _name,
                    ),
                    SizedBox(height: 14.h),
                    _Field(
                      icon: Icons.cloud_outlined,
                      hint: 'Company tagline',
                      controller: _tagline,
                    ),
                    SizedBox(height: 14.h),
                    _Field(
                      icon: Icons.location_on_outlined,
                      hint: 'Location',
                      controller: _location,
                    ),
                    SizedBox(height: 14.h),
                    _Field(
                      icon: Icons.phone_outlined,
                      hint: 'Phone number',
                      controller: _phone,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 14.h),
                    _Field(
                      icon: Icons.people_outline,
                      hint: 'Number of employee',
                      controller: _employees,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 14.h),
                    _Field(
                      icon: Icons.handshake_outlined,
                      hint: 'Service type',
                      controller: _serviceType,
                    ),
                  ],
                ),
              ),
            ),
            _SaveBar(onSave: () => Navigator.of(context).maybePop()),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).maybePop(),
            child: Icon(Icons.arrow_back_ios_new, color: _white, size: 20.r),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Edit profile',
                style: TextStyle(
                  color: _white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: 20.r),
        ],
      ),
    );
  }
}

class _AvatarPicker extends StatelessWidget {
  const _AvatarPicker();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84.r,
      width: 84.r,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 42.r,
            backgroundColor: AppColors.darkCardColor,
            child: Icon(Icons.person_outline, color: _white, size: 40.r),
          ),
          Container(
            height: 84.r,
            width: 84.r,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.35),
              shape: BoxShape.circle,
              border: Border.all(color: _border),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.photo_camera_outlined,
              color: _white,
              size: 24.r,
            ),
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.icon,
    required this.hint,
    required this.controller,
    this.keyboardType,
  });

  final IconData icon;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: _white, size: 20.r),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: TextStyle(color: _white, fontSize: 14.sp),
              cursorColor: _purple,
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: EdgeInsets.symmetric(vertical: 18.h),
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(color: _muted, fontSize: 14.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SaveBar extends StatelessWidget {
  const _SaveBar({required this.onSave});

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
      child: SizedBox(
        height: 52.h,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: _purple,
            foregroundColor: _white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.r),
            ),
          ),
          child: Text(
            'Save changes',
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
