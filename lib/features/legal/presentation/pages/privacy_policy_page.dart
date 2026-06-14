import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../core/theme/app_colors.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key, this.html});

  /// Policy markup to render. Falls back to [_defaultPolicyHtml] when null,
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.chevron_left,
                      color: AppColors.whiteColor,
                      size: 28,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Privacy Policy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.menu,
                      color: AppColors.whiteColor,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                child: HtmlWidget(
                  html ?? _defaultPolicyHtml,
                  textStyle: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14,
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

const String _defaultPolicyHtml = '''
<h2>Privacy Policy</h2>
<p>Last updated: June 2026</p>
<p>
  Healthcare Hub ("we", "our", or "us") is committed to protecting your privacy.
  This Privacy Policy explains how we collect, use, and safeguard your
  information when you use our application.
</p>

<h3>1. Information We Collect</h3>
<p>
  We collect information you provide directly, such as your name, email address,
  phone number, and professional details when you create an account.
</p>

<h3>2. How We Use Your Information</h3>
<p>
  We use the information we collect to operate, maintain, and provide the
  features and functionality of the service, as well as to communicate with you.
</p>

<h3>3. Sharing of Information</h3>
<p>
  We do not sell your personal information. We may share information with trusted
  partners who assist us in operating the application, subject to confidentiality
  obligations.
</p>

<h3>4. Data Security</h3>
<p>
  We implement appropriate technical and organizational measures to protect your
  personal data against unauthorized access, alteration, or disclosure.
</p>

<h3>5. Your Rights</h3>
<p>
  You may access, update, or delete your personal information at any time through
  your account settings, or by contacting us.
</p>

<h3>6. Contact Us</h3>
<p>
  If you have any questions about this Privacy Policy, please contact us at
  <a href="mailto:support@healthcarehub.app">support@healthcarehub.app</a>.
</p>
''';
