import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:frontend/utils/auth_check.dart';
import 'package:frontend/widgets/breakbite_textbox.dart';

// 1. Change to StatefulWidget
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // 2. Define controllers here
  late final TextEditingController uname;
  late final TextEditingController uemail;
  late final TextEditingController upass;
  late final TextEditingController usap;
  late final TextEditingController unum;

  @override
  void initState() {
    super.initState();
    // 3. Initialize them when the widget starts
    uname = TextEditingController();
    uemail = TextEditingController();
    upass = TextEditingController();
    usap = TextEditingController();
    unum = TextEditingController();
  }

  @override
  void dispose() {
    // 4. Dispose them AUTOMATICALLY when the screen closes
    uname.dispose();
    uemail.dispose();
    upass.dispose();
    usap.dispose();
    unum.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: SizedBox(
              width: screenWidth > 600 ? 400 : screenWidth * 0.9,
              child: Column(
                children: [
                  // --- TOP BUN ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD99058),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(80)),
                      boxShadow: [
                        BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 4))
                      ],
                    ),
                    child: Text(
                      "Register",
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // --- CHEESE LAYER ---
                  Container(height: 15, color: Colors.yellowAccent),

                  // --- MAIN FILLINGS ---
                  Container(
                    color: Colors.brown,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        BreakBiteTextBox(hint: "Full Name", icon: Icons.person, cont: uname),
                        const SizedBox(height: 10),
                        BreakBiteTextBox(hint: "Email", icon: Icons.email, keyboard: TextInputType.emailAddress, cont: uemail),
                        const SizedBox(height: 10),
                        BreakBiteTextBox(hint: "Password", icon: Icons.password, obscure: true, cont: upass),
                        const SizedBox(height: 10),
                        BreakBiteTextBox(hint: "Phone Number", icon: Icons.phone, keyboard: TextInputType.phone, cont: unum),
                        const SizedBox(height: 10),
                        BreakBiteTextBox(hint: "SAP id", icon: Icons.badge, keyboard: TextInputType.number, cont: usap),
                      ],
                    ),
                  ),

                  // --- BOTTOM BUN ---
                  Material(
                    color: const Color(0xFFA66D42),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () async {
                        try {
                          User? user = await AuthCheck.signUp(uemail.text.trim(), upass.text.trim());

                          if (user != null) {
                            String? token = await user.getIdToken();

                            // NOTE: Use 10.0.2.2 if on Android Emulator
                            final response = await post(
                                Uri.parse("http://localhost:5000/user/signup"),
                                headers: {
                                  "Content-Type": "application/json",
                                  "Authorization": "Bearer $token"
                                },
                                body: jsonEncode({
                                  "uname": uname.text,
                                  "uemail": uemail.text,
                                  "upass": upass.text,
                                  "upnum": unum.text,
                                  "usap": usap.text,
                                })
                            );

                            if (!context.mounted) return;

                            if (response.statusCode == 200 || response.statusCode == 201) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("User Created: ${user.email}")),
                              );
                              Navigator.of(context).pop();
                              // No need to manually clear/dispose here.
                              // The dispose() method above handles it.
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Backend Error: ${response.body}")),
                              );
                            }
                          }
                        } catch (e) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: $e")),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // --- FOOTER ---
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Already have an account? Login",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
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