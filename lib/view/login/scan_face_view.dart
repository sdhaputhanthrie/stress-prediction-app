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
<<<<<<< HEAD
              Color(0X0082edd4), // soft sky
=======
              Color(0X82EDD4), // soft sky
>>>>>>> 7133660912f9050fe9af0ae4cac2c66219ca30e7
              Color(0xFFA6F5E2),
              Color.from(alpha: 0.892, red: 0.027, green: 0.867, blue: 0.671),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
<<<<<<< HEAD
      ),
    );
  }
}
=======
      )
    );
  }
}
>>>>>>> 7133660912f9050fe9af0ae4cac2c66219ca30e7
