import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import 'message_page.dart';

enum _ChatMenuAction { viewMedia, report, block }

class ChatPage extends StatefulWidget {
  const ChatPage({required this.message, super.key});

  final MessagePreview message;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final _imagePicker = ImagePicker();

  late final List<_LocalChatMessage> _messages = [
    const _LocalChatMessage(
      text: 'Lorem ipsum dolor sit amet',
      timeLabel: '10:15',
    ),
    const _LocalChatMessage(text: 'Lorem ipsum dolor sit amet', isMine: true),
    const _LocalChatMessage(
      text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
      timeLabel: '11:40',
      compact: true,
    ),
    const _LocalChatMessage(
      text:
          "Sure! Here's a 30-word message:\n"
          "Thank you for using our app! Don't forget to share your "
          'referral code with friends to unlock exclusive benefits, '
          'discounts, and rewards. Start referring today and enjoy '
          'amazing offers!',
      isMine: true,
      large: true,
    ),
    const _LocalChatMessage(text: 'Lorem ipsum dolor  ipsum'),
    const _LocalChatMessage(text: 'Lorem ipsum dolor', isMine: true),
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendText() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_LocalChatMessage(text: text, isMine: true));
      _controller.clear();
    });
    _scrollToBottom();
  }

  Future<void> _pickLocalFile() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      _messages.add(
        _LocalChatMessage(
          text: image.name,
          attachmentPath: image.path,
          isMine: true,
        ),
      );
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _ChatHeader(message: widget.message),
            SizedBox(height: 25.h),
            Expanded(
              child: _ChatMessages(
                controller: _scrollController,
                messages: _messages,
              ),
            ),
            _MessageComposer(
              controller: _controller,
              bottomPadding: bottomPadding,
              onAttach: _pickLocalFile,
              onSend: _sendText,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({required this.message});

  final MessagePreview message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 17.w, 0),
      child: SizedBox(
        height: 46.h,
        child: Row(
          children: [
            IconButton(
              onPressed: () => context.pop(),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.tight(Size(28.r, 38.r)),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.whiteColor,
                size: 20.r,
              ),
            ),
            SizedBox(width: 8.w),
            MessageAvatar(colors: message.colors, size: 43.r),
            SizedBox(width: 9.w),
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
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Active 1h ago',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 9.sp,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<_ChatMenuAction>(
              color: const Color(0xFF171717),
              elevation: 8,
              offset: Offset(0, 36.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: BorderSide(color: AppColors.fieldBorderColor, width: 1.w),
              ),
              onSelected: (action) =>
                  _handleMenuAction(context, action, message.name),
              itemBuilder: (context) => [
                _menuItem(
                  action: _ChatMenuAction.viewMedia,
                  icon: Icons.photo_library_outlined,
                  label: 'View media',
                ),
                _menuItem(
                  action: _ChatMenuAction.report,
                  icon: Icons.flag_outlined,
                  label: 'Report',
                ),
                _menuItem(
                  action: _ChatMenuAction.block,
                  icon: Icons.block,
                  label: 'Block',
                  destructive: true,
                ),
              ],
              child: SizedBox(
                width: 34.r,
                height: 38.r,
                child: Icon(
                  Icons.more_vert,
                  color: AppColors.whiteColor,
                  size: 25.r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<_ChatMenuAction> _menuItem({
    required _ChatMenuAction action,
    required IconData icon,
    required String label,
    bool destructive = false,
  }) {
    final color = destructive ? AppColors.accentRed : AppColors.whiteColor;

    return PopupMenuItem<_ChatMenuAction>(
      value: action,
      height: 42.h,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18.r),
          SizedBox(width: 10.w),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(
    BuildContext context,
    _ChatMenuAction action,
    String name,
  ) {
    switch (action) {
      case _ChatMenuAction.block:
        _showBlockUserDialog(context, name);
        break;
      case _ChatMenuAction.viewMedia:
        context.push(AppRoutes.chatMedia);
        break;
      case _ChatMenuAction.report:
        context.push(AppRoutes.reportUser);
        break;
    }
  }

  Future<void> _showBlockUserDialog(BuildContext context, String name) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: const Color(0xFF171717),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
          side: BorderSide(color: AppColors.fieldBorderColor, width: 1.w),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48.r,
                height: 48.r,
                decoration: const BoxDecoration(
                  color: AppColors.accentRed,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.block,
                  color: AppColors.whiteColor,
                  size: 25.r,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Block user',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Are you sure you want to block $name?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.lightHintColor,
                  fontSize: 13.sp,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 22.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: AppColors.fieldBorderColor,
                            width: 1.w,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentRed,
                          foregroundColor: AppColors.whiteColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                        child: Text(
                          'Block',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatMessages extends StatelessWidget {
  const _ChatMessages({required this.controller, required this.messages});

  final ScrollController controller;
  final List<_LocalChatMessage> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
      itemCount: messages.length,
      separatorBuilder: (_, _) => SizedBox(height: 18.h),
      itemBuilder: (context, index) {
        final message = messages[index];

        return Column(
          children: [
            if (message.timeLabel != null) ...[
              _TimeLabel(message.timeLabel!),
              SizedBox(height: 10.h),
            ],
            _Bubble(
              text: message.text,
              attachmentPath: message.attachmentPath,
              alignment: message.isMine
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              color: message.isMine
                  ? AppColors.accentPurple
                  : const Color(0xFFEDEDED),
              textColor: message.isMine
                  ? AppColors.whiteColor
                  : const Color(0xFF252525),
              widthFactor: message.widthFactor,
              checked: message.isMine,
              large: message.large,
              compact: message.compact,
            ),
          ],
        );
      },
    );
  }
}

class _TimeLabel extends StatelessWidget {
  const _TimeLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.whiteColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.text,
    required this.alignment,
    required this.color,
    required this.textColor,
    required this.widthFactor,
    this.attachmentPath,
    this.checked = false,
    this.large = false,
    this.compact = false,
  });

  final String text;
  final String? attachmentPath;
  final Alignment alignment;
  final Color color;
  final Color textColor;
  final double widthFactor;
  final bool checked;
  final bool large;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.sizeOf(context).width * widthFactor;
    final hasAttachment = attachmentPath != null;

    return Align(
      alignment: alignment,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            padding: EdgeInsets.symmetric(
              horizontal: large ? 13.w : 17.w,
              vertical: compact ? 10.h : 13.h,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasAttachment) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.file(
                      File(attachmentPath!),
                      width: maxWidth,
                      height: 120.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.insert_drive_file_outlined,
                        color: textColor,
                        size: 14.r,
                      ),
                      SizedBox(width: 5.w),
                      Flexible(
                        child: Text(
                          text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: textColor, fontSize: 10.sp),
                        ),
                      ),
                    ],
                  ),
                ] else
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: large ? 8.sp : 12.sp,
                      height: large ? 1.25 : 1.1,
                    ),
                  ),
              ],
            ),
          ),
          if (checked) ...[
            SizedBox(width: 3.w),
            Icon(
              Icons.check_circle_outline,
              color: AppColors.accentPurple,
              size: 14.r,
            ),
          ],
        ],
      ),
    );
  }
}

class _MessageComposer extends StatelessWidget {
  const _MessageComposer({
    required this.controller,
    required this.bottomPadding,
    required this.onAttach,
    required this.onSend,
  });

  final TextEditingController controller;
  final double bottomPadding;
  final VoidCallback onAttach;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(17.w, 10.h, 17.w, bottomPadding + 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: onAttach,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.all(2.r),
              child: Icon(
                Icons.add_photo_alternate_outlined,
                color: AppColors.whiteColor,
                size: 26.r,
              ),
            ),
          ),
          SizedBox(width: 7.w),
          Expanded(
            child: Container(
              height: 45.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(28.r),
                border: Border.all(color: AppColors.accentPurple, width: 1.w),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      style: TextStyle(color: AppColors.whiteColor),
                      cursorColor: AppColors.accentPurple,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => onSend(),
                      decoration: InputDecoration(
                        hintText: 'Message',
                        hintStyle: TextStyle(color: AppColors.lightHintColor),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onSend,
                    child: Container(
                      width: 38.r,
                      height: 38.r,
                      margin: EdgeInsets.only(right: 4.w),
                      decoration: const BoxDecoration(
                        color: AppColors.accentPurple,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_upward,
                        color: AppColors.whiteColor,
                        size: 22.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LocalChatMessage {
  const _LocalChatMessage({
    required this.text,
    this.isMine = false,
    this.timeLabel,
    this.attachmentPath,
    this.large = false,
    this.compact = false,
  });

  final String text;
  final bool isMine;
  final String? timeLabel;
  final String? attachmentPath;
  final bool large;
  final bool compact;

  double get widthFactor {
    if (attachmentPath != null) return 0.66;
    if (large) return 0.65;
    if (compact) return 0.70;
    if (text.length <= 18 && isMine) return 0.44;
    if (text.length <= 28) return isMine ? 0.56 : 0.58;
    return 0.70;
  }
}
