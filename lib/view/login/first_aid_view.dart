import 'package:flutter/material.dart';

class FirstAidView extends StatefulWidget {
  final String stressLevel;

  const FirstAidView({super.key, required this.stressLevel});

  @override
  State<FirstAidView> createState() => _FirstAidViewState();
}

class _FirstAidViewState extends State<FirstAidView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  List<String> steps = [];
  String breathingText = "";

  @override
  void initState() {
    super.initState();

    // 🔹 Animation (breathing effect)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 120, end: 180).animate(_controller);

    // 🔹 Set steps based on stress level
    switch (widget.stressLevel.toLowerCase()) {
      case 'severe':
        steps = [
          "Find a quiet safe place",
          "Slow breathing: inhale 4 sec, exhale 6 sec",
          "Call someone you trust",
          "Avoid decisions now",
          "Seek professional help",
        ];
        breathingText = "Breathe Slowly";
        break;

      case 'moderate':
        steps = [
          "Take a short break",
          "Drink water",
          "Stretch your body",
          "Talk to someone",
        ];
        breathingText = "Relax Your Breath";
        break;

      default:
        steps = [
          "Keep your routine",
          "Stay hydrated",
          "Do something you enjoy",
        ];
        breathingText = "Stay Calm";
        break;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Make AppBar transparent to match the gradient background
      appBar: AppBar(
        title: const Text("First Aid Guidance"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: kToolbarHeight + 20,
              ), // Safe spacing for AppBar
              const Text(
                "Follow These Steps",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // 🌬 Breathing Animation Circle
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    width: _animation.value,
                    height: _animation.value,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        breathingText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              // 📋 Steps
              Expanded(
                child: ListView.builder(
                  itemCount: steps.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white70,
                        child: Text(
                          "${index + 1}",
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ),
                      title: Text(
                        steps[index],
                        style: const TextStyle(color: Colors.black87),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
