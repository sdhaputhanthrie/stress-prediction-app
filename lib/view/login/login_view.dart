import 'package:stress_predition_app/common/colo_extension.dart';
import 'package:stress_predition_app/common_widget/round_button.dart';
import 'package:stress_predition_app/common_widget/round_textfield.dart';
import 'package:flutter/material.dart';
import 'package:stress_predition_app/view/login/dashboard_view.dart';
import 'package:stress_predition_app/view/login/profile_view.dart';
import 'package:stress_predition_app/view/login/signup_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isCheck = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF73D3E7), // light blue
              Color(0X82EDD4), // soft sky
              Color(0xFFA6F5E2),
              Color.from(alpha: 0.892, red: 0.027, green: 0.867, blue: 0.671),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              height: media.height,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SizedBox(height: media.height * 0.05),
                  Text(
                    "Hey there",
                    style: TextStyle(color: TColor.gray, fontSize: 20),
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: media.height * 0.03),
                  Container(
                    width: 200,
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/loginpage.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: media.height * 0.03),
                  const RoundTextfield(
                    hitText: "Email",
                    icon: "assets/img/mail.png",
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: media.height * 0.01),
                  RoundTextfield(
                    hitText: "Password",
                    icon: "assets/img/lock.png",
                    obscureText: true,
                    rightIcon: TextButton(
                      onPressed: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: 15,
                        height: 15,
                        child: Image.asset(
                          "assets/img/show_password.png",
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                          color: TColor.gray,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: media.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Forget your password?",
                        style: TextStyle(
                          color: TColor.gray,
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),
                  RoundButton(
                    title: "Login",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupView(),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: media.height * 0.03),

                  Row(
                    //crossAxisAlignment: CrossAxisAlignment,
                    children: [
                      Expanded(child: Container(height: 1, color: TColor.gray)),

                      Text(
                        "Or",
                        style: TextStyle(color: TColor.black, fontSize: 12),
                      ),

                      Expanded(
                        child: Container(
                          width: double.maxFinite,
                          height: 1,
                          color: TColor.gray,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          try {
                            final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
                            if (googleUser != null) {
                              print('Google user signed in: ${googleUser.email}');
                              // Navigate to dashboard after successful login
                              if (mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DashboardView(),
                                  ),
                                );
                              }
                            }
                          } catch (error) {
                            print('Google Sign In Error: $error');
                          }
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: TColor.white,
                            border: Border.all(
                              width: 1,
                              color: TColor.gray.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Image.asset(
                            "assets/img/google.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),

                      const SizedBox(width: 40),

                      GestureDetector(
                        onTap: () {
                          // Add Facebook Sign In logic here
                          print('Facebook login tapped');
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: TColor.white,
                            border: Border.all(
                              width: 1,
                              color: TColor.gray.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Icon(
                            Icons.facebook_sharp,
                            color: Colors.blue,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: media.height * 0.03),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupView(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        Text(
                          "Don't have accout yet?",
                          style: TextStyle(
                            color: TColor.gray,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        Text(
                          " Register",
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: media.height * 0.07),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
