import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../home/presentation/pages/message_page.dart';
import '../../../home/presentation/widgets/home_widgets.dart';
import '../widgets/teacher_widgets.dart';

/// Home feed for the "teaching" role: browse and message job seekers.
///
/// Visual reference: `devImg/img_51.png`.
class TeachersHomeScreen extends StatefulWidget {
  const TeachersHomeScreen({super.key});

  @override
  State<TeachersHomeScreen> createState() => _TeachersHomeScreenState();
}

class _TeachersHomeScreenState extends State<TeachersHomeScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  static const _seekers = [
    (name: 'Isabella', title: 'Allied health specialist'),
    (name: 'Thomas', title: 'Allied health specialist'),
    (name: 'Elena', title: 'Allied health specialist'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<({String name, String title})> get _filtered {
    if (_query.isEmpty) return _seekers;
    final q = _query.toLowerCase();
    return _seekers
        .where((s) => s.name.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final seekers = _filtered;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(onProfileTap: () => context.push(AppRoutes.userProfile)),
            SizedBox(height: 26.h),
            HomeSearchField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
              onClear: () {
                _searchController.clear();
                setState(() => _query = '');
              },
            ),
            SizedBox(height: 22.h),
            const HomeSectionTitle('Job seekers'),
            SizedBox(height: 16.h),
            if (seekers.isEmpty)
              Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: Center(
                  child: Text(
                    'No results for "$_query"',
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  ),
                ),
              )
            else
              ...seekers.map(
                (seeker) => Padding(
                  padding: EdgeInsets.only(bottom: 14.h),
                  child: JobSeekerCard(
                    name: seeker.name,
                    title: seeker.title,
                    onMessage: () => context.push(
                      AppRoutes.chat,
                      extra: MessagePreview(
                        name: seeker.name,
                        preview: 'hello how are you',
                        time: '1:30 PM',
                        colors: const [Color(0xFF42D9D0), Color(0xFFEAB8A1)],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
