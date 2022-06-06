import 'dart:async';
import 'package:flutter/material.dart';
import 'package:metro_tracking_new/utils/image_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    splashScreen();
    super.initState();
  }

  splashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 108,
              child: Image.asset(ImageConstant.logo)),
            const Text(
              "Metro Tracking",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF636565),
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            )
          ],
        ),
      ),
    );
  }
}
