import 'package:flutter/material.dart';

class ScanFaceView extends StatefulWidget {
  const ScanFaceView({super.key});

  @override
  State<ScanFaceView> createState() => _ScanFaceViewState();
}

class _ScanFaceViewState extends State<ScanFaceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF73D3E7), // light blue
              Color(0X82EDD4), // soft sky
              Color(0xFFA6F5E2),
              Color.from(alpha: 0.892, red: 0.027, green: 0.867, blue: 0.671),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      )
    );
  }
}