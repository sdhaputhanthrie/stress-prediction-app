import 'package:stress_predition_app/common/colo_extension.dart';
import 'package:stress_predition_app/view/login/scan_face_view.dart';
import 'package:flutter/material.dart';
import 'package:stress_predition_app/view/login/profile_view.dart';
import 'account_page.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF73D3E7),
              Color(0X82EDD4),
              Color(0xFFA6F5E2),
              Color(0X82EDD4),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
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

                  // 🔹 ROW 1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Scan Face
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
                          title: "Scan Face",
                        ),
                      ),

                      const SizedBox(width: 20),

                      // Stress Level
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileView(),
                            ),
                          );
                        },
                        child: buildBox(
                          icon: Icons.psychology,
                          title: "Stress Level",
                          iconSize: 60,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // 🔹 ROW 2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildBox(
                        icon: Icons.medical_services,
                        title: "First-Aid",
                      ),
                      const SizedBox(width: 20),
                      buildBox(icon: Icons.history, title: "History"),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // 🔹 ROW 3
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildBox(icon: Icons.emergency, title: "Emergency SOS"),

                      const SizedBox(width: 20),

                      // ✅ ACCOUNT BUTTON (UPDATED)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountPage(),
                            ),
                          );
                        },
                        child: buildBox(
                          icon: Icons.person,
                          title: "Account",
                          iconSize: 60,
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

  // 🔹 Reusable Box Widget (Cleaner UI)
  Widget buildBox({
    required IconData icon,
    required String title,
    double iconSize = 50,
  }) {
    return Container(
      width: 170,
      height: 170,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: TColor.white,
        border: Border.all(width: 1, color: TColor.gray.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black, size: iconSize),
          const SizedBox(height: 10),
          Text(
            title,
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
