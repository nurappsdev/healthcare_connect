import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/create_account_page.dart';
import '../../features/auth/presentation/pages/email_verification_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/home/presentation/pages/about_company_page.dart';
import '../../features/home/presentation/pages/find_job_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/job_details_page.dart';
import '../../features/legal/presentation/pages/privacy_policy_page.dart';
import '../../features/legal/presentation/pages/terms_of_service_page.dart';
import '../../features/profile/presentation/pages/add_bio_page.dart';
import '../../features/profile/presentation/pages/add_education_page.dart';
import '../../features/profile/presentation/pages/add_skills_page.dart';
import '../../features/profile/presentation/pages/contact_info_page.dart';
import '../../features/profile/presentation/pages/education_list_page.dart';
import '../../features/profile/presentation/pages/job_experience_page.dart';
import '../../features/profile/presentation/pages/profile_information_page.dart';
import '../../features/profile/presentation/pages/upload_certificate_page.dart';
import '../../features/profile/presentation/pages/upload_resume_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

/// Named route paths used across the app.
abstract class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const findJob = '/find-job';
  static const jobDetails = '/job-details';
  static const aboutCompany = '/about-company';
  static const emailVerification = '/email-verification';
  static const otpVerification = '/otp-verification';
  static const resetPassword = '/reset-password';
  static const signup = '/signup';
  static const createAccount = '/create-account';
  static const privacyPolicy = '/privacy-policy';
  static const termsOfService = '/terms-of-service';
  static const profileInformation = '/profile-information';
  static const addBio = '/add-bio';
  static const contactInfo = '/contact-info';
  static const addSkills = '/add-skills';
  static const addEducation = '/add-education';
  static const educationList = '/education-list';
  static const jobExperience = '/job-experience';
  static const uploadResume = '/upload-resume';
  static const uploadCertificate = '/upload-certificate';
}

/// Application [GoRouter], exposed as a provider so navigation config can be
/// composed with the rest of the Riverpod graph.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 1450),
          child: const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.findJob,
        builder: (context, state) =>
            FindJobPage(jobs: state.extra as List<String>?),
      ),
      GoRoute(
        path: AppRoutes.jobDetails,
        builder: (context, state) =>
            JobDetailsPage(companyName: state.extra as String? ?? 'McDonald'),
      ),
      GoRoute(
        path: AppRoutes.aboutCompany,
        builder: (context, state) =>
            AboutCompanyPage(companyName: state.extra as String? ?? 'McDonald'),
      ),
      GoRoute(
        path: AppRoutes.emailVerification,
        builder: (context, state) => const EmailVerificationPage(),
      ),
      GoRoute(
        path: AppRoutes.otpVerification,
        builder: (context, state) =>
            OtpVerificationPage(email: state.extra as String?),
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) => const ResetPasswordPage(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: AppRoutes.createAccount,
        builder: (context, state) => const CreateAccountPage(),
      ),
      GoRoute(
        path: AppRoutes.privacyPolicy,
        builder: (context, state) =>
            PrivacyPolicyPage(html: state.extra as String?),
      ),
      GoRoute(
        path: AppRoutes.termsOfService,
        builder: (context, state) =>
            TermsOfServicePage(html: state.extra as String?),
      ),
      GoRoute(
        path: AppRoutes.profileInformation,
        builder: (context, state) => const ProfileInformationPage(),
      ),
      GoRoute(
        path: AppRoutes.addBio,
        builder: (context, state) => const AddBioPage(),
      ),
      GoRoute(
        path: AppRoutes.contactInfo,
        builder: (context, state) => const ContactInfoPage(),
      ),
      GoRoute(
        path: AppRoutes.addSkills,
        builder: (context, state) => const AddSkillsPage(),
      ),
      GoRoute(
        path: AppRoutes.addEducation,
        builder: (context, state) => const AddEducationPage(),
      ),
      GoRoute(
        path: AppRoutes.educationList,
        builder: (context, state) => const EducationListPage(),
      ),
      GoRoute(
        path: AppRoutes.jobExperience,
        builder: (context, state) => const JobExperiencePage(),
      ),
      GoRoute(
        path: AppRoutes.uploadResume,
        builder: (context, state) => const UploadResumePage(),
      ),
      GoRoute(
        path: AppRoutes.uploadCertificate,
        builder: (context, state) => const UploadCertificatePage(),
      ),
    ],
  );
});
