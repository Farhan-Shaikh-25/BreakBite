import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/admin_utils/admin_order_provider.dart';
import 'package:frontend/admin_widgets/admin_page.dart';
import 'package:http/http.dart';
import 'package:frontend/pages/signup_page.dart';
import 'package:frontend/utils/PageNav.dart';
import 'package:frontend/utils/auth_check.dart';
import 'package:frontend/widgets/breakbite_textbox.dart';
import 'package:provider/provider.dart';

import 'dashboard_page.dart';

class LoginPage extends StatelessWidget{
  LoginPage({super.key});
  final TextEditingController uemail = TextEditingController();
  final TextEditingController upass = TextEditingController();

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
                        BreakBiteTextBox(hint: "Email", icon: Icons.email, cont: uemail,),
                        const SizedBox(height: 10),
                        BreakBiteTextBox(hint: "Password", icon: Icons.password, cont: upass,),
                      ],
                    ),
                  ),

                  // --- BOTTOM BUN ---
                  Material(
                    color: const Color(0xFFA66D42), // Move color here
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                    clipBehavior: Clip.antiAlias, // <--- This is the cookie cutter!
                    child: InkWell(
                      onTap: () async{
                        User? user = await AuthCheck.login(uemail.text.trim(), upass.text.trim());
                        if(user!=null) {
                          final String? token = await user.getIdToken();
                          final udata = await get(
                            Uri.parse("http://localhost:5000/user/login/"),
                            headers: {
                              "Content-Type": "application/json",
                              "Authorization": "Bearer $token",
                            }
                          );
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(
                                  "User LoggedIn for ${user.email}"))
                          );
                          final userData = jsonDecode(udata.body);
                          if(userData['userType'] == 'normal') {
                            Navigator.of(context).pushReplacement(PageNav(
                                child: DashboardPage(
                                    uname: userData['message'])));
                          } else{
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (routeContext) => ChangeNotifierProvider<AdminOrderProvider>(
                                  create: (_) => AdminOrderProvider()..fetchOrders(),
                                  // The Builder ensures AdminPage is a child with a clean context
                                  child: AdminPage(),
                                ),
                              ),
                            );
                          }
                        }
                        else {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(
                                  "User doesn't exist!"))
                          );
                        }
                      },
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
                    onPressed: () {
                      Navigator.of(context).push(PageNav(child: SignupPage()));
                      uemail.clear();
                      upass.clear();
                    },
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