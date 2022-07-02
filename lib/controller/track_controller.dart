import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:metro_tracking_new/domain/model/devices.dart';
import 'package:metro_tracking_new/domain/model/groups.dart';
import 'package:metro_tracking_new/domain/model/positions.dart';
import 'package:metro_tracking_new/domain/services/data_service.dart';
import 'package:metro_tracking_new/utils/custom_icons.dart';
import 'package:metro_tracking_new/utils/image_constant.dart';

class TrackController {
  Future<List<Groups>> group = DataService().getGroupsList();
  Future<List<Devices>> device = DataService().getDevicesList();
  TabController tabController(int length, TickerProvider vsync) {
    return TabController(length: length, vsync: vsync);
  }

  Future<List<Positions>> position(int deviceId, String from) {
    return DataService().getPositionDevice(deviceId, from);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> moveCamera(Completer<GoogleMapController>_controller, LatLng position, double zoom) async {
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: position,
      zoom: zoom,
    )));
  }

  Future<BitmapDescriptor> markerIcon(String groupName) async {
    switch (groupName) {
      case "Mobil":
        Uint8List markerIcon =
            await getBytesFromAsset(ImageConstant.mobil, 100);
        return BitmapDescriptor.fromBytes(markerIcon);
      case "Motor":
        Uint8List markerIcon =
            await getBytesFromAsset(ImageConstant.motor, 100);
        return BitmapDescriptor.fromBytes(markerIcon);
      case "Truk":
        Uint8List markerIcon = await getBytesFromAsset(ImageConstant.truk, 100);
        return BitmapDescriptor.fromBytes(markerIcon);
      default:
        return BitmapDescriptor.defaultMarker;
    }
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
