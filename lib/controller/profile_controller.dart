import 'package:flutter/widgets.dart';
import 'package:metro_tracking_new/domain/services/auth_service.dart';
import 'package:oktoast/oktoast.dart';

class ProfileController {
  AuthService auth = AuthService();
  logout(context) async {
    try {
      await auth.logout();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      showToast('$e');
    }
  }
}
