import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/features/checkout/bindings/checkout_binding.dart';
import 'package:venturo_core/features/checkout/sub_features/discount/view/ui/discount_screen.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/view/ui/edit_menu_screen.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/view/ui/voucher_screen.dart';
import 'package:venturo_core/features/checkout/view/ui/checkout_screen.dart';
import 'package:venturo_core/features/detail_menu/bindings/detail_menu_binding.dart';
import 'package:venturo_core/features/detail_menu/view/ui/detail_menu_screen.dart';
import 'package:venturo_core/features/forgot_password/bindings/forgot_password_binding.dart';
import 'package:venturo_core/features/forgot_password/bindings/otp_binding.dart';
import 'package:venturo_core/features/forgot_password/view/ui/forgot_password_screen.dart';
import 'package:venturo_core/features/forgot_password/view/ui/otp_screen.dart';
import 'package:venturo_core/features/get_location/view/ui/get_location_screen.dart';
import 'package:venturo_core/features/list/bindings/list_binding.dart';
import 'package:venturo_core/features/list/sub_features/promo/view/ui/promo_screen.dart';
import 'package:venturo_core/features/list/view/ui/list_screen.dart';
import 'package:venturo_core/features/no_connection/view/ui/no_connection_screen.dart';
import 'package:venturo_core/features/order/bindings/order_binding.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/bindings/detail_order_binding.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/view/ui/detail_order_screen.dart';
import 'package:venturo_core/features/order/view/ui/order_screen.dart';
import 'package:venturo_core/features/profile/bindings/profile_binding.dart';
import 'package:venturo_core/features/profile/view/components/privacy_policy_screen.dart';
import 'package:venturo_core/features/profile/view/ui/profile_screen.dart';
import 'package:venturo_core/features/review/sub_features/write_review/view/ui/write_review_screen.dart';
import 'package:venturo_core/features/review/view/ui/review_screen.dart';
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
      page: () => const NoConnectionScreen(),
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
      page: () => const ProfileScreen(),
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
    GetPage(
      name: Routes.detailMenuRoute,
      page: () => const DetailMenuScreen(),
      binding: DetailMenuBinding(),
    ),
    GetPage(
      name: Routes.checkoutRoute,
      page: () => CheckoutScreen(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: Routes.orderRoute,
      page: () => const OrderScreen(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: Routes.orderDetailRoute,
      page: () => const DetailOrderScreen(),
      binding: DetailOrderBinding(),
    ),
    GetPage(
      name: Routes.editMenuRoute,
      page: () => const EditMenuScreen(),
    ),
    GetPage(
      name: Routes.promoRoute,
      page: () => const PromoScreen(),
    ),
    GetPage(
      name: Routes.voucherRoute,
      page: () => VoucherScreen(),
    ),
    GetPage(
      name: Routes.discountRoute,
      page: () => DiscountScreen(),
    ),
    GetPage(
      name: Routes.reviewRoute,
      page: () => ReviewScreen(),
    ),
    GetPage(
      name: Routes.writeReviewRoute,
      page: () => WriteReviewScreen(),
    ),
  ];
}
