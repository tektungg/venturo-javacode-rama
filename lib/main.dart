import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'configs/pages/page.dart';
import 'configs/themes/theme.dart';
import 'utils/services/sentry_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://30fca41e405dfa6b23883af045e4658e@o4505883092975616.ingest.sentry.io/4506539099095040';
      options.tracesSampleRate = 1.0;
      options.beforeSend = filterSentryErrorBeforeSend;
    },
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    /// Screen Util Init berdasarkan ukuran iphone xr
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Venturo Core',
          debugShowCheckedModeBanner: false,
          locale: const Locale('id'),
          fallbackLocale: const Locale('id'),
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('id'),
          ],
          // initialBinding: , Jika memiliki global bindding
          initialRoute: Routes.splashRoute,
          theme: themeLight,
          defaultTransition: Transition.native,
          getPages: Pages.pages,
        );
      },
    );
  }
}