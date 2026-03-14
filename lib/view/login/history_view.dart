import 'package:flutter/material.dart';
import 'package:stress_predition_app/common/colo_extension.dart';
import 'package:stress_predition_app/common_widget/round_button.dart';
import 'package:stress_predition_app/common_widget/round_textfield.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
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