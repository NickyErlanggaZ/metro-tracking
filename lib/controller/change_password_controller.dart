import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:metro_tracking_new/domain/services/auth_service.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordController {
  TextEditingController inputOldPassword = TextEditingController();
  TextEditingController inputNewPassword = TextEditingController();
  AuthService auth = AuthService();

  changePassword(oldPassword, newPassword) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (oldPassword == "" && newPassword == "") {
      showToast("Password lama dan baru harus diisi");
    } else {
      try {
        var userAuth = pref.getString('user_auth');
        var data = json.decode(userAuth!);
        if (data['password'] != oldPassword) {
          showToast('Password lama salah');
        } else {
          var response = await auth.changePassword(newPassword);
          if (response.statusCode == 200) {
            data['password'] = newPassword;
            pref.setString('user_auth', json.encode(data));
            debugPrint('${response.body}');
            showToast('Password berhasil dirubah');
          } else { 
            showToast('${response.body}');
          }
        }
      } catch (e) {
        showToast('$e');
      }
    }
  }
}
