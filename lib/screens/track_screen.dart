import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:metro_tracking_new/utils/color_constant.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:metro_tracking_new/utils/app_constant.dart';
import 'package:metro_tracking_new/utils/custom_icons.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({Key? key}) : super(key: key);

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  BitmapDescriptor? driver;
  Position? position;
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  Marker? driverMarker, destinationMarker;
  LatLng? driverPosition, destinationPosition;
  final CameraPosition _camera = const CameraPosition(
      target: LatLng(-7.9443456, 112.6193162), zoom: 19.151926040649414);

  static const LatLng _center = LatLng(45.521563, -122.677433);
  LatLng _lastMapPosition = _center;

  @override
  void initState() {
    super.initState();
  }

  bool _isCollapse = false;
  double _opacity = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SlidingUpPanel(
            onPanelSlide: (value) {
              setState(() {
                _opacity = 1.0 - value;
              });
            },
            maxHeight: ScreenSize(context).height * 0.9,
            minHeight: 150,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(32.0)),
            panel: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      width: ScreenSize(context).width * 0.5,
                      child: Divider(
                        color: ColorConstant.inActiveColor,
                        thickness: 4.0,
                      ),
                    ),
                  ),
                  Text(
                    "Kendaraan lainnya",
                    style: TextStyle(
                        color: ColorConstant.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            CustomIcons.truk,
                            size: 21,
                          ),
                          label: Container(
                            margin: EdgeInsets.only(left: 4),
                            child: Text("Truck"),
                          )),
                      OutlinedButton.icon(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0x63F8DB79),
                              side: BorderSide(
                                  color: ColorConstant.primaryColor)),
                          icon: Icon(
                            CustomIcons.mobil,
                            color: ColorConstant.primaryColor,
                            size: 21,
                          ),
                          label: Container(
                            margin: EdgeInsets.only(left: 4),
                            child: Text("Mobil",
                                style: TextStyle(
                                  color: ColorConstant.primaryColor,
                                )),
                          )),
                      OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            CustomIcons.motor,
                            size: 21,
                          ),
                          label: Container(
                            margin: EdgeInsets.only(left: 4),
                            child: Text("Motor"),
                          )),
                    ],
                  ),
                  ListTile(
                    title: Text("Toyota Yaris",
                        style: TextStyle(
                            color: ColorConstant.secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                    subtitle: Text("KH 92129 VN",
                        style: TextStyle(
                            color: ColorConstant.inActiveColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                    trailing: Text(
                      "Update\n08.23 AM",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: ColorConstant.inActiveColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned.fill(
                  child: GoogleMap(
                    mapType: MapType.normal,
                    zoomControlsEnabled: false,
                    initialCameraPosition: _camera,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: {
                      Marker(
                        markerId: MarkerId("coba"),
                        position: LatLng(-7.9443456, 112.6193162)
                      ),
                    },
                    onCameraMove: _onCameraMove,
                  ),
                ),
                Positioned(
                  top: 25,
                  child: Opacity(
                    opacity: _opacity,
                    child: Container(
                      width: 320,
                      margin:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                      decoration: BoxDecoration(
                          color: ColorConstant.backgroundColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.05),
                                offset: Offset(2, 3),
                                blurRadius: 47),
                          ]),
                      child: ExpansionTile(
                        onExpansionChanged: (value) => setState(() {
                          _isCollapse = value;
                          debugPrint("$_isCollapse");
                        }),
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: const Color(0x63F8DB79),
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(CustomIcons.mobil,
                              size: 25, color: ColorConstant.primaryColor),
                        ),
                        title: Text("Toyota Yaris",
                            style: TextStyle(
                                color: ColorConstant.secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                        subtitle: const Text("KH 92129",
                            style: TextStyle(
                                color: Color(0xFF878787),
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                        trailing: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color(0xFFF8DD7A),
                              borderRadius: BorderRadius.circular(9),
                              border:
                                  Border.all(color: const Color(0xFFEDEDED))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Detail",
                                style: TextStyle(
                                    color: ColorConstant.secondaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              Icon(
                                !_isCollapse
                                    ? Icons.keyboard_arrow_right_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                                size: 15,
                                color: ColorConstant.secondaryColor,
                              )
                            ],
                          ),
                        ),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Update"),
                                  Text("Status"),
                                  Text("Kecepatan"),
                                  Text("Posisi"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(":"),
                                  Text(":"),
                                  Text(":"),
                                  Text(":"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("08 Juni 2022 | 09:32 AM"),
                                  Text("On Valid"),
                                  Text("3 Km/h"),
                                  Text("-7.9443456, 112.6193162"),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }
}
