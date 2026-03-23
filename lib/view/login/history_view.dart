import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stress_predition_app/common/colo_extension.dart';
import 'package:stress_predition_app/model/history_model.dart';
import 'package:stress_predition_app/service/history_service.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final HistoryService _historyService = HistoryService();

  Color _getStressColor(String level) {
    switch (level.toLowerCase()) {
      case 'severe':
        return Colors.redAccent;
      case 'moderate':
        return Colors.orangeAccent;
      case 'mild':
        return Colors.green;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
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
        child: SafeArea(
          child: StreamBuilder<List<HistoryModel>>(
            stream: _historyService.getHistory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }

              final historyList = snapshot.data ?? [];

              if (historyList.isEmpty) {
                return const Center(
                  child: Text(
                    "No history found",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: historyList.length,
                itemBuilder: (context, index) {
                  final item = historyList[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: _getStressColor(
                              item.stressLevel,
                            ).withOpacity(0.15),
                            child: Icon(
                              Icons.psychology,
                              color: _getStressColor(item.stressLevel),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.stressLevel.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: _getStressColor(item.stressLevel),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "Confidence: ${(item.confidence * 100).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    color: TColor.gray,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  DateFormat('dd MMM yyyy, hh:mm a').format(
                                    item.createdAt,
                                  ),
                                  style: TextStyle(
                                    color: TColor.gray,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await _historyService.deleteHistory(item.id);
                            },
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}