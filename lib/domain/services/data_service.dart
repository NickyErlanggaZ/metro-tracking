import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:metro_tracking_new/domain/model/devices.dart';
import 'package:metro_tracking_new/domain/model/groups.dart';
import 'package:metro_tracking_new/domain/model/positions.dart';
import 'package:metro_tracking_new/domain/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataService extends ApiService {
  Future<List<Groups>> getGroupsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userAuth = prefs.getString('user_auth');
    var data = json.decode(userAuth!);
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode(data['email'] + ":" + data['password']));
    final response = await client
        .get(Uri.parse(url + "/groups"), headers: {'authorization': basicAuth});
    debugPrint(response.body);
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Groups> group = items.map<Groups>((json) {
      return Groups.fromJson(json);
    }).toList();

    return group;
  }

  Future<List<Devices>> getDevicesList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userAuth = prefs.getString('user_auth');
    var data = json.decode(userAuth!);
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode(data['email'] + ":" + data['password']));
    final response = await client.get(Uri.parse(url + "/devices"),
        headers: {'authorization': basicAuth});
    debugPrint(response.body);
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Devices> device = items.map<Devices>((json) {
      return Devices.fromJson(json);
    }).toList();

    return device;
  }

  Future<List<Positions>> getPositionDevice(int deviceId, String from) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userAuth = prefs.getString('user_auth');
    var data = json.decode(userAuth!);
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode(data['email'] + ":" + data['password']));
    var fromstr = from.indexOf(" ");
    List time = [from.substring(0,fromstr).trim(), from.substring(fromstr+1).trim()];
    debugPrint("length: ${time.length} waktu: $time");
    final response = await client.get(Uri.parse(url + "/positions?deviceId=$deviceId"+"&from="+time[0]+"T"+time[1]),
        headers: {'authorization': basicAuth});
    debugPrint(response.body);
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Positions> position = items.map<Positions>((json) {
      return Positions.fromJson(json);
    }).toList();

    return position;
  }
}
