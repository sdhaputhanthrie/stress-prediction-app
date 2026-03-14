import 'package:flutter/material.dart';
import 'package:stress_predition_app/common/colo_extension.dart';
import 'package:stress_predition_app/common_widget/round_button.dart';
import 'package:stress_predition_app/common_widget/round_textfield.dart';
import 'package:stress_predition_app/view/login/login_view.dart';
import 'package:stress_predition_app/view/login/signup_view.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
               Color(0xFF73D3E7), // light blue
              Color(0X82EDD4), // soft sky
              Color.from(alpha: 1, red: 0.306, green: 0.965, blue: 0.812),
              Color(0X82EDD4),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Container(
                    width: 300,
                    height: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/loginpage.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      "Relix",
                      style: TextStyle(
                        color: TColor.black,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    
                    ),
                  ),
                  
                   const SizedBox(height: 50),
                  RoundButton(
                    title: "Login",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      );
                    },
                  ),
                    const SizedBox(height: 50),
                  RoundButton(
                    title: "Sign Up",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupView(),
                        ),
                      );
                    },
                  ),
                  

                ],
              ),
          ),
          ),
        ),
      ),
    );
  }
}