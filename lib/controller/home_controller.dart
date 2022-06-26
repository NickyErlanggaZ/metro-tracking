import 'package:metro_tracking_new/domain/model/devices.dart';
import 'package:metro_tracking_new/domain/model/groups.dart';
import 'package:metro_tracking_new/domain/services/data_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController{
  String? name;
  String? email;
  Future<List<Groups>> group = DataService().getGroupsList();
  Future<List<Devices>> device = DataService().getDevicesList();
  getUserProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    name = pref.getString('user_name');
    email = pref.getString('user_email');
  }
}