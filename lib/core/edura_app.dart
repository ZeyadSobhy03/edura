import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:flutter/cupertino.dart';

class EduraApp extends StatelessWidget {
  const EduraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  CupertinoApp(

      debugShowCheckedModeBanner: false,
      initialRoute: RouteManger.splashRoute,
      onGenerateRoute: RouteManger.router,



    );
  }
}
