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
    var userAuth = pref.getString('user_auth');
    var userAuthdecoded = json.decode(userAuth!);
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode(
            userAuthdecoded['email'] + ":" + userAuthdecoded['password']));
    return await client
        .delete(Uri.parse(url + '/session'), body: data, headers: {
      'Content-type': 'application/x-www-form-urlencoded',
      'authorization': basicAuth,
      'Accept': '*/*',
    }).then((value) async {
      if (value.statusCode == 204) {
        await pref.clear();
        debugPrint('SharedPref telah clear');
      }else{
        debugPrint('${value.body}');
      }
    });
  }

  changePassword(password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getInt('user_id');
    var userName = pref.getString('user_name');
    var userDeviceLimit = pref.getInt('user_deviceLimit');
    var userAuth = pref.getString('user_auth');
    var userAuthdecoded = json.decode(userAuth!);
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode(
            userAuthdecoded['email'] + ":" + userAuthdecoded['password']));
    Map<String, dynamic> data = {
      'id': userId,
      'name': userName,
      'email': userAuthdecoded['email'],
      'deviceLimit': userDeviceLimit,
      'password': password,
    };
    return await client.put(Uri.parse(url + '/users/$userId'),
        body: json.encode(data),
        headers: {
          'Content-type': 'application/json',
          'authorization': basicAuth,
          'Accept': '*/*',
        });
  }
}
