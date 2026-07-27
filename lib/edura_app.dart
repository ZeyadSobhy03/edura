import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'l10n/app_localizations.dart';

class EduraApp extends StatelessWidget {
  const EduraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('ar'),

        debugShowCheckedModeBanner: false,
        initialRoute: RouteManger.splashRoute,
        onGenerateRoute: RouteManger.router,
      ),
    );
  }
}
