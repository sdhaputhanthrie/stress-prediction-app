import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/colo_extension.dart';
import '../../common_widget/round_button.dart';

class EmergencyView extends StatefulWidget {
  const EmergencyView({super.key});

  @override
  State<EmergencyView> createState() => _EmergencyViewState();
}

class _EmergencyViewState extends State<EmergencyView> {
  String contactName = "";
  String contactPhone = "";

  @override
  void initState() {
    super.initState();
    loadEmergencyContact();
  }

  // Load emergency contact from Firestore
  Future<void> loadEmergencyContact() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (doc.exists) {
        final data = doc.data();
        setState(() {
          contactName = data?['emergencyContact']?['contactName'] ?? '';
          contactPhone = data?['emergencyContact']?['contactPhone'] ?? '';
        });
      }
    } catch (e) {
      print("Error loading emergency contact: $e");
    }
  }

  // Call a phone number
  Future<void> callNumber(String phone) async {
    final Uri uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Could not launch phone dialer")));
    }
  }

  // Send an SMS
  Future<void> sendSMS(String phone, String message) async {
    final Uri uri = Uri(
      scheme: 'sms',
      path: phone,
      queryParameters: {'body': message},
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Could not launch SMS app")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency SOS"),
        backgroundColor: TColor.primaryColor1,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF73D3E7),
              Color(0xFF82EDD4),
              Color(0xFFA6F5E2),
              Color(0xFF07DDAA),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              "Emergency Contact",
              style: TextStyle(
                color: TColor.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              contactName.isNotEmpty
                  ? "$contactName\n$contactPhone"
                  : "No contact saved",
              textAlign: TextAlign.center,
              style: TextStyle(color: TColor.white, fontSize: 18),
            ),
            const SizedBox(height: 40),
            RoundButton(
              title: "Call Contact",
              onPressed: () {
                if (contactPhone.isNotEmpty) {
                  callNumber(contactPhone);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No contact saved")),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            RoundButton(
              title: "Send SMS",
              onPressed: () {
                if (contactPhone.isNotEmpty) {
                  sendSMS(contactPhone, "I need help! Please contact me.");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No contact saved")),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            RoundButton(
              title: "Call  Ambulance",
              onPressed: () =>
                  callNumber("1990"), // replace with local emergency number
            ),
          ],
        ),
      ),
    );
  }
}
