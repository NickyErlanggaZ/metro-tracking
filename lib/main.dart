import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:metro_tracking_new/screens/splash_screen.dart';
import 'package:metro_tracking_new/utils/app_constant.dart';
import 'package:metro_tracking_new/utils/color_constant.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  HttpOverrides.global = MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      position: ToastPosition.bottom,
      child: MaterialApp(
        title: 'Metro Tracking',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: ColorConstant.primaryColor,
            backgroundColor: ColorConstant.backgroundColor,
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                primary: ColorConstant.inActiveColor,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                shape: const StadiumBorder(),
                side: BorderSide(color: ColorConstant.inActiveColor,)
              ),
            ),
            fontFamily: 'Poppins'),
        routes: AppConstant.route,
        home: const SplashScreen(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
