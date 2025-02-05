import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/features/no_connection/view/ui/no_connection_screen.dart';
import 'package:venturo_core/features/sign_in/bindings/sign_in_binding.dart';
import 'package:venturo_core/features/sign_in/view/ui/sign_in_screen.dart';
import 'package:venturo_core/features/splash/bindings/splash_binding.dart';
import 'package:venturo_core/features/splash/view/ui/splash_screen.dart';

abstract class Pages {
  static final pages = [
    GetPage(
      name: Routes.splashRoute,
      page: () => SplashScreen(),
      binding: SplashBinding()
    ),
        GetPage(
      name: Routes.noConnectionRoute,
      page: () => NoConnectionScreen(),
    ),
    GetPage(
      name: Routes.signInRoute,
      page: () => SignInScreen(),
      binding: SignInBindding(),
    ),
  ];
}
