import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:metro_tracking_new/components/detail_kendaraan.dart';
import 'package:metro_tracking_new/controller/track_controller.dart';
import 'package:metro_tracking_new/domain/model/devices.dart';
import 'package:metro_tracking_new/domain/model/positions.dart';
import 'package:metro_tracking_new/utils/color_constant.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:metro_tracking_new/utils/app_constant.dart';

// ignore: must_be_immutable
class TrackScreen extends StatefulWidget {
  Devices device;
  int index;
  String groupName;
  TrackScreen(
      {Key? key,
      required this.device,
      required this.index,
      required this.groupName})
      : super(key: key);

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  TrackController controller = TrackController();
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = LatLng(45.521563, -122.677433);
  LatLng _lastMapPosition = _center;
  Future<List<Positions>>? _position;
  late Future<BitmapDescriptor> _markerIcon;

  @override
  void initState() {
    _position =
        controller.position(widget.device.id, "${widget.device.lastUpdate}");
    _markerIcon = controller.markerIcon(widget.groupName);
    _refresh();
    super.initState();
  }

  void _refresh() {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        setState(() {
          _position = controller.position(
              widget.device.id, "${widget.device.lastUpdate}");
        });
      }
    });
  }

  bool _isCollapse = false;
  double _opacity = 1.0;
  int _groupId = 0;
  Positions? posisi;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _position,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container(
                color: ColorConstant.backgroundColor,
                child: const Center(child: CircularProgressIndicator()));
          }
          if (snapshot.hasData) {
            posisi = snapshot.data[0];
          }
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
                        FutureBuilder(
                            future: controller.group,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return DefaultTabController(
                                  initialIndex: widget.index,
                                  length: snapshot.data.length,
                                  child: Column(
                                    children: [
                                      TabBar(
                                        onTap: (value) {
                                          setState(() {
                                            _groupId = snapshot.data[value].id;
                                            widget.index = value;
                                          });
                                        },
                                        labelColor: ColorConstant.primaryColor,
                                        unselectedLabelColor:
                                            ColorConstant.inActiveColor,
                                        indicatorColor:
                                            ColorConstant.primaryColor,
                                        indicator: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  ColorConstant.primaryColor),
                                          color: ColorConstant.yellowShade,
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                        ),
                                        isScrollable: true,
                                        tabs: [
                                          for (var item in snapshot.data)
                                            Tab(
                                                child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  controller
                                                      .iconLeading(item.name),
                                                  size: 21,
                                                ),
                                                const SizedBox(width: 15),
                                                Text(item.name)
                                              ],
                                            ))
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            ScreenSize(context).height * 0.5,
                                        child: TabBarView(
                                          children: [
                                            for (var item in snapshot.data)
                                              FutureBuilder(
                                                  future: controller.device,
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    }
                                                    return ListView.builder(
                                                        itemCount: snapshot
                                                            .data.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          var data = snapshot
                                                              .data[index];
                                                          var time = DateFormat(
                                                                  'dd-MM-yyyy hh:mm a')
                                                              .format(data
                                                                  .lastUpdate);
                                                          return item.id ==
                                                                  data.groupId
                                                              ? InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      widget.device =
                                                                          data;
                                                                      _position = controller.position(
                                                                          data.id,
                                                                          "${data.lastUpdate}");
                                                                      _markerIcon =
                                                                          controller
                                                                              .markerIcon(item.name);
                                                                      controller.moveCamera(
                                                                          _controller,
                                                                          LatLng(
                                                                              posisi!.latitude,
                                                                              posisi!.longitude),
                                                                          20);
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration: widget.device.id ==
                                                                            data
                                                                                .id
                                                                        ? BoxDecoration(
                                                                            color: const Color(
                                                                                0xFFFEF9EB),
                                                                            borderRadius: BorderRadius.circular(
                                                                                7),
                                                                            border: Border.all(
                                                                                color: const Color(
                                                                                    0xFFF3C201)),
                                                                            boxShadow: const [
                                                                                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.05), offset: Offset(2, 3), blurRadius: 47),
                                                                              ])
                                                                        : BoxDecoration(
                                                                            color:
                                                                                ColorConstant.backgroundColor,
                                                                            borderRadius: BorderRadius.circular(7),
                                                                            boxShadow: const [
                                                                                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.05), offset: Offset(2, 3), blurRadius: 47),
                                                                              ]),
                                                                    child:
                                                                        ListTile(
                                                                      title: Text(
                                                                          data
                                                                              .name,
                                                                          style: TextStyle(
                                                                              color: ColorConstant.secondaryColor,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w500)),
                                                                      subtitle: Text(
                                                                          data.attributes
                                                                              .platNomer,
                                                                          style: TextStyle(
                                                                              color: ColorConstant.inActiveColor,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w400)),
                                                                      trailing:
                                                                          Text(
                                                                        "Update\n$time",
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style: TextStyle(
                                                                            color: ColorConstant
                                                                                .inActiveColor,
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : const SizedBox();
                                                        });
                                                  })
                                          ],
                                        ),
                                      ),
                                    ],
                                  ));
                            }),
                      ],
                    ),
                  ),
                  body: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned.fill(
                        child: FutureBuilder(
                            future: _markerIcon,
                            builder: (context, AsyncSnapshot snap) {
                              if (!snap.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return GoogleMap(
                                mapType: MapType.normal,
                                zoomControlsEnabled: false,
                                initialCameraPosition: CameraPosition(
                                    target: LatLng(snapshot.data[0].latitude,
                                        snapshot.data[0].longitude),
                                    zoom: 20),
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                },
                                markers: {
                                  Marker(
                                      icon: snap.data,
                                      markerId: MarkerId(widget.device.name),
                                      position: LatLng(
                                          snapshot.data[0].latitude,
                                          snapshot.data[0].longitude)),
                                },
                                onCameraMove: _onCameraMove,
                              );
                            }),
                      ),
                      Positioned(
                        top: 25,
                        child: Opacity(
                          opacity: _opacity,
                          child: DetailKendaraan(
                            data: widget.device,
                            position: snapshot.data[0],
                            isCollapse: _isCollapse,
                            onExpand: (value) => setState(() {
                              _isCollapse = value;
                              debugPrint("$_isCollapse");
                            }),
                          ),
                        ),
                      ),
                    ],
                  )));
        });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }
}
