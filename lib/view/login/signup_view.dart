import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stress_predition_app/view/login/login_view.dart';
import '../../common/colo_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';
import 'dashboard_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController contactNameController = TextEditingController();
  final TextEditingController contactPhoneController = TextEditingController();
  final TextEditingController relationshipController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUpUser() async {

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      await _firestore.collection("users").doc(uid).set({
        "fullName": fullNameController.text.trim(),
        "email": emailController.text.trim(),
        "age": ageController.text.trim(),
        "gender": genderController.text.trim(),
        "createdAt": Timestamp.now(),
        "emergencyContact": {
          "contactName": contactNameController.text.trim(),
          "contactPhone": contactPhoneController.text.trim(),
         
        }
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardView()),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: double.infinity,
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [

                SizedBox(height: media.height * 0.03),

                Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: TColor.black,
                  ),
                ),

                SizedBox(height: media.height * 0.03),

               

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Personal Information",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),

                const SizedBox(height: 10),

                RoundTextfield(
                  controller: fullNameController,
                  hitText: "Full Name",
                  icon: "assets/img/user.png",
                ),

                const SizedBox(height: 12),

                RoundTextfield(
                  controller: emailController,
                  hitText: "Email",
                  icon: "assets/img/mail.png",
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 12),

                RoundTextfield(
                  controller: passwordController,
                  hitText: "Password",
                  icon: "assets/img/lock.png",
                  obscureText: true,
                ),

                const SizedBox(height: 12),

                RoundTextfield(
                  controller: confirmPasswordController,
                  hitText: "Confirm Password",
                  icon: "assets/img/lock.png",
                  obscureText: true,
                ),

                const SizedBox(height: 12),

                RoundTextfield(
                  controller: ageController,
                  hitText: "Age / Date of Birth",
                  icon: "assets/img/calendar.png",
                ),

                const SizedBox(height: 12),

                RoundTextfield(
                  controller: genderController,
                  hitText: "Gender (Optional)",
                  icon: "assets/img/gender.png",
                ),

                SizedBox(height: media.height * 0.03),

              

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Emergency Contact",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),

                const SizedBox(height: 10),

                RoundTextfield(
                  controller: contactNameController,
                  hitText: "Contact Name",
                  icon: "assets/img/user.png",
                ),

                const SizedBox(height: 12),

                RoundTextfield(
                  controller: contactPhoneController,
                  hitText: "Contact Phone",
                  icon: "assets/img/phone.png",
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 12),

                

                SizedBox(height: media.height * 0.04),

                RoundButton(
                  title: "Sign Up",
                onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      );
                    },
                  ),


                SizedBox(height: media.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
