import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:metro_tracking_new/components/detail_kendaraan.dart';
import 'package:metro_tracking_new/controller/track_controller.dart';
import 'package:metro_tracking_new/domain/model/devices.dart';
import 'package:metro_tracking_new/domain/model/positions.dart';
import 'package:metro_tracking_new/utils/color_constant.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:metro_tracking_new/utils/app_constant.dart';

class TrackScreen extends StatefulWidget {
  final Devices device;
  const TrackScreen({Key? key, required this.device}) : super(key: key);

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  TrackController controller = TrackController();
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = LatLng(45.521563, -122.677433);
  LatLng _lastMapPosition = _center;
  Future<List<Positions>>? _position;

  @override
  void initState() {
    _position =
        controller.position(widget.device.id, "${widget.device.lastUpdate}");
    _refresh();
    super.initState();
  }

  void _refresh() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  bool _isCollapse = false;
  double _opacity = 1.0;
  int _groupId = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _position,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
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
                                  length: snapshot.data.length,
                                  child: Column(
                                    children: [
                                      TabBar(
                                        onTap: (value) {
                                          setState(() {
                                            _groupId = snapshot.data[value].id;
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
                                                          return item.id ==
                                                                  data.groupId
                                                              ? ListTile(
                                                                  title: Text(
                                                                      data.name,
                                                                      style: TextStyle(
                                                                          color: ColorConstant
                                                                              .secondaryColor,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w500)),
                                                                  subtitle: Text(
                                                                      data.attributes
                                                                          .platNomer,
                                                                      style: TextStyle(
                                                                          color: ColorConstant
                                                                              .inActiveColor,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w400)),
                                                                  trailing:
                                                                      Text(
                                                                    "Update\n08.23 AM",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style: TextStyle(
                                                                        color: ColorConstant
                                                                            .inActiveColor,
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w400),
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
                        child: GoogleMap(
                          mapType: MapType.normal,
                          zoomControlsEnabled: false,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(snapshot.data[0].latitude,
                                  snapshot.data[0].longitude),
                              zoom: 19.151926040649414),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          markers: {
                            Marker(
                                markerId: MarkerId("coba"),
                                position: LatLng(snapshot.data[0].latitude,
                                    snapshot.data[0].longitude)),
                          },
                          onCameraMove: _onCameraMove,
                        ),
                      ),
                      Positioned(
                        top: 25,
                        child: Opacity(
                          opacity: _opacity,
                          child: DetailKendaraan(
                            data: widget.device,
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
