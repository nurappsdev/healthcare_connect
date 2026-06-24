import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/profile_form_field.dart';

class AddSkillsPage extends StatefulWidget {
  const AddSkillsPage({super.key});

  @override
  State<AddSkillsPage> createState() => _AddSkillsPageState();
}

class _AddSkillsPageState extends State<AddSkillsPage> {
  final _inputController = TextEditingController();
  final List<String> _skills = ['Carpentry', 'Potato'];

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _addSkill() {
    final value = _inputController.text.trim();
    if (value.isEmpty) return;
    setState(() {
      _skills.add(value);
      _inputController.clear();
    });
  }

  void _removeSkill(int index) {
    setState(() => _skills.removeAt(index));
  }

  void _save() {
    // TODO: persist the skills, then return to the profile screen.
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        child: Column(
          children: [
            const ProfileTopBar(title: 'Add skills'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
                child: Column(
                  children: [
                    // New skill entry row with a confirm (check) action.
                    _SkillRow(
                      controller: _inputController,
                      hintText: 'Eg : Team working',
                      onSubmitted: (_) => _addSkill(),
                      action: _SquareButton(
                        icon: Icons.check,
                        iconColor: AppColors.secondaryColor,
                        onTap: _addSkill,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    // Existing skills, each removable.
                    for (var i = 0; i < _skills.length; i++) ...[
                      _SkillRow(
                        text: _skills[i],
                        action: _SquareButton(
                          icon: Icons.delete_outline,
                          iconColor: AppColors.accentRed,
                          onTap: () => _removeSkill(i),
                        ),
                      ),
                      SizedBox(height: 14.h),
                    ],
                  ],
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

/// A single skill line: a rounded field (editable or read-only) plus a
/// trailing square action button.
class _SkillRow extends StatelessWidget {
  const _SkillRow({
    required this.action,
    this.controller,
    this.text,
    this.hintText,
    this.onSubmitted,
  });

  final Widget action;
  final TextEditingController? controller;
  final String? text;
  final String? hintText;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 54.h,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: AppColors.darkCardColor,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: AppColors.fieldBorderColor),
            ),
            child: controller != null
                ? TextField(
                    controller: controller,
                    onSubmitted: onSubmitted,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 14.sp,
                    ),
                    cursorColor: AppColors.accentPurple,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: AppColors.fieldHintColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  )
                : Text(
                    text ?? '',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 14.sp,
                    ),
                  ),
          ),
        ),
        SizedBox(width: 12.w),
        action,
      ],
    );
  }
}

/// Rounded square icon button used to confirm or delete a skill row.
class _SquareButton extends StatelessWidget {
  const _SquareButton({
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.cardBorderColor),
        ),
        child: Icon(icon, color: iconColor, size: 22.r),
      ),
    );
  }
}
