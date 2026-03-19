import 'package:flutter/material.dart';
import '../../common/colo_extension.dart';

class StressLevelView extends StatelessWidget {
  final String stressLevel;

  const StressLevelView({super.key, required this.stressLevel});

  @override
  Widget build(BuildContext context) {
    // Determine color and icon based on stress level
    Color resultColor;
    IconData resultIcon;
    String recommendation;

    switch (stressLevel.toLowerCase()) {
      case 'severe':
        resultColor = Colors.redAccent;
        resultIcon = Icons.warning_amber_rounded;
        recommendation = "High stress detected. Please take a break, try breathing exercises, or consider speaking to a professional.";
        break;
      case 'moderate':
        resultColor = Colors.orangeAccent;
        resultIcon = Icons.sentiment_neutral_rounded;
        recommendation = "Moderate stress detected. Make sure to stay hydrated, stretch, and relax.";
        break;
      case 'mild':
      default:
        resultColor = Colors.green;
        resultIcon = Icons.sentiment_satisfied_alt_rounded;
        recommendation = "Low stress detected. You're doing great! Keep up the good work.";
        break;
    }

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
          "Stress Result",
          style: TextStyle(color: TColor.gray, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF73D3E7),
              Color(0xFF82EDD4),
              Color(0xFFA6F5E2),
              Color(0xFFB5ECD9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Result Card
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                color: TColor.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "Your Stress Level",
                    style: TextStyle(
                      color: TColor.gray,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: resultColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      resultIcon,
                      color: resultColor,
                      size: 70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    stressLevel.toUpperCase(),
                    style: TextStyle(
                      color: resultColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    recommendation,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: TColor.gray,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Finish Button
            SizedBox(
              width: 170,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  // Go back to dashboard or home, popping until first route
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff334155),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  "Done",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
