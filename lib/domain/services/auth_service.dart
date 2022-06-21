import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:metro_tracking_new/domain/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ApiService {
  login(String email, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };
    debugPrint(json.encode(data));
    pref.setString('user_auth', json.encode(data));
    return await client.post(Uri.parse(url + '/session'), body: data, headers: {
      'Content-type': 'application/x-www-form-urlencoded',
      'Accept': '*/*',
    });
  }

  logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString('user_auth');
    debugPrint(user);
    var data = await json.decode(user!);
    return await client.delete(Uri.parse(url + '/session'), body:data, headers: {
      'Content-type': 'application/x-www-form-urlencoded',
      'Accept': '*/*',
    }).then((value) => pref.clear());
  }
}
