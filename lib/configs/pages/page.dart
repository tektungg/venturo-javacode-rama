import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/features/forgot_password/bindings/forgot_password_binding.dart';
import 'package:venturo_core/features/forgot_password/bindings/otp_binding.dart';
import 'package:venturo_core/features/forgot_password/view/ui/forgot_password_screen.dart';
import 'package:venturo_core/features/forgot_password/view/ui/otp_screen.dart';
import 'package:venturo_core/features/get_location/view/ui/get_location_screen.dart';
import 'package:venturo_core/features/list/bindings/list_binding.dart';
import 'package:venturo_core/features/list/view/ui/list_screen.dart';
import 'package:venturo_core/features/no_connection/view/ui/no_connection_screen.dart';
import 'package:venturo_core/features/profile/bindings/profile_binding.dart';
import 'package:venturo_core/features/profile/view/components/privacy_policy_screen.dart';
import 'package:venturo_core/features/profile/view/ui/profile_screen.dart';
import 'package:venturo_core/features/sign_in/bindings/sign_in_binding.dart';
import 'package:venturo_core/features/sign_in/view/ui/sign_in_screen.dart';
import 'package:venturo_core/features/splash/bindings/splash_binding.dart';
import 'package:venturo_core/features/splash/view/ui/splash_screen.dart';

abstract class Pages {
  static final pages = [
    GetPage(
        name: Routes.splashRoute,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    GetPage(
      name: Routes.noConnectionRoute,
      page: () => NoConnectionScreen(),
    ),
    GetPage(
      name: Routes.signInRoute,
      page: () => const SignInScreen(),
      binding: SignInBindding(),
    ),
    GetPage(
      name: Routes.forgotPasswordRoute,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.otpRoute,
      page: () => const OtpScreen(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: Routes.profileRoute,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.privacyPolicyRoute,
      page: () => const PrivacyPolicyScreen(),
    ),
    GetPage(
      name: Routes.getLocationRoute,
      page: () => const GetLocationScreen(),
    ),
    GetPage(
      name: Routes.listRoute,
      page: () => const ListScreen(),
      binding: ListBinding(),
    ),
  ];
}
