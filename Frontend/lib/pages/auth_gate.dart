import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/admin_widgets/admin_page.dart';
import 'package:frontend/pages/dashboard_page.dart';
import 'package:frontend/pages/landing_page.dart';
import 'package:frontend/widgets/breakbite_spinner.dart';
import 'package:provider/provider.dart';

import '../admin_utils/admin_order_provider.dart';
import '../utils/menu_provider.dart';
import '../utils/order_provider.dart'; // Your spinner widget

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // 1. Listen to the "Live Wire" of Authentication
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        // 2. Is Firebase still checking the disk? Show Spinner.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: BreakBiteSpinner()),
          );
        }

        // 3. Is there a valid user logged in?
        if (snapshot.hasData) {
          final user = snapshot.data!;
          if(user.email == "admin123@ad.in") {
            return ChangeNotifierProvider<AdminOrderProvider>(
              create: (_) => AdminOrderProvider()..fetchOrders(),
              child: AdminPage(),
            );
          }
          return MultiProvider(
            providers: [
              // Initialize MenuProvider and trigger the fetch immediately
              ChangeNotifierProvider(create: (_) => MenuProvider()..fetchMenu()),
              // Initialize OrderProvider (Cart)
              ChangeNotifierProvider(create: (_) => OrderProvider()),
            ],
            child: DashboardPage(uname: user.displayName ?? "User"),
          );
          }
        // 4. No user found? Show the Landing Page (Login/Signup)
        return const LandingPage();
      },
    );
  }
}