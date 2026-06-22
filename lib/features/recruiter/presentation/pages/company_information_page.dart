import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../profile/presentation/widgets/profile_form_field.dart';

class CompanyInformationPage extends StatefulWidget {
  const CompanyInformationPage({super.key});

  @override
  State<CompanyInformationPage> createState() => _CompanyInformationPageState();
}

class _CompanyInformationPageState extends State<CompanyInformationPage> {
  final _companyNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _employeeController = TextEditingController();
  final _serviceController = TextEditingController();
  final _websiteController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _facebookController = TextEditingController();
  final _instagramController = TextEditingController();

  @override
  void dispose() {
    _companyNameController.dispose();
    _locationController.dispose();
    _employeeController.dispose();
    _serviceController.dispose();
    _websiteController.dispose();
    _linkedinController.dispose();
    _facebookController.dispose();
    _instagramController.dispose();
    super.dispose();
  }

  void _save() {
    // TODO: persist company information when the company profile API is ready.
    context.push(AppRoutes.uploadLicense);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const ProfileTopBar(title: 'Company information'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 11.h, 16.w, 96.h),
                child: Column(
                  children: [
                    ProfileFormField(
                      label: 'Company name',
                      controller: _companyNameController,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 15.h),
                    ProfileFormField(
                      label: 'Location',
                      controller: _locationController,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 15.h),
                    ProfileFormField(
                      label: 'Number of employee',
                      controller: _employeeController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 15.h),
                    ProfileFormField(
                      label: 'Service type or primary service',
                      controller: _serviceController,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 15.h),
                    ProfileFormField(
                      label: 'Enter your website url',
                      controller: _websiteController,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 15.h),
                    ProfileFormField(
                      label: 'LinkedIn link',
                      controller: _linkedinController,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 15.h),
                    ProfileFormField(
                      label: 'Facebook url',
                      controller: _facebookController,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 15.h),
                    ProfileFormField(
                      label: 'Instagram url (optional)',
                      controller: _instagramController,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
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
          padding: EdgeInsets.fromLTRB(15.w, 8.h, 15.w, 14.h),
          child: ProfileSaveButton(label: 'Save & continue', onPressed: _save),
        ),
      ),
    );
  }
}
