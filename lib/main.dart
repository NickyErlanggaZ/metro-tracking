import 'package:flutter/material.dart';
import 'package:metro_tracking_new/screens/splash_screen.dart';
import 'package:metro_tracking_new/utils/app_constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metro Tracking',
      theme: ThemeData(
        backgroundColor: const Color(0xFFFEFEFE),
        fontFamily: 'Poppins'
      ),
      routes: AppConstant.route,
      home: const SplashScreen(),
    );
  }
}
