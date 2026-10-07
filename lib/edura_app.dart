import 'package:edura/config/theme/theme_manger.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:edura/core/cubit/language_cubit.dart';

import 'l10n/app_localizations.dart';

class EduraApp extends StatelessWidget {
  const EduraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale,
            color: ColorManager.white,
            theme: ThemeManger.light,

            debugShowCheckedModeBanner: false,
            initialRoute: RouteManger.splashRoute,
            onGenerateRoute: RouteManger.router,
          );
        },
      ),
    );
  }
}
