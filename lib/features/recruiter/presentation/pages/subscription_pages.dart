import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

const _white = AppColors.whiteColor;
const _border = AppColors.cardBorderColor;
const _purple = AppColors.accentPurple;
const _muted = AppColors.lightHintColor;
const _card = AppColors.darkCardColor;
const _gold = Color(0xFFF5C518);
const _green = Color(0xFF22C55E);

/// Shared back-button + centered "Subscription" header.
class _SubHeader extends StatelessWidget {
  const _SubHeader();

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
                'Subscription',
                style: TextStyle(
                  color: _white,
                  fontSize: 18.sp,
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

/// Screen 1: no active subscription yet.
class SubscriptionEmptyPage extends StatelessWidget {
  const SubscriptionEmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            _SubHeader(),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.workspace_premium, color: _gold, size: 64.r),
                    SizedBox(height: 18.h),
                    Text(
                      'You cannot purchased any\nsubscription plan yet !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _white,
                        fontSize: 14.sp,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 26.h),
                    SizedBox(
                      height: 48.h,
                      child: OutlinedButton(
                        onPressed: () =>
                            context.push(AppRoutes.subscriptionPlans),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _white,
                          side: const BorderSide(color: _border),
                          padding: EdgeInsets.symmetric(horizontal: 28.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.r),
                          ),
                        ),
                        child: Text(
                          'Purchased now',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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

/// Screen 2: an active subscription with management entry point.
class SubscriptionActivePage extends StatelessWidget {
  const SubscriptionActivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            _SubHeader(),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                decoration: BoxDecoration(
                  color: _card,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    Icon(Icons.workspace_premium, color: _gold, size: 48.r),
                    SizedBox(height: 14.h),
                    Text(
                      'MEMBERSHIP PLAN',
                      style: TextStyle(
                        color: _muted,
                        fontSize: 10.sp,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Active ( Pro )',
                      style: TextStyle(
                        color: _green,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.r),
                      child: LinearProgressIndicator(
                        value: 0.5,
                        minHeight: 6.h,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation(_purple),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Your will be end in March 03, 2025',
                      style: TextStyle(color: _muted, fontSize: 10.sp),
                    ),
                    SizedBox(height: 18.h),
                    SizedBox(
                      width: double.infinity,
                      height: 46.h,
                      child: ElevatedButton(
                        onPressed: () =>
                            context.push(AppRoutes.subscriptionPlans),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _purple,
                          foregroundColor: _white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                        child: Text(
                          'Manage subscription',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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

/// A subscription plan shown on [SubscriptionPlansPage].
class SubscriptionPlan {
  const SubscriptionPlan({
    required this.name,
    required this.price,
    required this.features,
  });

  final String name;
  final String price;
  final List<String> features;
}

/// Screen 3: a swipeable carousel of plans to purchase.
class SubscriptionPlansPage extends StatelessWidget {
  const SubscriptionPlansPage({super.key});

  static const _plans = [
    SubscriptionPlan(
      name: 'Basic Plan',
      price: '2',
      features: [
        'Test quiz',
        'With learn',
        'Learn many topics',
        'Give exam for test learning',
        'View tutorial',
        'Get content for learning',
      ],
    ),
    SubscriptionPlan(
      name: 'Pro Plan',
      price: '5',
      features: [
        'Everything in Basic',
        'Unlimited quizzes',
        'Priority support',
        'Advanced analytics',
        'Downloadable resources',
        'Certificate of completion',
      ],
    ),
    SubscriptionPlan(
      name: 'Premium Plan',
      price: '9',
      features: [
        'Everything in Pro',
        'One-on-one mentoring',
        'Early access features',
        'Team collaboration',
        'Custom learning paths',
        'Dedicated account manager',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            _SubHeader(),
            SizedBox(height: 16.h),
            Expanded(
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.86),
                itemCount: _plans.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: _PlanCard(
                    plan: _plans[index],
                    onPurchase: () =>
                        context.push(AppRoutes.subscriptionActive),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.plan, required this.onPurchase});

  final SubscriptionPlan plan;
  final VoidCallback onPurchase;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(22.w, 24.h, 22.w, 18.h),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plan.name,
            style: TextStyle(
              color: _white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.h),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '\$ ',
                  style: TextStyle(
                    color: _green,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: plan.price,
                  style: TextStyle(
                    color: _white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: ' /month',
                  style: TextStyle(color: _muted, fontSize: 14.sp),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          ...plan.features.map((f) => _FeatureRow(f)),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: onPurchase,
              style: ElevatedButton.styleFrom(
                backgroundColor: _purple,
                foregroundColor: _white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                ),
              ),
              child: Text(
                'Purchase',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 12.h),
    child: Row(
      children: [
        Icon(Icons.check_circle, color: _green, size: 18.r),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: _white, fontSize: 12.sp),
          ),
        ),
      ],
    ),
  );
}
