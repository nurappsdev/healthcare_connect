import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class PostJobPage extends StatelessWidget {
  const PostJobPage({super.key});

  static const _sections = [
    '1. Primary information',
    '2. Job description',
    '3. Responsibilities',
    '4. Requirements',
    '5. Benefits',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 0),
          child: Column(
            children: [
              const _PostJobHeader(title: 'Post a job'),
              SizedBox(height: 29.h),
              ...List.generate(
                _sections.length,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: 9.h),
                  child: _PostJobSectionTile(
                    title: _sections[index],
                    onTap: index == 0
                        ? () => context.push(AppRoutes.jobPrimaryInformation)
                        : () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 15.h),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 42.h,
                  child: ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: const Color(0xFF333333),
                      disabledForegroundColor: AppColors.lightHintColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                    child: Text('Post job', style: TextStyle(fontSize: 12.sp)),
                  ),
                ),
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: SizedBox(
                  height: 42.h,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.cardBorderColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                    child: Text(
                      'See preview',
                      style: TextStyle(
                        color: AppColors.lightHintColor,
                        fontSize: 12.sp,
                      ),
                    ),
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

class JobPrimaryInformationPage extends StatefulWidget {
  const JobPrimaryInformationPage({super.key});

  @override
  State<JobPrimaryInformationPage> createState() =>
      _JobPrimaryInformationPageState();
}

class _JobPrimaryInformationPageState extends State<JobPrimaryInformationPage> {
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _salaryController = TextEditingController();
  final _experienceController = TextEditingController();

  String? _locationType;
  String? _jobType;
  String? _jobLevel;

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _salaryController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
          child: Column(
            children: [
              const _PostJobHeader(title: 'Primary information'),
              SizedBox(height: 22.h),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 96.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _JobInputField(
                        label: 'Job title',
                        hintText: 'Ex : Carpenter',
                        controller: _titleController,
                      ),
                      SizedBox(height: 15.h),
                      _JobDropdownField(
                        label: 'Job location type',
                        hintText: 'Ex : On-site',
                        value: _locationType,
                        items: const ['On-site', 'Remote'],
                        onChanged: (value) =>
                            setState(() => _locationType = value),
                      ),
                      SizedBox(height: 15.h),
                      _JobInputField(
                        label: 'Job location',
                        hintText: 'Ex : New York, USA',
                        controller: _locationController,
                        suffixIcon: Icons.location_on_outlined,
                        underlineLabel: true,
                      ),
                      SizedBox(height: 15.h),
                      _JobInputField(
                        label: 'Salary',
                        hintText: 'Ex : \$ 1200',
                        controller: _salaryController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 15.h),
                      _JobInputField(
                        label: 'Needed experience',
                        hintText: 'Ex : 2 years to  6 years',
                        controller: _experienceController,
                      ),
                      SizedBox(height: 15.h),
                      _JobDropdownField(
                        label: 'Job type',
                        hintText: 'Ex : Full time',
                        value: _jobType,
                        items: const [
                          'Full time',
                          'Part time',
                          'Contract based',
                        ],
                        onChanged: (value) => setState(() => _jobType = value),
                      ),
                      SizedBox(height: 15.h),
                      _JobDropdownField(
                        label: 'Job level',
                        hintText: 'Ex : Mid level',
                        value: _jobLevel,
                        items: const ['Entry level', 'Mid level', 'Senior'],
                        onChanged: (value) => setState(() => _jobLevel = value),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(17.w, 8.h, 17.w, 14.h),
          child: SizedBox(
            height: 42.h,
            child: ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentPurple,
                foregroundColor: AppColors.whiteColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              child: Text(
                'Save and continue',
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PostJobHeader extends StatelessWidget {
  const _PostJobHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => context.pop(),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.tight(Size(32.r, 32.r)),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.whiteColor,
                size: 19.r,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _PostJobSectionTile extends StatelessWidget {
  const _PostJobSectionTile({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        height: 39.h,
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: AppColors.cardBorderColor, width: 1.w),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: AppColors.whiteColor, fontSize: 13.sp),
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.whiteColor, size: 24.r),
          ],
        ),
      ),
    );
  }
}

class _JobInputField extends StatelessWidget {
  const _JobInputField({
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.suffixIcon,
    this.underlineLabel = false,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final IconData? suffixIcon;
  final bool underlineLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            decoration: underlineLabel
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationColor: AppColors.accentTeal,
          ),
        ),
        SizedBox(height: 9.h),
        Container(
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(color: AppColors.cardBorderColor, width: 1.w),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(color: AppColors.whiteColor, fontSize: 13.sp),
            cursorColor: AppColors.accentPurple,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.lightHintColor,
                fontSize: 12.sp,
              ),
              contentPadding: EdgeInsets.fromLTRB(15.w, 11.h, 12.w, 0),
              suffixIcon: suffixIcon == null
                  ? null
                  : Icon(
                      suffixIcon,
                      color: AppColors.lightHintColor,
                      size: 19.r,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class _JobDropdownField extends StatelessWidget {
  const _JobDropdownField({
    required this.label,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String hintText;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 9.h),
        Container(
          height: 40.h,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(color: AppColors.cardBorderColor, width: 1.w),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Text(
                hintText,
                style: TextStyle(
                  color: AppColors.lightHintColor,
                  fontSize: 12.sp,
                ),
              ),
              dropdownColor: AppColors.whiteColor,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.lightHintColor,
                size: 20.r,
              ),
              isExpanded: true,
              style: TextStyle(color: AppColors.blackColor, fontSize: 12.sp),
              selectedItemBuilder: (context) => items
                  .map(
                    (item) => Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item,
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              items: items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
