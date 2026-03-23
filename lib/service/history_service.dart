import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stress_predition_app/model/history_model.dart';

class HistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> get _historyRef {
    return _firestore.collection('users').doc(_uid).collection('history');
  }

  Future<void> addHistory({
    required String stressLevel,
    required double confidence,
    String? imagePath,
  }) async {
    final doc = _historyRef.doc();

    final history = HistoryModel(
      id: doc.id,
      stressLevel: stressLevel,
      confidence: confidence,
      imagePath: imagePath,
      createdAt: DateTime.now(),
    );

    await doc.set(history.toMap());
  }

  Stream<List<HistoryModel>> getHistory() {
    return _historyRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => HistoryModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<void> deleteHistory(String historyId) async {
    await _historyRef.doc(historyId).delete();
  }
}