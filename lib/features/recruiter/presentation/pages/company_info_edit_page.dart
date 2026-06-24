import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

const _white = AppColors.whiteColor;
const _border = AppColors.cardBorderColor;
const _purple = AppColors.accentPurple;
const _muted = AppColors.lightHintColor;

/// Recruiter "Company information" editor: a single large free-text field.
/// Reused for both "About us" and "Company culture" by varying [subtitle].
class CompanyInfoEditPage extends StatefulWidget {
  const CompanyInfoEditPage({
    this.subtitle = 'Write about your company',
    this.initialText = '',
    super.key,
  });

  final String subtitle;
  final String initialText;

  @override
  State<CompanyInfoEditPage> createState() => _CompanyInfoEditPageState();
}

class _CompanyInfoEditPageState extends State<CompanyInfoEditPage> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialText);

  @override
  void dispose() {
    _controller.dispose();
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
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.subtitle,
                  style: TextStyle(
                    color: _white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: _border),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    style: TextStyle(color: _white, fontSize: 13.sp),
                    cursorColor: _purple,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: 'Write here...',
                      hintStyle: TextStyle(color: _muted, fontSize: 13.sp),
                    ),
                  ),
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
                'Company information',
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

class _SaveBar extends StatelessWidget {
  const _SaveBar({required this.onSave});

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
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
