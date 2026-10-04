import 'package:edura/core/resources/images/image_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/resources/text_style/text_style_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/loading_dots.dart';
import 'package:edura/presentation/auth/login/data/data_source/local/login_hive_data_source.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LoginHiveDataSource _localDataSource = LoginHiveDataSource();

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser == null) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, RouteManger.loginRoute);
      return;
    }

    var role = await _localDataSource.getRole();
    role ??= await _resolveRoleFromServer(currentUser.id);

    if (role != null) {
      await _localDataSource.saveSession(
        userId: currentUser.id,
        role: role,
        email: currentUser.email,
      );
    }

    if (!mounted) return;
    if (role == 'teacher') {
      Navigator.pushReplacementNamed(context, RouteManger.teacherMainLayoutRoute);
    } else if (role == 'student') {
      Navigator.pushReplacementNamed(context, RouteManger.studentMainLayoutRoute);
    } else {
      Navigator.pushReplacementNamed(context, RouteManger.loginRoute);
    }
  }

  Future<String?> _resolveRoleFromServer(String userId) async {
    final supabase = Supabase.instance.client;

    final student = await supabase
        .from('students')
        .select('id')
        .eq('id', userId)
        .maybeSingle();

    if (student != null) {
      return 'student';
    }

    final teacher = await supabase
        .from('teacher')
        .select('id')
        .eq('id', userId)
        .maybeSingle();

    if (teacher != null) {
      return 'teacher';
    }

    return null;
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
