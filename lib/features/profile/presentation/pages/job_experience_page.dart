import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/profile_form_field.dart';
import '../widgets/profile_inputs.dart';

class JobExperiencePage extends StatefulWidget {
  const JobExperiencePage({super.key});

  @override
  State<JobExperiencePage> createState() => _JobExperiencePageState();
}

class _JobExperiencePageState extends State<JobExperiencePage> {
  final _companyController = TextEditingController();
  final _positionController = TextEditingController();
  final _locationController = TextEditingController();

  DateTime? _fromDate;
  DateTime? _toDate;
  bool _currentlyWorkHere = false;

  @override
  void dispose() {
    _companyController.dispose();
    _positionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isFrom}) async {
    final picked = await pickProfileDate(
      context,
      initialDate: isFrom ? _fromDate : _toDate,
    );
    if (picked == null) return;
    setState(() {
      if (isFrom) {
        _fromDate = picked;
      } else {
        _toDate = picked;
      }
    });
  }

  void _save() {
    // TODO: persist the job experience, then return to the profile screen.
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        child: Column(
          children: [
            const ProfileTopBar(title: 'Job experience'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProfileLogoUploadBox(
                      label: 'Upload company logo ( Optional )',
                    ),
                    SizedBox(height: 24.h),
                    ProfileFormField(
                      label: 'Company name',
                      controller: _companyController,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 24.h),
                    ProfileFormField(
                      label: 'Position title',
                      controller: _positionController,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 24.h),
                    const ProfileFieldLabel('Location'),
                    SizedBox(height: 12.h),
                    ProfileLocationField(controller: _locationController),
                    SizedBox(height: 24.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ProfileDateField(
                            label: 'From',
                            valueText: formatProfileDate(_fromDate),
                            isPlaceholder: _fromDate == null,
                            onTap: () => _pickDate(isFrom: true),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: ProfileDateField(
                            label: 'To',
                            valueText: _currentlyWorkHere
                                ? 'Present'
                                : formatProfileDate(_toDate),
                            isPlaceholder:
                                !_currentlyWorkHere && _toDate == null,
                            onTap: _currentlyWorkHere
                                ? null
                                : () => _pickDate(isFrom: false),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    ProfileCheckboxRow(
                      value: _currentlyWorkHere,
                      onChanged: (value) => setState(
                        () => _currentlyWorkHere = value ?? false,
                      ),
                      label: 'I currently work here',
                    ),
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
