import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxi_booking/core/utils/app_theme.dart';
import 'core/app_export.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.bottomBarScreen,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      getPages: AppRoutes.pages,
      defaultTransition: Transition.cupertino,
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
    );
  }
}
