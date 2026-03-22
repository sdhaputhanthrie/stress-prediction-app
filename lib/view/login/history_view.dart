import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Sample data for preview purposes
  final List<Map<String, dynamic>> sampleLogs = [
    {
      'stress_level': 'Severe',
      'timestamp': Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 4))),
    },
    {
      'stress_level': 'Moderate',
      'timestamp': Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 3))),
    },
    {
      'stress_level': 'Mild',
      'timestamp': Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 2))),
    },
    {
      'stress_level': 'Severe',
      'timestamp': Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 1))),
    },
    {
      'stress_level': 'Moderate',
      'timestamp': Timestamp.fromDate(DateTime.now()),
    },
  ];

  Future<String> _getUserName() async {
    if (currentUser == null) return "Sample User";
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).get();
      if (doc.exists && doc.data()!.containsKey('name')) {
        return doc.data()!['name'];
      }
      return currentUser!.displayName ?? "User";
    } catch (e) {
      return "User";
    }
  }

  int _getStressValue(String level) {
    switch (level.toLowerCase()) {
      case 'mild':
        return 1;
      case 'moderate':
        return 2;
      case 'severe':
        return 3;
      default:
        return 0;
    }
  }

  Color _getStressColor(String level) {
    return Colors.black; // As per your previous request
  }

  @override
  Widget build(BuildContext context) {
    // Process sample data for the chart
    final chartDocs = sampleLogs.reversed.toList();
    List<FlSpot> spots = [];
    for (int i = 0; i < chartDocs.length; i++) {
      final level = chartDocs[i]['stress_level']?.toString() ?? '';
      double val = _getStressValue(level).toDouble();
      spots.add(FlSpot(i.toDouble(), val));
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "History Preview",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF73D3E7), // light blue
              Color(0X82EDD4), // soft sky
              Color(0xFFA6F5E2),
              Color(0X82EDD4),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info
              FutureBuilder<String>(
                future: _getUserName(),
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: Colors.blueGrey, size: 30),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome back,",
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                            Text(
                              snapshot.data ?? "Loading...",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Chart Header
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Text(
                        "Stress Level Trend (Sample)",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    
                    // Line Chart
                    Container(
                      height: 220,
                      padding: const EdgeInsets.only(right: 20, left: 10, top: 20, bottom: 5),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(
                            show: true,
                            drawVerticalLine: true,
                            horizontalInterval: 1,
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 1,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  String text = '';
                                  switch (value.toInt()) {
                                    case 1: text = 'Mild'; break;
                                    case 2: text = 'Mod'; break;
                                    case 3: text = 'Severe'; break;
                                    default: return const Text('');
                                  }
                                  return Text(text, style: const TextStyle(fontSize: 10, color: Colors.black87));
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                interval: 1,
                                getTitlesWidget: (value, meta) {
                                  if (value.toInt() >= 0 && value.toInt() < chartDocs.length) {
                                    final date = (chartDocs[value.toInt()]['timestamp'] as Timestamp).toDate();
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(DateFormat('M/d').format(date), style: const TextStyle(fontSize: 10, color: Colors.black87)),
                                    );
                                  }
                                  return const Text('');
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(color: Colors.black12, width: 1),
                          ),
                          minX: 0,
                          maxX: (chartDocs.length - 1).toDouble(),
                          minY: 0,
                          maxY: 3.5,
                          lineBarsData: [
                            LineChartBarData(
                              spots: spots,
                              isCurved: true,
                              color: Colors.black,
                              barWidth: 3,
                              isStrokeCapRound: true,
                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 4,
                                    color: Colors.black,
                                    strokeWidth: 2,
                                    strokeColor: Colors.white,
                                  );
                                },
                              ),
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 15),

                    // Log Header
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Text(
                        "Recent Logs (Sample)",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    // Log List
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        itemCount: sampleLogs.length,
                        itemBuilder: (context, index) {
                          final data = sampleLogs[index];
                          final level = data['stress_level']?.toString() ?? 'unknown';
                          final timestamp = data['timestamp'] as Timestamp;
                          final dateText = DateFormat('MMM d, yyyy - h:mm a').format(timestamp.toDate());
                          final color = _getStressColor(level);
                          
                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 15,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dateText,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "$level Stress",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: color,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.monitor_heart, color: color, size: 30),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
