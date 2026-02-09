import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/cart_page.dart';
import 'package:frontend/pages/order_history_page.dart'; // Import your history page
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/utils/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';// Import your login page

class BreakBiteDrawer extends StatelessWidget {
  final String uname;

  const BreakBiteDrawer({super.key, required this.uname});

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.read<OrderProvider>();
    return Drawer(
      backgroundColor: Colors.black, // Dark grey background
      child: Column(
        children: [
          // 1. The Header (Profile Area)
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.black, // Header is pure black
            ),
            accountName: Text(
              uname,
              style: const TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),
            ),
            accountEmail: Text(
              FirebaseAuth.instance.currentUser?.email ?? "student@college.edu",
              style: const TextStyle(color: Colors.white70),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Text(
                uname.isNotEmpty ? uname[0].toUpperCase() : "U",
                style: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // 2. Navigation Items
          _buildDrawerItem(
            context,
            icon: Icons.fastfood,
            title: "Menu",
            onTap: () => Navigator.pop(context), // Close drawer (already on dashboard)
          ),

          _buildDrawerItem(
            context,
            icon: Icons.shopping_cart,
            title: "My Cart",
            onTap: () {
              Navigator.pop(context); // Close drawer first
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                    value: orderProvider,
                    child: CartPage(),
                  ),
                ),
              );
            },
          ),

          _buildDrawerItem(
            context,
            icon: Icons.history,
            title: "Order History",
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                    value: orderProvider,
                    child: OrderHistoryPage(),
                  ),
                ),
              );
            },
          ),

          const Spacer(), // Pushes Logout to the bottom
          const Divider(color: Colors.white24),

          // 3. Logout Button
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            title: "Log Out",
            iconColor: Colors.redAccent,
            textColor: Colors.redAccent,
            onTap: () async {
              final user = FirebaseAuth.instance.currentUser;

              if (user != null) {
                try {
                  final token = await user.getIdToken();
                  await patch(
                    Uri.parse("http://192.168.1.4:5000/users/clear-fcm"),
                    headers: {
                      "Content-Type": "application/json",
                      "Authorization": "Bearer $token"
                    },
                  );
                  print("FCM Token cleared from database");
                } catch (e) {
                  print("Failed to clear token on backend: $e");
                }
              }
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                // Navigate back to Login and remove all previous routes
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false,
                );
              }
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = Colors.yellow,
    Color textColor = Colors.white,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor, fontSize: 16)),
      onTap: onTap,
    );
  }
}