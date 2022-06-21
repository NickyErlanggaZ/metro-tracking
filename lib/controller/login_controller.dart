import 'package:flutter/widgets.dart';
import 'package:metro_tracking_new/domain/services/auth_service.dart';
import 'package:oktoast/oktoast.dart';

class LoginController {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  AuthService auth = AuthService();

  login(context, String email, String password) async {
    var response = await auth.login(email, password);
    if (email == "" && password == "") {
      showToast('Username dan Password wajib diisi');
    } else {
      try {
        debugPrint(response.body);
        if (response.statusCode == 200) {
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
