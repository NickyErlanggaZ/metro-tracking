import 'package:flutter/material.dart';
import 'package:metro_tracking_new/controller/profile_controller.dart';
import 'package:metro_tracking_new/utils/color_constant.dart';
import 'package:metro_tracking_new/utils/app_constant.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  ProfileController controller = ProfileController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Column(
            children: [
              Container(
                  width: ScreenSize(context).width,
                  color: ColorConstant.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFFF8DB79), width: 3.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(height: 8),
                      Text("Manager",
                          style: TextStyle(
                              color: ColorConstant.secondaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                      Text("Courtney Henry",
                          style: TextStyle(
                              color: ColorConstant.secondaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                      Text("courtneyhenry@gmail.com",
                          style: TextStyle(
                              color: ColorConstant.secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Container(
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
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xFFF8DB79),
                          borderRadius: BorderRadius.circular(8)),
                      child: Icon(Icons.warning_amber_rounded,
                          size: 30, color: ColorConstant.primaryColor),
                    ),
                    title: const Text("Keamanan",
                        style: TextStyle(
                            color: Color(0xFF878787),
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                    subtitle: Text("Ubah Password",
                        style: TextStyle(
                            color: ColorConstant.secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                ),
              )
            ],
          )),
          Positioned(
              bottom: 36,
              left: 20,
              child: ElevatedButton.icon(
                onPressed: () {
                  controller.logout(context);
                },
                style:
                    ElevatedButton.styleFrom(primary: const Color(0xFFFBE9AE)),
                icon: Icon(Icons.exit_to_app,
                    color: ColorConstant.secondaryColor),
                label: Text("Log Out",
                    style: TextStyle(color: ColorConstant.secondaryColor)),
              ))
        ],
      ),
    );
  }
}
