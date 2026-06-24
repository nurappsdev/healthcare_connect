import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  static const _messages = [
    MessagePreview(
      name: 'Isabella',
      preview: 'hello how are you',
      time: '1:30 PM',
      unread: true,
      colors: [Color(0xFF42D9D0), Color(0xFFEAB8A1)],
    ),
    MessagePreview(
      name: 'Thomas',
      preview: 'hello how are you',
      time: '1:30 PM',
      colors: [Color(0xFF3D8DA8), Color(0xFF4C3428)],
    ),
    MessagePreview(
      name: 'Elena',
      preview: 'hello how are you',
      time: '1:30 PM',
      colors: [Color(0xFF36CFC3), Color(0xFFE6A58D)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(21.w, 10.h, 20.w, 0),
        child: Column(
          children: [
            SizedBox(
              height: 36.h,
              child: Stack(
                alignment: Alignment.center,
                children: [

                  Text(
                    'Messages',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 35.h),
            const _MessageSearchField(),
            SizedBox(height: 18.h),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: _messages.length,
                separatorBuilder: (_, _) => SizedBox(height: 9.h),
                itemBuilder: (context, index) =>
                    _MessageTile(message: _messages[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageSearchField extends StatelessWidget {
  const _MessageSearchField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: AppColors.accentPurple, width: 1.w),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: AppColors.whiteColor, fontSize: 14.sp),
              cursorColor: AppColors.accentPurple,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Search by products name',
                hintStyle: TextStyle(
                  color: AppColors.lightHintColor,
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 23.w, right: 12.w),
              ),
            ),
          ),
          Container(
            width: 45.h,
            height: 45.h,
            decoration: const BoxDecoration(
              color: AppColors.accentPurple,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.search, color: AppColors.whiteColor, size: 27.r),
          ),
        ],
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({required this.message});

  final MessagePreview message;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(AppRoutes.chat, extra: message),
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        height: 60.h,
        padding: EdgeInsets.fromLTRB(13.w, 8.h, 11.w, 8.h),
        decoration: BoxDecoration(
          color: AppColors.blackColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.fieldBorderColor, width: 1.w),
        ),
        child: Row(
          children: [
            MessageAvatar(colors: message.colors, size: 43.r),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    message.preview,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.time,
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 9.sp),
                ),
                SizedBox(height: 14.h),
                SizedBox(
                  height: 8.r,
                  width: 8.r,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: message.unread
                          ? AppColors.accentRed
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MessageAvatar extends StatelessWidget {
  const MessageAvatar({required this.colors, required this.size, super.key});

  final List<Color> colors;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Icon(
              Icons.person,
              color: AppColors.blackColor.withValues(alpha: 0.62),
              size: size * 0.82,
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.accentTeal, width: 1.w),
            ),
            child: SizedBox(width: size, height: size),
          ),
        ],
      ),
    );
  }
}

class MessagePreview {
  const MessagePreview({
    required this.name,
    required this.preview,
    required this.time,
    required this.colors,
    this.unread = false,
  });

  final String name;
  final String preview;
  final String time;
  final List<Color> colors;
  final bool unread;
}
