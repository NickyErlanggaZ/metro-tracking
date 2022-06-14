import 'package:flutter/material.dart';
import 'package:metro_tracking_new/utils/color_constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                  onTap: (){
                    Navigator.pushNamed(context, "/profile");
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
                        children: const [
                          Text("Courtney Henry",
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Kendaraan",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                        color: ColorConstant.backgroundColor,
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.05),
                              offset: Offset(2, 3),
                              blurRadius: 47),
                        ]),
                    child: ExpansionTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xFFF8DB79),
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(Icons.warning_amber_rounded,
                            size: 30, color: ColorConstant.primaryColor),
                      ),
                      title: Text("Mobil",
                          style: TextStyle(
                              color: ColorConstant.secondaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      subtitle: const Text("10 items",
                          style: TextStyle(
                              color: Color(0xFF878787),
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                      trailing: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(color: const Color(0xFFEDEDED))),
                        child: const Icon(Icons.arrow_forward_ios_outlined),
                      ),
                      children: [
                        ListTile(
                          title: Text("Toyota Yaris",
                              style: TextStyle(
                                  color: ColorConstant.secondaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          subtitle: const Text("KH 92129 VN",
                              style: TextStyle(
                                  color: Color(0xFF878787),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                          trailing: const Text(
                            "Update\n08.23 AM",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Color(0xFF878787),
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
