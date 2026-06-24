import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';

class ChatMediaPage extends StatelessWidget {
  const ChatMediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(21.w, 10.h, 21.w, 0),
          child: Column(
            children: [
              _SimpleHeader(title: 'Media', onBack: () => context.pop()),
              SizedBox(height: 38.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 7.w,
                  mainAxisSpacing: 8.h,
                  childAspectRatio: 1.29,
                ),
                itemBuilder: (context, index) => const _CertificateCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SimpleHeader extends StatelessWidget {
  const _SimpleHeader({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: onBack,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.tight(Size(32.r, 32.r)),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.whiteColor,
                size: 20.r,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _CertificateCard extends StatelessWidget {
  const _CertificateCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(11.r),
      decoration: BoxDecoration(
        color: const Color(0xFFE7E7E7),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8EC),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(width: 17.w, color: const Color(0xFF78969A)),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: ClipPath(
                clipper: _RibbonClipper(),
                child: Container(width: 40.w, color: const Color(0xFF78969A)),
              ),
            ),
            Positioned(
              left: 13.w,
              top: 23.h,
              child: Container(
                width: 17.r,
                height: 17.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF78969A), width: 2),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 27.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'CERTIFICATE',
                      style: TextStyle(
                        color: const Color(0xFF78969A),
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
                      ),
                    ),
                    Text(
                      'OF APPRECIATION',
                      style: TextStyle(
                        color: const Color(0xFF78969A),
                        fontSize: 6.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      height: 1,
                      width: 48.w,
                      color: const Color(0xFF78969A),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Name Surname',
                      style: TextStyle(
                        color: const Color(0xFF998D77),
                        fontSize: 8.sp,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RibbonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height * 0.5)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
