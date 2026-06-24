import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../core/theme/app_colors.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key, this.html});

  /// Terms markup to render. Falls back to [_defaultTermsHtml] when null,
  /// so the screen can be shown before content is loaded from the backend.
  final String? html;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar: back, centered title, menu
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      Icons.chevron_left,
                      color: AppColors.whiteColor,
                      size: 28.r,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Terms of Service',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      Icons.menu,
                      color: AppColors.whiteColor,
                      size: 22.r,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 24.h),
                child: HtmlWidget(
                  html ?? _defaultTermsHtml,
                  textStyle: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14.sp,
                    height: 1.5,
                  ),
                  customStylesBuilder: (element) {
                    if (element.localName == 'a') {
                      return {'color': '#5F03EC', 'text-decoration': 'none'};
                    }
                    if (element.localName == 'h1' ||
                        element.localName == 'h2' ||
                        element.localName == 'h3') {
                      return {'color': '#FFFFFF', 'margin': '16px 0 8px'};
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const String _defaultTermsHtml = '''
<h2>Terms of Service</h2>
<p>Last updated: June 2026</p>
<p>
  Welcome to Healthcare Hub. These Terms of Service ("Terms") govern your access
  to and use of our application. By creating an account or using the service, you
  agree to be bound by these Terms.
</p>

<h3>1. Acceptance of Terms</h3>
<p>
  By accessing or using the application, you confirm that you can form a binding
  contract with us and that you accept these Terms and agree to comply with them.
</p>

<h3>2. Use of the Service</h3>
<p>
  You agree to use the service only for lawful purposes and in accordance with
  these Terms. You are responsible for keeping your account credentials secure and
  for all activity that occurs under your account.
</p>

<h3>3. User Responsibilities</h3>
<p>
  You agree to provide accurate, current, and complete information during
  registration and to keep it up to date. You must not misuse the service or
  interfere with its normal operation.
</p>

<h3>4. Intellectual Property</h3>
<p>
  All content, features, and functionality of the application are owned by
  Healthcare Hub and are protected by applicable intellectual property laws. You
  may not copy, modify, or distribute any part of the service without permission.
</p>

<h3>5. Termination</h3>
<p>
  We may suspend or terminate your access to the service at any time, without prior
  notice, if you breach these Terms or engage in conduct that we consider harmful
  to the service or other users.
</p>

<h3>6. Limitation of Liability</h3>
<p>
  The service is provided "as is" without warranties of any kind. To the fullest
  extent permitted by law, Healthcare Hub shall not be liable for any indirect or
  consequential damages arising from your use of the service.
</p>

<h3>7. Changes to These Terms</h3>
<p>
  We may update these Terms from time to time. Continued use of the service after
  any changes constitutes your acceptance of the revised Terms.
</p>

<h3>8. Contact Us</h3>
<p>
  If you have any questions about these Terms, please contact us at
  <a href="mailto:support@healthcarehub.app">support@healthcarehub.app</a>.
</p>
''';
