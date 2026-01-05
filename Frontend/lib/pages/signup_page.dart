import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/auth_check.dart';
import 'package:frontend/widgets/breakbite_textbox.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController uname = TextEditingController();
  final TextEditingController uemail = TextEditingController();
  final TextEditingController upass= TextEditingController();
  final TextEditingController usap = TextEditingController();
  final TextEditingController unum = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: SizedBox(
              width: screenWidth > 600 ? 450 : screenWidth * 0.9,
              child: Column(
                children: [
                  // --- TOP BUN (The Header) ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD99058), // Toasted Bun Color
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

                  // --- CHEESE LAYER (Separator) ---
                  Container(height: 15, color: Colors.yellowAccent),

                  // --- MAIN FILLINGS (The Meat/Fields) ---
                  Container(
                    color: Colors.brown, // Matches your Login Filling
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        BreakBiteTextBox(hint: "Full Name", icon: Icons.person, cont: uname,),
                        const SizedBox(height: 10),
                        BreakBiteTextBox(hint: "Email", icon: Icons.email, keyboard: TextInputType.emailAddress, cont: uemail,),
                        const SizedBox(height: 10),
                        BreakBiteTextBox(hint: "Password", icon: Icons.password, obscure: true, cont: upass,),
                        const SizedBox(height: 10),
                        BreakBiteTextBox(hint: "Phone Number", icon: Icons.phone, keyboard: TextInputType.phone, cont: unum,),
                        const SizedBox(height: 10),
                        BreakBiteTextBox(hint: "SAP id", icon: Icons.badge, keyboard: TextInputType.number, cont: usap,),
                      ],
                    ),
                  ),

                  // --- BOTTOM BUN (The Action Button) ---
                  Material(
                    color: const Color(0xFFA66D42), // Bottom Bun Color
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () async{
                        User? user = await AuthCheck.signUp(uemail.text.trim(), upass.text.trim());
                        if(!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("User Created for ${user?.email}")),
                        );
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

                  // --- FOOTER (Back to Login) ---
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      uname.clear();
                      upass.clear();
                      uemail.clear();
                      unum.clear();
                      usap.clear();
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