import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

const _white = AppColors.whiteColor;
const _border = AppColors.cardBorderColor;
const _purple = AppColors.accentPurple;

/// A single notification entry shown on [NotificationsPage].
class NotificationItem {
  const NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    this.unread = false,
  });

  final String title;
  final String message;
  final String time;
  final IconData icon;
  final bool unread;
}

/// Notification list screen, reached from the bell icon in the header.
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({this.items = _demoItems, super.key});

  final List<NotificationItem> items;

  static const _demoItems = [
    NotificationItem(
      title: 'New application',
      message: 'Abdullah applied to your "Nurse" job post.',
      time: '2m ago',
      icon: Icons.person_add_alt_1,
      unread: true,
    ),
    NotificationItem(
      title: 'Candidate shortlisted',
      message: 'Steve Smith was added to your shortlist.',
      time: '1h ago',
      icon: Icons.star_outline,
      unread: true,
    ),
    NotificationItem(
      title: 'Job post live',
      message: 'Your "Caregiver" job post is now visible to candidates.',
      time: '5h ago',
      icon: Icons.work_outline,
    ),
    NotificationItem(
      title: 'New message',
      message: 'You have a new message from Mariana Anderson.',
      time: 'Yesterday',
      icon: Icons.chat_bubble_outline,
    ),
    NotificationItem(
      title: 'Subscription reminder',
      message: 'Your premium plan renews in 3 days.',
      time: '2 days ago',
      icon: Icons.notifications_none,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Header(),
            if (items.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'No notifications yet',
                    style: TextStyle(color: AppColors.lightHintColor, fontSize: 13.sp),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => SizedBox(height: 12.h),
                  itemBuilder: (_, index) => _NotificationCard(item: items[index]),
                ),
              ),
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
                'Notifications',
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

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.item});

  final NotificationItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: item.unread
            ? _purple.withValues(alpha: 0.08)
            : AppColors.blackColor,
        border: Border.all(
          color: item.unread ? _purple : _border.withValues(alpha: 0.5),
        ),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42.r,
            height: 42.r,
            decoration: const BoxDecoration(
              color: AppColors.darkCardColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(item.icon, color: _purple, size: 22.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          color: _white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      item.time,
                      style: TextStyle(
                        color: AppColors.lightHintColor,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  item.message,
                  style: TextStyle(
                    color: AppColors.lightHintColor,
                    fontSize: 11.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          if (item.unread) ...[
            SizedBox(width: 8.w),
            Container(
              width: 8.r,
              height: 8.r,
              margin: EdgeInsets.only(top: 4.h),
              decoration: const BoxDecoration(
                color: _purple,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
