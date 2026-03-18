import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // Gradient colors
  final List<Color> gradientColors = [
    Color(0xFF73D3E7),
    Color(0xFF82EDD4),
    Color(0xFFA6F5E2),
    Color(0xFF82EDD4),
  ];

  // Controllers
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController emergencyName = TextEditingController();
  TextEditingController emergencyPhone = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  // 🔥 LOAD DATA (FIXED HERE)
  void loadData() async {
    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();

    if (doc.exists) {
      final data = doc.data()!;

      setState(() {
        fullName.text = data["fullName"] ?? "";
        email.text = data["email"] ?? "";
        age.text = data["age"] ?? "";
        gender.text = data["gender"] ?? "";

        // ✅ FIXED: read from nested object
        emergencyName.text = data["emergencyContact"]?["contactName"] ?? "";

        emergencyPhone.text = data["emergencyContact"]?["contactPhone"] ?? "";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Account"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 100, 16, 16),
            child: Column(
              children: [
                CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),

                SizedBox(height: 20),

                // Personal Info
                TextField(
                  controller: fullName,
                  readOnly: true,
                  decoration: InputDecoration(labelText: "Full Name"),
                ),

                TextField(
                  controller: email,
                  readOnly: true,
                  decoration: InputDecoration(labelText: "Email"),
                ),

                TextField(
                  controller: age,
                  readOnly: true,
                  decoration: InputDecoration(labelText: "Age"),
                ),

                TextField(
                  controller: gender,
                  readOnly: true,
                  decoration: InputDecoration(labelText: "Gender"),
                ),

                SizedBox(height: 20),

                Text(
                  "Emergency Contact",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                TextField(
                  controller: emergencyName,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Emergency Contact Name",
                  ),
                ),

                TextField(
                  controller: emergencyPhone,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Emergency Phone Number",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
