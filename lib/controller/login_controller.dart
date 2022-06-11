import 'package:flutter/widgets.dart';
import 'package:metro_tracking_new/domain/services/auth_service.dart';

class LoginController{
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  AuthService auth = AuthService();

  login(context, String email, String password) async {
    var response = await auth.postSession(email, password);
    print(response.body);
      try {
        if(response.statusCode == 200){
          print("success login");
          Navigator.pushNamed(context, "/home");
        }else{
          print("gagal: ${response.statusCode}");
        }
      } catch (e) {
        print(e);
      }
  }
}