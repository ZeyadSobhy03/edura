import 'package:edura/core/resources/images/image_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/resources/text_style/text_style_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/loading_dots.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigate();
  }
  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;
    Navigator.pushNamed(context, RouteManger.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2553EB), Color(0xFF3D73EE)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  ImageManger.iconApp,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            SizedBox(height: 20),
            CustomText(text: l10.edura, style: TextStyleManager.appNameStyle),
            SizedBox(height: 10.h),
            CustomText(
              text: l10.yourLearningJourney,
              style: TextStyleManager.bodyTextStyle,
            ),
            SizedBox(height: 30.h),
            LoadingDots(),
          ],
        ),
      ),
    );
  }
}
