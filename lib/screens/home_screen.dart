import 'dart:async';

import 'package:flutter/material.dart';
import 'package:metro_tracking_new/components/list_group.dart';
import 'package:metro_tracking_new/screens/profile_screen.dart';
import 'package:metro_tracking_new/utils/app_constant.dart';
import 'package:metro_tracking_new/controller/home_controller.dart';
import 'package:metro_tracking_new/utils/color_constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = HomeController();

  @override
  void initState() {
    controller.group;
    controller.device;
    controller.getUserProfile();
    refresh();
    super.initState();
  }

  refresh() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: ColorConstant.primaryColor,
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 24.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: ColorConstant.secondaryColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    Text(
                      "Jl. Veteran, Malang",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorConstant.secondaryColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                                name: controller.name!,
                                email: controller.email!)));
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFFF8DB79), width: 3.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(controller.name ?? "null",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20)),
                          Text("Manager",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14)),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF8DB79),
                    hintText: "Search...",
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: ColorConstant.secondaryColor),
                    suffixIcon: Icon(Icons.search,
                        color: ColorConstant.secondaryColor, size: 25),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.transparent)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.transparent)),
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Kendaraan",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: ScreenSize(context).height * 0.48,
                    child: FutureBuilder(
                        future: controller.group,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                var data = snapshot.data[index];
                                return ListGroup(
                                    groupId: data.id, groupName: data.name, futureDevice: controller.device,);
                              });
                        }),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
