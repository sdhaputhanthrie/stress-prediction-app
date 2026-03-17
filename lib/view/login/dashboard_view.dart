import 'package:flutter/material.dart';
import 'package:stress_predition_app/common/colo_extension.dart';
import 'package:stress_predition_app/view/login/scan_face_view.dart';
import 'package:stress_predition_app/view/login/account_view.dart';
import 'package:stress_predition_app/view/login/history_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
          icon: Image.asset(
            "assets/img/back.png",
            width: 30,
            height: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          "Dashboard",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),

        centerTitle: true, 
      ),

      extendBodyBehindAppBar: true,

      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF73D3E7),
              Color(0xFF82EDD4),
              Color(0xFFA6F5E2),
              Color(0xFF82EDD4),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScanFaceView(),
                            ),
                          );
                        },
                        child: buildBox(
                          icon: Icons.camera_alt_outlined,
                          text: "Scan Face",
                        ),
                      ),

                      const SizedBox(width: 20),

                      GestureDetector(
                        onTap: () {},
                        child: buildBox(
                          icon: Icons.psychology,
                          text: "Stress Level",
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
                        child: buildBox(
                          icon: Icons.medical_services,
                          text: "First-Aid",
                        ),
                      ),

                      const SizedBox(width: 20),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoryView(),
                            ),
                          );
                        },
                        child: buildBox(
                          icon: Icons.history,
                          text: "History",
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
                        child: buildBox(
                          icon: Icons.emergency,
                          text: "Emergency SOS",
                        ),
                      ),

                      const SizedBox(width: 20),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountView(),
                            ),
                          );
                        },
                        child: buildBox(
                          icon: Icons.person,
                          text: "Account",
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
      ),
    );
  }


  Widget buildBox({required IconData icon, required String text}) {
    return Container(
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black, size: 50),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}