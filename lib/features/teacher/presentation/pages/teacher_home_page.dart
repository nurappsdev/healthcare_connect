import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../home/presentation/pages/message_page.dart';
import '../../../home/presentation/widgets/home_bottom_bar.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import 'teachers_home_screen.dart';

/// Shell for the "teaching" role. Hosts the job-seeker feed, messages and
/// profile behind a three-tab bottom bar (see `devImg/img_51.png`).
class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  int _currentIndex = 0;

  static const _bottomItems = [
    Icons.home_outlined,
    Icons.message_outlined,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      bottomNavigationBar: HomeBottomBar(
        currentIndex: _currentIndex,
        onChanged: (index) => setState(() => _currentIndex = index),
        items: _bottomItems,
      ),
      body: switch (_currentIndex) {
        1 => const MessagePage(),
        2 => const ProfilePage(),
        _ => const TeachersHomeScreen(),
      },
    );
  }
}
