import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metro_tracking_new/domain/model/devices.dart';
import 'package:metro_tracking_new/domain/model/groups.dart';
import 'package:metro_tracking_new/domain/model/positions.dart';
import 'package:metro_tracking_new/domain/services/data_service.dart';
import 'package:metro_tracking_new/utils/custom_icons.dart';

class TrackController{
  Future<List<Groups>> group = DataService().getGroupsList();
  Future<List<Devices>> device = DataService().getDevicesList();
  TabController tabController(int length, TickerProvider vsync){
    return TabController(length: length, vsync: vsync);
  }
  Future<List<Positions>> position(int deviceId,String from){
    return DataService().getPositionDevice(deviceId,from);
  }
  IconData iconLeading(String groupName) {
    switch (groupName) {
      case "Mobil":
        return CustomIcons.mobil;
      case "Motor":
        return CustomIcons.motor;
      case "Truk":
        return CustomIcons.truk;
      default:
        return CustomIcons.question_mark;
    }
  }
}