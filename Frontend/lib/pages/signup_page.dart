import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

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
                        _buildBurgerField(context, "Full Name", Icons.badge),
                        const SizedBox(height: 12),
                        _buildBurgerField(context, "Email", Icons.email),
                        const SizedBox(height: 12),
                        _buildBurgerField(context, "Phone Number", Icons.phone, keyboard: TextInputType.phone),
                        const SizedBox(height: 12),
                        _buildBurgerField(context, "Password", Icons.lock, obscure: true),
                        const SizedBox(height: 12),
                        _buildBurgerField(context, "Confirm Password", Icons.lock_outline, obscure: true),
                      ],
                    ),
                  ),

                  // --- BOTTOM BUN (The Action Button) ---
                  Material(
                    color: const Color(0xFFA66D42), // Bottom Bun Color
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => print("Account Created!"),
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
                    onPressed: () => Navigator.of(context).pop(),
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

  // Helper method to keep the code clean
  Widget _buildBurgerField(BuildContext context, String hint, IconData icon, {bool obscure = false, TextInputType keyboard = TextInputType.text}) {
    return TextField(
      obscureText: obscure,
      keyboardType: keyboard,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.brown),
        hintText: hint,
        filled: true,
        fillColor: Colors.white70,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}