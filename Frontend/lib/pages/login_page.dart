import 'package:flutter/material.dart';
import 'package:frontend/pages/signup_page.dart';
import 'package:frontend/utils/PageNav.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
                  Container(
                    height: 20,
                    color: Colors.yellow,
                  ),
                  // --- THE "FILLINGS" (TextFields) ---
                  Container( //
                    color: Colors.brown,// Cheese yellow background!,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            filled: true,
                            fillColor: Colors.white70,
                            contentPadding: EdgeInsets.all(15)
                          ),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color:Colors.black),
                          
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            filled: true,
                            fillColor: Colors.white70,
                            contentPadding: EdgeInsets.all(15)
                          ),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color:Colors.black),
                        ),
                      ],
                    ),
                  ),

                  // --- BOTTOM BUN ---

                  Material(
                    color: const Color(0xFFA66D42), // Move color here
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                    clipBehavior: Clip.antiAlias, // <--- This is the cookie cutter!
                    child: InkWell(
                      onTap: () => print("Sign up tapped!"),
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: const Text("Order Now (Sign In)"),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(PageNav(child: SignupPage())),
                    child: Text(
                        "No account? Sign Up!",
                        style: Theme.of(context).textTheme.labelLarge,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}