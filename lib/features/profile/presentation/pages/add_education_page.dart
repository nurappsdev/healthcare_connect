import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/education.dart';
import '../widgets/profile_form_field.dart';
import '../widgets/profile_inputs.dart';

class AddEducationPage extends StatefulWidget {
  const AddEducationPage({super.key});

  @override
  State<AddEducationPage> createState() => _AddEducationPageState();
}

class _AddEducationPageState extends State<AddEducationPage> {
  final _universityController = TextEditingController();
  final _subjectController = TextEditingController();
  final _locationController = TextEditingController();

  DateTime? _fromDate;
  DateTime? _toDate;
  bool _currentlyStudyHere = false;

  @override
  void dispose() {
    _universityController.dispose();
    _subjectController.dispose();
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
    // Return the new entry to the education list screen.
    final education = Education(
      subject: _subjectController.text.trim(),
      universityName: _universityController.text.trim(),
      location: _locationController.text.trim(),
      from: _fromDate ?? DateTime.now(),
      to: _currentlyStudyHere ? null : _toDate,
    );
    context.pop(education);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        child: Column(
          children: [
            const ProfileTopBar(title: 'Add your education'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProfileLogoUploadBox(
                      label: 'Upload university logo',
                    ),
                    SizedBox(height: 24.h),
                    ProfileFormField(
                      label: 'University name',
                      controller: _universityController,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 24.h),
                    ProfileFormField(
                      label: 'Subject title',
                      controller: _subjectController,
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
                            valueText: _currentlyStudyHere
                                ? 'Present'
                                : formatProfileDate(_toDate),
                            isPlaceholder:
                                !_currentlyStudyHere && _toDate == null,
                            onTap: _currentlyStudyHere
                                ? null
                                : () => _pickDate(isFrom: false),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    ProfileCheckboxRow(
                      value: _currentlyStudyHere,
                      onChanged: (value) => setState(
                        () => _currentlyStudyHere = value ?? false,
                      ),
                      label: 'I currently study here',
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
