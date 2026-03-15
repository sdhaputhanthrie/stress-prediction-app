import 'package:flutter/material.dart';
import '../../common/colo_extension.dart';

class ScanFaceView extends StatefulWidget {
  const ScanFaceView({super.key});

  @override
  State<ScanFaceView> createState() => _ScanFaceViewState();
}

class _ScanFaceViewState extends State<ScanFaceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: TColor.gray),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Scan Face",
          style: TextStyle(color: TColor.gray, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF73D3E7), // light blue
              Color(0xFF82EDD4), // soft sky
              Color(0xFFA6F5E2),
              Color(0xFFB5ECD9), // light green
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // White Container for Face Scan Region
            Container(
              width: 250,
              height: 250,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: TColor.white,
                border: Border.all(
                  width: 1,
                  color: TColor.gray.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: TColor.gray,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.face,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "Place your face here",
                    style: TextStyle(
                      color: TColor.gray,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            
            // Start Scan Button
            SizedBox(
              width: 170,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement scan logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff334155), // Dark sleek color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  "Start Scan",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Cancel Button
            SizedBox(
              width: 170,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffCBD5E1), // Light Grey
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}