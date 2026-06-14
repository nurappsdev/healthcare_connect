import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// GeniusRX wordmark with the "HEALTHCARE HUB" tagline used on the auth screens.
class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.width = 187});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset('assets/logo.svg', width: width),
        const SizedBox(height: 10),
      ],
    );
  }
}
