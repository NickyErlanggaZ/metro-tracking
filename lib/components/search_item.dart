import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metro_tracking_new/domain/model/devices.dart';
import 'package:metro_tracking_new/domain/model/groups.dart';
import 'package:metro_tracking_new/screens/track_screen.dart';
import 'package:metro_tracking_new/utils/color_constant.dart';

class SearchItem extends StatelessWidget {
  final String search;
  final Future<List<Devices>> futureDevice;
  final List<Groups> group;
  const SearchItem(
      {Key? key,
      required this.futureDevice,
      required this.search,
      required this.group})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String groupName = "";
    return FutureBuilder(
      future: futureDevice,
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (!snap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: snap.data.length,
            itemBuilder: (BuildContext context, int index) {
              var data = snap.data[index];
              for (var item in group) {
                if (item.id == data.groupId &&
                    data.name.toLowerCase().contains(search.toLowerCase())) {
                  groupName = item.name;
                }
              }
              var time =
                  DateFormat('dd-MM-yyyy hh:mm a').format(data.lastUpdate);
              return data.name.toLowerCase().contains(search.toLowerCase())
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TrackScreen(
                                    device: data,
                                    index: index,
                                    groupName: groupName)));
                      },
                      child: listTileDevice(
                          data.name, data.attributes.platNomer ?? "null", time),
                    )
                  : const SizedBox();
            });
      },
    );
  }

  Widget listTileDevice(String deviceName, String platNomer, lastUpdate) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: ColorConstant.backgroundColor,
          borderRadius: BorderRadius.circular(7),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                offset: Offset(2, 3),
                blurRadius: 47),
          ]),
      child: ListTile(
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
      ),
    );
  }
}
