import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// GeniusRX wordmark with the "HEALTHCARE HUB" tagline used on the auth screens.
class BrandLogo extends StatelessWidget {
  BrandLogo({super.key, double? width}) : width = width ?? 187.w;

  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset('assets/logo.svg', width: width),
        SizedBox(height: 10.h),
      ],
    );
  }
}
