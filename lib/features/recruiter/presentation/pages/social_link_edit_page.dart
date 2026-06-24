import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

const _white = AppColors.whiteColor;
const _border = AppColors.cardBorderColor;
const _purple = AppColors.accentPurple;
const _muted = AppColors.lightHintColor;

/// Recruiter "Social link" editor: website and social-media URLs, reached from
/// the edit icon on the "Website and social media" section of the profile.
class SocialLinkEditPage extends StatefulWidget {
  const SocialLinkEditPage({super.key});

  @override
  State<SocialLinkEditPage> createState() => _SocialLinkEditPageState();
}

class _SocialLinkEditPageState extends State<SocialLinkEditPage> {
  final _website = TextEditingController();
  final _facebook = TextEditingController();
  final _instagram = TextEditingController();
  final _twitter = TextEditingController();
  final _linkedin = TextEditingController();

  @override
  void dispose() {
    _website.dispose();
    _facebook.dispose();
    _instagram.dispose();
    _twitter.dispose();
    _linkedin.dispose();
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
                    _Field(
                      icon: Icons.language,
                      hint: 'Website link',
                      controller: _website,
                    ),
                    SizedBox(height: 14.h),
                    _Field(
                      icon: Icons.facebook,
                      hint: 'Facebook url',
                      controller: _facebook,
                    ),
                    SizedBox(height: 14.h),
                    _Field(
                      icon: Icons.camera_alt_outlined,
                      hint: 'Instagram  url',
                      controller: _instagram,
                    ),
                    SizedBox(height: 14.h),
                    _Field(
                      icon: Icons.alternate_email,
                      hint: 'Twitter url',
                      controller: _twitter,
                    ),
                    SizedBox(height: 14.h),
                    _Field(
                      icon: Icons.business,
                      hint: 'LinkedIn url',
                      controller: _linkedin,
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
                'Social link',
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

class _Field extends StatelessWidget {
  const _Field({
    required this.icon,
    required this.hint,
    required this.controller,
  });

  final IconData icon;
  final String hint;
  final TextEditingController controller;

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
              keyboardType: TextInputType.url,
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
