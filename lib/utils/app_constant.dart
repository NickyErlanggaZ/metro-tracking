import 'package:flutter/material.dart';
import 'package:metro_tracking_new/screens/home_screen.dart';
import 'package:metro_tracking_new/screens/login_screen.dart';
import 'package:metro_tracking_new/screens/profile_screen.dart';

class AppConstant {
  static Map<String, Widget Function(BuildContext)> route = {
    '/login': (context) => const LoginScreen(),
    '/home' : (context) => const HomeScreen(),
    '/profile' : (context) => const ProfileScreen(),
  };
}

extension ScreenSize on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}
