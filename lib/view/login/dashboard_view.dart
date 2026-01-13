import 'package:stress_predition_app/common/colo_extension.dart';
import 'package:stress_predition_app/common_widget/round_button.dart';
import 'package:stress_predition_app/common_widget/round_textfield.dart';

import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    "Dashboard",
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 170,
                        height: 170,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: TColor.white,
                          border: Border.all(
                            width: 1,
                            color: TColor.gray.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        // child: Image.asset(
                        //   "assets/img/camera.png",
                        //   width: 20,
                        //   height: 20,
                        // ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black,
                          size: 30.0,
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 170,
                        height: 170,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: TColor.white,
                          border: Border.all(
                            width: 1,
                            color: TColor.gray.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Image.asset(
                          "assets/img/facebook.png",
                          width: 45,
                          height: 45,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 170,
                        height: 170,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: TColor.white,
                          border: Border.all(
                            width: 1,
                            color: TColor.gray.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Image.asset(
                          "assets/img/google.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 170,
                        height: 170,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: TColor.white,
                          border: Border.all(
                            width: 1,
                            color: TColor.gray.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Image.asset(
                          "assets/img/facebook.png",
                          width: 45,
                          height: 45,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
