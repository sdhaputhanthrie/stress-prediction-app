import 'package:flutter/material.dart';

class FirstAidAllView extends StatefulWidget {
  const FirstAidAllView({super.key});

  @override
  State<FirstAidAllView> createState() => _FirstAidAllViewState();
}

class _FirstAidAllViewState extends State<FirstAidAllView> {
  // Collapsed/expanded state for each stress level
  Map<String, bool> isExpanded = {
    "Severe": true,
    "Moderate": false,
    "Mild": false,
  };

  // First-Aid steps for all stress levels
  final Map<String, List<String>> stressSteps = {
    "Severe": [
      "Find a quiet safe place",
      "Slow breathing: inhale 4 sec, exhale 6 sec",
      "Call someone you trust",
      "Avoid decisions now",
      "Seek professional help",
    ],
    "Moderate": [
      "Take a short break",
      "Drink water",
      "Stretch your body",
      "Talk to someone",
    ],
    "Mild": [
      "Keep your routine",
      "Stay hydrated",
      "Do something you enjoy",
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Aid Guidance"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), // smooth scrolling
          padding: const EdgeInsets.all(20),
          child: Column(
            children: stressSteps.entries.map((entry) {
              String level = entry.key;
              List<String> steps = entry.value;

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    // Header: Tap to expand/collapse
                    ListTile(
                      tileColor: Colors.white,
                      title: Text(
                        "$level Stress",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(
                        isExpanded[level]!
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                      ),
                      onTap: () {
                        setState(() {
                          isExpanded[level] = !isExpanded[level]!;
                        });
                      },
                    ),

                    // Expanded content
                    if (isExpanded[level]!)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Column(
                          children: steps.asMap().entries.map((stepEntry) {
                            int index = stepEntry.key;
                            String step = stepEntry.value;
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    Colors.blueAccent.withOpacity(0.2),
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              title: Text(
                                step,
                                style: const TextStyle(color: Colors.black87),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}