import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metro_tracking_new/domain/model/devices.dart';
import 'package:metro_tracking_new/domain/model/positions.dart';
import 'package:metro_tracking_new/utils/color_constant.dart';
import 'package:metro_tracking_new/utils/custom_icons.dart';

class DetailKendaraan extends StatelessWidget {
  final bool isCollapse;
  final Function(bool)? onExpand;
  final Devices data;
  final Positions position;
  const DetailKendaraan(
      {Key? key,
      required this.isCollapse,
      this.onExpand,
      required this.data,
      required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var time = DateFormat('dd MMM yyyy | hh:mm a').format(DateTime.parse(data.lastUpdate));
    return Container(
      width: 320,
      margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
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
        onExpansionChanged: onExpand,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: const Color(0x63F8DB79),
              borderRadius: BorderRadius.circular(8)),
          child: Icon(CustomIcons.mobil,
              size: 25, color: ColorConstant.primaryColor),
        ),
        title: Text(data.name,
            style: TextStyle(
                color: ColorConstant.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        subtitle: Text(data.attributes.platNomer!,
            style: const TextStyle(
                color: Color(0xFF878787),
                fontSize: 14,
                fontWeight: FontWeight.w400)),
        trailing: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: const Color(0xFFF8DD7A),
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: const Color(0xFFEDEDED))),
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
                !isCollapse
                    ? Icons.keyboard_arrow_right_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 15,
                color: ColorConstant.secondaryColor,
              )
            ],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Update",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.dark)),
                    Text("Status",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.dark)),
                    Text("Kecepatan",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.dark)),
                    Text("Posisi",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.dark)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(":",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.dark)),
                    Text(":",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.dark)),
                    Text(":",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.dark)),
                    Text(":",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.dark)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(time,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.dark)),
                    Text(data.status,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.dark)),
                    Text("${position.speed} Km/h",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.dark)),
                    Text("${position.latitude}, ${position.longitude}",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.dark)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
