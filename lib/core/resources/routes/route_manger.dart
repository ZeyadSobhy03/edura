import 'package:edura/core/presentation/auth/forget_password/forget_password.dart';
import 'package:edura/core/presentation/auth/login/login.dart';
import 'package:edura/core/presentation/auth/register/register.dart';
import 'package:edura/core/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';

class RouteManger {
  static const String initialRoute = '/';
  static const String eduraAppRoute = '/eduraApp';
  static const String registerRoute = '/register';
  static const String forgetPasswordRoute = '/forgetPassword';
  static const String loginRoute = '/login';
  static const String splashRoute = '/splashScreen';

  static Route router(RouteSettings settings) {
    switch (settings.name) {
      case registerRoute:
        return CupertinoPageRoute(
          builder: (context) {
            return Register();
          },
        );

      case forgetPasswordRoute:
        return CupertinoPageRoute(
          builder: (context) {
            return ForgetPassword();
          },
        );

      case loginRoute:
        return CupertinoPageRoute(
          builder: (context) {
            return Login();
          },
        );

      case splashRoute:
        return CupertinoPageRoute(
          builder: (context) {
            return SplashScreen();
          },
        );

      default:
        return CupertinoPageRoute(
          builder: (context) {
            return const CupertinoPageScaffold(
              child: Center(child: Text('No Route Found')),
            );
          },
        );
    }
  }
}
