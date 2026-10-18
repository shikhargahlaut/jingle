import 'package:get/get.dart';
import 'app_routes.dart';
import '../bindings/initial_binding.dart';
import '../pages/main_app_shell.dart';
import '../../features/splash/pages/splash_page.dart';
import '../../features/splash/bindings/splash_binding.dart';
import '../../features/authentication/pages/login_page.dart';
import '../../features/authentication/pages/signup_page.dart';
import '../../features/authentication/pages/forgot_password_page.dart';
import '../../features/authentication/bindings/auth_binding.dart';
import '../../features/interests/pages/interests_page.dart';
import '../../features/interests/pages/dating_profile_setup_page.dart';
import '../../features/interests/pages/media_connections_page.dart';
import '../../features/interests/bindings/interests_binding.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/home/bindings/home_binding.dart';
import '../../features/swipe/pages/swipe_page.dart';
import '../../features/swipe/pages/swipe_profile_detail_page.dart';
import '../../features/swipe/bindings/swipe_binding.dart';
import '../../features/profile/pages/profile_page.dart';
import '../../features/profile/bindings/profile_binding.dart';

/// Centralized route mapping for GetX navigation with splash startup guard.
abstract class AppPages {
  static const String initial = AppRoutes.splash;

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.datingProfileSetup,
      page: () => const DatingProfileSetupPage(),
      binding: InterestsBinding(),
    ),
    GetPage(
      name: AppRoutes.mediaConnections,
      page: () => const MediaConnectionsPage(),
      binding: InterestsBinding(),
    ),
    GetPage(
      name: AppRoutes.interests,
      page: () => const InterestsPage(),
      binding: InterestsBinding(),
    ),
    GetPage(
      name: AppRoutes.mainApp,
      page: () => const MainAppShell(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: AppRoutes.feed,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.swipe,
      page: () => const SwipePage(),
      binding: SwipeBinding(),
    ),
    GetPage(
      name: AppRoutes.swipeProfileDetail,
      page: () => const SwipeProfileDetailPage(),
      binding: SwipeBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
  ];
}
