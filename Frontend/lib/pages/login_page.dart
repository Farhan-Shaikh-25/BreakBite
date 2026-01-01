import 'package:flutter/material.dart';

import '../widgets/breakbite_appbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const BreakBiteAppBar(),
      drawer: const Drawer(),
      body: Center(
        child: SingleChildScrollView( // Added scroll for small screens
          child: Padding(
            // 2. Responsive Padding: Use 10% of screen or a max width
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: screenWidth > 600 ? 400 : screenWidth * 0.9,
              child: Column(
                children: [
                  // --- TOP BUN ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD99058), // Toasted Bun Color
                      borderRadius: BorderRadius.vertical(top: Radius.circular(80)),
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
                    ),
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // --- THE "FILLINGS" (TextFields) ---
                  Container(
                    color: const Color(0xFFFFD700), // Cheese yellow background!
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const TextField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // --- BOTTOM BUN ---
                  InkWell(
                    onTap: () => print("Sign up tapped!"),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: const BoxDecoration(
                        color: Color(0xFFA66D42), // Darker bottom bun
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                      ),
                      child: const Text(
                        "Order Now (SignUp)",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
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