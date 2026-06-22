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
import '../../features/home/presentation/pages/chat_media_page.dart';
import '../../features/home/presentation/pages/chat_page.dart';
import '../../features/home/presentation/pages/cv_score_page.dart';
import '../../features/home/presentation/pages/find_job_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/job_details_page.dart';
import '../../features/home/presentation/pages/message_page.dart';
import '../../features/home/presentation/pages/report_user_page.dart';
import '../../features/legal/presentation/pages/privacy_policy_page.dart';
import '../../features/legal/presentation/pages/terms_of_service_page.dart';
import '../../features/profile/presentation/pages/add_bio_page.dart';
import '../../features/profile/presentation/pages/add_education_page.dart';
import '../../features/profile/presentation/pages/add_skills_page.dart';
import '../../features/profile/presentation/pages/contact_info_page.dart';
import '../../features/profile/presentation/pages/education_list_page.dart';
import '../../features/profile/presentation/pages/job_experience_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/profile_information_page.dart';
import '../../features/profile/presentation/pages/settings_page.dart';
import '../../features/profile/presentation/pages/upload_certificate_page.dart';
import '../../features/profile/presentation/pages/upload_resume_page.dart';
import '../../features/recruiter/presentation/pages/company_information_page.dart';
import '../../features/recruiter/presentation/pages/post_job_page.dart';
import '../../features/recruiter/presentation/pages/upload_license_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

/// Named route paths used across the app.
abstract class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const findJob = '/find-job';
  static const jobDetails = '/job-details';
  static const postJob = '/post-job';
  static const jobPrimaryInformation = '/job-primary-information';
  static const jobDescription = '/job-description';
  static const jobResponsibilities = '/job-responsibilities';
  static const jobRequirements = '/job-requirements';
  static const jobBenefits = '/job-benefits';
  static const jobPreview = '/job-preview';
  static const aboutCompany = '/about-company';
  static const cvScore = '/cv-score';
  static const chat = '/chat';
  static const chatMedia = '/chat-media';
  static const reportUser = '/report-user';
  static const reportUserDetails = '/report-user-details';
  static const emailVerification = '/email-verification';
  static const otpVerification = '/otp-verification';
  static const resetPassword = '/reset-password';
  static const signup = '/signup';
  static const createAccount = '/create-account';
  static const companyInformation = '/company-information';
  static const privacyPolicy = '/privacy-policy';
  static const termsOfService = '/terms-of-service';
  static const userProfile = '/user-profile';
  static const settings = '/settings';
  static const adminSupport = '/admin-support';
  static const changePassword = '/change-password';
  static const profileInformation = '/profile-information';
  static const addBio = '/add-bio';
  static const contactInfo = '/contact-info';
  static const addSkills = '/add-skills';
  static const addEducation = '/add-education';
  static const educationList = '/education-list';
  static const jobExperience = '/job-experience';
  static const uploadResume = '/upload-resume';
  static const uploadCertificate = '/upload-certificate';
  static const uploadLicense = '/upload-license';
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
        builder: (context, state) => HomePage(
          isRecruiter:
              state.extra == SignupRole.hiring ||
              state.extra == 'hiring' ||
              state.extra == true,
        ),
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
        path: AppRoutes.postJob,
        builder: (context, state) => const PostJobPage(),
      ),
      GoRoute(
        path: AppRoutes.jobPrimaryInformation,
        builder: (context, state) => const JobPrimaryInformationPage(),
      ),
      GoRoute(
        path: AppRoutes.jobDescription,
        builder: (context, state) => JobTextSectionPage(
          title: state.extra as String? ?? 'Job description',
        ),
      ),
      GoRoute(
        path: AppRoutes.jobResponsibilities,
        builder: (context, state) => JobTextSectionPage(
          title: state.extra as String? ?? 'Responsibilities',
        ),
      ),
      GoRoute(
        path: AppRoutes.jobRequirements,
        builder: (context, state) =>
            JobTextSectionPage(title: state.extra as String? ?? 'Requirements'),
      ),
      GoRoute(
        path: AppRoutes.jobBenefits,
        builder: (context, state) =>
            JobTextSectionPage(title: state.extra as String? ?? 'Benefits'),
      ),
      GoRoute(
        path: AppRoutes.jobPreview,
        builder: (context, state) => const JobPreviewPage(),
      ),
      GoRoute(
        path: AppRoutes.aboutCompany,
        builder: (context, state) =>
            AboutCompanyPage(companyName: state.extra as String? ?? 'McDonald'),
      ),
      GoRoute(
        path: AppRoutes.cvScore,
        builder: (context, state) =>
            CvScorePage(cvPath: state.extra as String?),
      ),
      GoRoute(
        path: AppRoutes.chat,
        builder: (context, state) => ChatPage(
          message: state.extra is MessagePreview
              ? state.extra as MessagePreview
              : const MessagePreview(
                  name: 'Isabella',
                  preview: 'hello how are you',
                  time: '1:30 PM',
                  colors: [Color(0xFF42D9D0), Color(0xFFEAB8A1)],
                ),
        ),
      ),
      GoRoute(
        path: AppRoutes.chatMedia,
        builder: (context, state) => const ChatMediaPage(),
      ),
      GoRoute(
        path: AppRoutes.reportUser,
        builder: (context, state) => const ReportUserPage(),
      ),
      GoRoute(
        path: AppRoutes.reportUserDetails,
        builder: (context, state) => ReportUserDetailsPage(
          reason: state.extra is ReportReason
              ? state.extra as ReportReason
              : ReportUserPage.reasons.first,
        ),
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
        builder: (context, state) => CreateAccountPage(
          role: state.extra is SignupRole ? state.extra as SignupRole : null,
        ),
      ),
      GoRoute(
        path: AppRoutes.companyInformation,
        builder: (context, state) => const CompanyInformationPage(),
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
        path: AppRoutes.userProfile,
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.adminSupport,
        builder: (context, state) => const AdminSupportPage(),
      ),
      GoRoute(
        path: AppRoutes.changePassword,
        builder: (context, state) => const ChangePasswordPage(),
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
      GoRoute(
        path: AppRoutes.uploadLicense,
        builder: (context, state) => const UploadLicensePage(),
      ),
    ],
  );
});
