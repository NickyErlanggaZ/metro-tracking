import 'package:flutter/material.dart';
import 'package:metro_tracking_new/utils/app_constant.dart';
import 'package:metro_tracking_new/utils/color_constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 28),
              width: ScreenSize(context).width,
              height: ScreenSize(context).height * 0.328125,
              decoration: BoxDecoration(color: ColorConstant.primaryColor),
              child: Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: ColorConstant.secondaryColor,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                          labelText: "Username",
                          labelStyle:
                              TextStyle(color: ColorConstant.secondaryColor)),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: TextEditingController(),
                      obscureText: true,
                      decoration: const InputDecoration(labelText: "Password"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 25,
              child: SizedBox(
                width: ScreenSize(context).width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 56),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: ColorConstant.primaryColor),
                        child: FractionallySizedBox(
                          widthFactor: 1.0,
                          child: Text(
                            "Masuk",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: ColorConstant.secondaryColor),
                          ),
                        ),
                      ),
                      TextButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, "/search");
                          },
                          style: TextButton.styleFrom(
                              primary: ColorConstant.secondaryColor),
                          icon: const Text("Lacak Paket Anda"),
                          label: const Icon(Icons.arrow_forward_ios_outlined))
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
