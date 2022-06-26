import 'package:flutter/material.dart';
import 'package:metro_tracking_new/controller/login_controller.dart';
import 'package:metro_tracking_new/utils/color_constant.dart';
import 'package:metro_tracking_new/utils/image_constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  LoginController controller = LoginController();
  bool _isHidden = true;

  @override
  void dispose() {
    controller.inputEmail.dispose();
    controller.inputPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
            child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(width: 108, child: Image.asset(ImageConstant.logo)),
            const Text(
              "Welcome to Metro Tracking",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF636565),
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(
                        fontSize: 14, color: ColorConstant.secondaryColor),
                  ),
                  TextField(
                    controller: controller.inputEmail,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF2F2F2),
                        hintText: "example@email.com",
                        hintStyle:
                            TextStyle(color: ColorConstant.inActiveColor),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent))),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "password",
                    style: TextStyle(
                        fontSize: 14, color: ColorConstant.secondaryColor),
                  ),
                  TextField(
                    controller: controller.inputPassword,
                    obscureText: _isHidden,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF2F2F2),
                        hintText: "password",
                        hintStyle:
                            TextStyle(color: ColorConstant.inActiveColor),
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              _isHidden = !_isHidden;
                            });
                          },
                          child: Icon(
                            _isHidden ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent))),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.login(context, controller.inputEmail.text,
                    controller.inputPassword.text);
              },
              style:
                  ElevatedButton.styleFrom(primary: ColorConstant.primaryColor),
              child: FractionallySizedBox(
                widthFactor: 1.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    "Sign In",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ColorConstant.backgroundColor),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
