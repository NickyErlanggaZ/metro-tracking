import 'package:flutter/material.dart';
import 'package:metro_tracking_new/controller/change_password_controller.dart';
import 'package:metro_tracking_new/utils/color_constant.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  ChangePasswordController controller = ChangePasswordController();
  bool _isHiddenOld = true;
  bool _isHiddenNew = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Ubah Password',
              style: TextStyle(color: ColorConstant.secondaryColor)),
          backgroundColor: ColorConstant.primaryColor,
          iconTheme: IconThemeData(color: ColorConstant.secondaryColor),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password Lama",
                  style: TextStyle(
                      fontSize: 14, color: ColorConstant.secondaryColor),
                ),
                TextField(
                  controller: controller.inputOldPassword,
                  obscureText: _isHiddenOld,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF2F2F2),
                      hintText: "Password Lama",
                      hintStyle: TextStyle(color: ColorConstant.inActiveColor),
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            _isHiddenOld = !_isHiddenOld;
                          });
                        },
                        child: Icon(
                          _isHiddenOld
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Password Baru",
                  style: TextStyle(
                      fontSize: 14, color: ColorConstant.secondaryColor),
                ),
                TextField(
                  controller: controller.inputNewPassword,
                  obscureText: _isHiddenNew,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF2F2F2),
                      hintText: "Password Baru",
                      hintStyle: TextStyle(color: ColorConstant.inActiveColor),
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            _isHiddenNew = !_isHiddenNew;
                          });
                        },
                        child: Icon(
                          _isHiddenNew
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent))),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.changePassword(controller.inputOldPassword.text,
                        controller.inputNewPassword.text);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: ColorConstant.primaryColor),
                  child: FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        "Ubah",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorConstant.backgroundColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
