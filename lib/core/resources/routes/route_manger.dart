
import 'package:flutter/cupertino.dart';

import '../../../presentation/auth/forget_password/forget_password.dart';
import '../../../presentation/auth/login/login.dart';
import '../../../presentation/auth/register/register.dart';
import '../../../presentation/splash_screen/splash_screen.dart';

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
