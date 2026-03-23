import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  final String id;
  final String stressLevel;
  final double confidence;
  final String? imagePath;
  final DateTime createdAt;

  HistoryModel({
    required this.id,
    required this.stressLevel,
    required this.confidence,
    required this.createdAt,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'stressLevel': stressLevel,
      'confidence': confidence,
      'imagePath': imagePath,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory HistoryModel.fromMap(String id, Map<String, dynamic> map) {
    return HistoryModel(
      id: id,
      stressLevel: map['stressLevel'] ?? '',
      confidence: (map['confidence'] ?? 0).toDouble(),
      imagePath: map['imagePath'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}