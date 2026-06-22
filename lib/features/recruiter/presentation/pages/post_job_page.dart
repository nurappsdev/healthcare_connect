import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class PostJobPage extends StatefulWidget {
  const PostJobPage({super.key});

  @override
  State<PostJobPage> createState() => _PostJobPageState();
}

class _PostJobPageState extends State<PostJobPage> {
  static const _sections = <_PostJobSection>[
    _PostJobSection(
      title: '1. Primary information',
      route: AppRoutes.jobPrimaryInformation,
    ),
    _PostJobSection(
      title: '2. Job description',
      route: AppRoutes.jobDescription,
      pageTitle: 'Job description',
    ),
    _PostJobSection(
      title: '3. Responsibilities',
      route: AppRoutes.jobResponsibilities,
      pageTitle: 'Responsibilities',
    ),
    _PostJobSection(
      title: '4. Requirements',
      route: AppRoutes.jobRequirements,
      pageTitle: 'Requirements',
    ),
    _PostJobSection(
      title: '5. Benefits',
      route: AppRoutes.jobBenefits,
      pageTitle: 'Benefits',
    ),
  ];

  final Set<int> _completedSections = {};

  bool get _canPost => _completedSections.length == _sections.length;

  Future<void> _openSection(BuildContext context, int index) async {
    final completed = await context.push<bool>(
      _sections[index].route,
      extra: _sections[index].pageTitle,
    );
    if (completed != true || !mounted) return;
    setState(() => _completedSections.add(index));
  }

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
                    title: _sections[index].title,
                    completed: _completedSections.contains(index),
                    onTap: () => _openSection(context, index),
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
                    onPressed: _canPost ? () {} : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentPurple,
                      foregroundColor: AppColors.whiteColor,
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
                    onPressed: () => context.push(AppRoutes.jobPreview),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: _canPost
                            ? AppColors.accentPurple
                            : AppColors.cardBorderColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                    child: Text(
                      'See preview',
                      style: TextStyle(
                        color: _canPost
                            ? AppColors.whiteColor
                            : AppColors.lightHintColor,
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

class JobTextSectionPage extends StatefulWidget {
  const JobTextSectionPage({required this.title, super.key});

  final String title;

  @override
  State<JobTextSectionPage> createState() => _JobTextSectionPageState();
}

class _JobTextSectionPageState extends State<JobTextSectionPage> {
  late final TextEditingController _controller = TextEditingController(
    text:
        'Lorem ipsum dolor sit amet consectetur ut sagittis\n'
        'arcu nunc commodo morbi sem aliquet. Lorem\n'
        'ipsum dolor sit amet consectetur ut sagittis arcu\n'
        'nunc commodo morbi sem aliquet. Lorem ipsum\n'
        'dolor sit amet consectetur ut sagittis arcu nunc\n'
        'commodo morbi sem aliquet.',
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(13.w, 12.h, 13.w, 0),
          child: Column(
            children: [
              _PostJobHeader(
                title: widget.title,
                onBack: () => context.pop(_controller.text.trim().isNotEmpty),
              ),
              SizedBox(height: 27.h),
              Expanded(
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 12.sp,
                    height: 1.45,
                  ),
                  cursorColor: AppColors.accentPurple,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.r),
                      borderSide: BorderSide(
                        color: AppColors.fieldBorderColor,
                        width: 1.w,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.r),
                      borderSide: BorderSide(
                        color: AppColors.fieldBorderColor,
                        width: 1.w,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.r),
                      borderSide: BorderSide(
                        color: AppColors.fieldBorderColor,
                        width: 1.w,
                      ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                  ),
                ),
              ),
              SizedBox(height: 13.h),
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
              onPressed: () => context.pop(true),
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

class JobPreviewPage extends StatelessWidget {
  const JobPreviewPage({super.key});

  static const _skills = [
    'Team work',
    'Critical thinking',
    'Analytics skill',
    'Adaptability',
    'Analytics skill',
    'Adaptability',
    'Team work',
  ];

  static const _bullets = [
    'Proven experience as a Carpenter or in a similar role.',
    'Strong knowledge of carpentry methods, materials, and tools.',
    'Ability to read technical drawings and blueprints.',
    'Good physical stamina and manual dexterity.',
    'Attention to detail and problem-solving skills.',
    'Ability to work independently and as part of a team.',
    'Knowledge of workplace safety practices.',
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
              const _PostJobHeader(title: 'Job details'),
              SizedBox(height: 22.h),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 22.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const _PreviewLogo(),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'McDonnald',
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 8.sp,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Carpenter',
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 18.h),
                      const _PreviewInfoRow(
                        icon: Icons.location_on_outlined,
                        text: 'Jakarta, Indonesia - On site',
                      ),
                      SizedBox(height: 10.h),
                      const _PreviewInfoRow(
                        icon: Icons.attach_money,
                        text: '12, 000',
                      ),
                      SizedBox(height: 16.h),
                      const _PreviewMetaRow(),
                      SizedBox(height: 20.h),
                      _PreviewSectionTitle('Must have skills'),
                      SizedBox(height: 9.h),
                      Wrap(
                        spacing: 4.w,
                        runSpacing: 5.h,
                        children: _skills
                            .map((skill) => _PreviewChip(skill))
                            .toList(),
                      ),
                      SizedBox(height: 21.h),
                      _PreviewSectionTitle('Job description'),
                      SizedBox(height: 10.h),
                      _PreviewParagraph(
                        'Lorem ipsum dolor sit amet consectetur ut sagittis arcu nunc '
                        'commodo morbi sem aliquet. Lorem ipsum dolor sit amet '
                        'consectetur ut sagittis arcu nunc commodo morbi sem aliquet. '
                        'Lorem ipsum dolor sit amet consectetur ut sagittis arcu nunc '
                        'commodo morbi sem aliquet.',
                      ),
                      SizedBox(height: 18.h),
                      _PreviewSectionTitle('Responsibilities'),
                      SizedBox(height: 8.h),
                      const _BulletList(items: _bullets),
                      SizedBox(height: 18.h),
                      _PreviewSectionTitle('Requirements'),
                      SizedBox(height: 8.h),
                      const _BulletList(items: _bullets),
                      SizedBox(height: 18.h),
                      _PreviewSectionTitle('Benefits'),
                      SizedBox(height: 8.h),
                      const _BulletList(items: _bullets),
                      SizedBox(height: 20.h),
                      _PreviewSectionTitle('About the company'),
                      SizedBox(height: 10.h),
                      const _CompanyPreviewCard(),
                      SizedBox(height: 12.h),
                      Text(
                        'Office address',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      const _PreviewInfoRow(
                        icon: Icons.location_on_outlined,
                        text: 'Jakarta, Indonesia - On site',
                        trailing: Icons.location_on_outlined,
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Icon(
                            Icons.business_outlined,
                            color: AppColors.whiteColor,
                            size: 13.r,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'View more jobs about the company',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 10.sp,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.whiteColor,
                            ),
                          ),
                        ],
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
          padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 14.h),
          child: SizedBox(
            height: 42.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentPurple,
                foregroundColor: AppColors.whiteColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              child: Text('Post job', style: TextStyle(fontSize: 12.sp)),
            ),
          ),
        ),
      ),
    );
  }
}

class _PostJobHeader extends StatelessWidget {
  const _PostJobHeader({required this.title, this.onBack});

  final String title;
  final VoidCallback? onBack;

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
              onPressed: onBack ?? () => context.pop(),
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

class _PreviewLogo extends StatelessWidget {
  const _PreviewLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28.r,
      height: 28.r,
      decoration: BoxDecoration(
        color: const Color(0xFFFF1F14),
        borderRadius: BorderRadius.circular(7.r),
      ),
      alignment: Alignment.center,
      child: Text(
        'M',
        style: TextStyle(
          color: const Color(0xFFFFD200),
          fontSize: 17.sp,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _PreviewInfoRow extends StatelessWidget {
  const _PreviewInfoRow({
    required this.icon,
    required this.text,
    this.trailing,
  });

  final IconData icon;
  final String text;
  final IconData? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.whiteColor, size: 13.r),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: AppColors.whiteColor, fontSize: 9.sp),
          ),
        ),
        if (trailing != null)
          Icon(trailing, color: AppColors.whiteColor, size: 15.r),
      ],
    );
  }
}

class _PreviewMetaRow extends StatelessWidget {
  const _PreviewMetaRow();

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Experience', '2-6 years'),
      ('Job type', 'Full time'),
      ('Level', 'Entry level'),
    ];

    return Row(
      children: List.generate(items.length, (index) {
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: index == items.length - 1
                    ? BorderSide.none
                    : BorderSide(color: AppColors.cardBorderColor, width: 1.w),
              ),
            ),
            child: Column(
              children: [
                Text(
                  items[index].$1,
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 8.sp),
                ),
                SizedBox(height: 8.h),
                Text(
                  items[index].$2,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _PreviewChip extends StatelessWidget {
  const _PreviewChip(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.cardBorderColor, width: 1.w),
      ),
      child: Text(
        text,
        style: TextStyle(color: AppColors.whiteColor, fontSize: 7.sp),
      ),
    );
  }
}

class _PreviewSectionTitle extends StatelessWidget {
  const _PreviewSectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _PreviewParagraph extends StatelessWidget {
  const _PreviewParagraph(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 8.sp,
        height: 1.4,
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 3.h),
              child: Text(
                '• $item',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 8.sp,
                  height: 1.25,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _CompanyPreviewCard extends StatelessWidget {
  const _CompanyPreviewCard();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _PreviewLogo(),
        SizedBox(width: 9.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'McDonnald',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Food business 200 - 300 employees',
                style: TextStyle(color: AppColors.whiteColor, fontSize: 8.sp),
              ),
            ],
          ),
        ),
        Icon(Icons.chevron_right, color: AppColors.whiteColor, size: 20.r),
      ],
    );
  }
}

class _PostJobSectionTile extends StatelessWidget {
  const _PostJobSectionTile({
    required this.title,
    required this.completed,
    required this.onTap,
  });

  final String title;
  final bool completed;
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
          border: Border.all(
            color: completed ? AppColors.accentTeal : AppColors.cardBorderColor,
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: completed
                      ? AppColors.accentTeal
                      : AppColors.whiteColor,
                  fontSize: 13.sp,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: completed ? AppColors.accentTeal : AppColors.whiteColor,
              size: 24.r,
            ),
          ],
        ),
      ),
    );
  }
}

class _PostJobSection {
  const _PostJobSection({
    required this.title,
    required this.route,
    this.pageTitle,
  });

  final String title;
  final String route;
  final String? pageTitle;
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
