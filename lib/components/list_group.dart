import 'package:flutter/material.dart';
import 'package:metro_tracking_new/domain/model/devices.dart';
import 'package:metro_tracking_new/screens/track_screen.dart';
import 'package:metro_tracking_new/utils/color_constant.dart';
import 'package:metro_tracking_new/utils/custom_icons.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';

class ListGroup extends StatelessWidget {
  final bool isCollapse;
  final Function(bool)? onExpand;
  final int groupId;
  final String groupName;
  final Future<List<Devices>> futureDevice;
  final int groupIndex;
  const ListGroup(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.futureDevice, required this.groupIndex, required this.isCollapse, this.onExpand})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _count = 0;
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: ColorConstant.backgroundColor,
            borderRadius: BorderRadius.circular(7),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  offset: Offset(2, 3),
                  blurRadius: 47),
            ]),
        child: FutureBuilder(
            future: futureDevice,
            builder: (BuildContext context, AsyncSnapshot snap) {
              if (!snap.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              for (var item in snap.data) {
                if (item.groupId == groupId) {
                  _count++;
                }
              }
              return ExpansionTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: ColorConstant.yellowShade,
                      borderRadius: BorderRadius.circular(8)),
                  child: Icon(iconLeading(groupName),
                      size: 20, color: ColorConstant.primaryColor),
                ),
                title: Text(groupName,
                    style: TextStyle(
                        color: ColorConstant.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                subtitle: Text("$_count items",
                    style: const TextStyle(
                        color: Color(0xFF878787),
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                trailing: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: const Color(0xFFEDEDED))),
                  child: Icon(!isCollapse
                    ? Icons.keyboard_arrow_right_rounded
                    : Icons.keyboard_arrow_down_rounded,color: ColorConstant.inActiveColor),
                ),
                onExpansionChanged: onExpand,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snap.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = snap.data[index];
                        var time = data.lastUpdate != null ? DateFormat('dd-MM-yyyy hh:mm a')
                            .format(DateTime.parse(data.lastUpdate)) : "null";
                        return data.groupId == groupId
                            ? InkWell(
                                onTap: () {
                                  data.lastUpdate != null ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TrackScreen(
                                              device: data, index: groupIndex, groupName: groupName,))) : showToast("Device belum pernah terhubung");
                                },
                                child: listTileDevice(data.name,
                                    data.attributes.platNomer ?? "null", time))
                            : const SizedBox();
                      })
                ],
              );
            }));
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

  Widget listTileDevice(String deviceName, String platNomer, lastUpdate) {
    return ListTile(
      title: Text(deviceName,
          style: TextStyle(
              color: ColorConstant.secondaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w500)),
      subtitle: Text(platNomer,
          style: TextStyle(
              color: ColorConstant.inActiveColor,
              fontSize: 14,
              fontWeight: FontWeight.w400)),
      trailing: Text(
        "Update\n$lastUpdate",
        textAlign: TextAlign.end,
        style: TextStyle(
            color: ColorConstant.inActiveColor,
            fontSize: 10,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
