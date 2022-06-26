import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:metro_tracking_new/domain/services/auth_service.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  AuthService auth = AuthService();

  login(context, String email, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (email == "" && password == "") {
      showToast('Username dan Password wajib diisi');
    } else {
      try {
        var response = await auth.login(email, password);
        var data = json.decode(response.body);
        debugPrint(response.body);
        if (response.statusCode == 200) {
          pref.setInt('user_id', data['id']);
          pref.setString('user_name', data['name']);
          pref.setString('user_email', data['email']);
          pref.setInt('user_deviceLimit', data['deviceLimit']);
          debugPrint("success login");
          Navigator.pushNamed(context, "/home");
        } else {
          showToast("Username dan password salah");
        }
      } catch (e) {
        showToast('$e');
      }
    }
  }
}
