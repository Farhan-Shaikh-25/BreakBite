import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/breakbite_spinner.dart';
import 'package:http/http.dart' as http;
// Import your spinner if you have one, or use CircularProgressIndicator
// import 'package:frontend/widgets/spinner.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  bool isLoading = true;

  // Data variables
  int totalSpent = 0;
  String favouriteItemName = "No orders yet";
  int favouriteItemQuantity = 0;

  @override
  void initState() {
    super.initState();
    fetchUserStats();
  }

  Future<void> fetchUserStats() async {
    setState(() => isLoading = true);

    try {

      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      final response = await http.get(
        Uri.parse("https://breakbite.onrender.com/order/userReport"),
        headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });

      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          totalSpent = data['totalSpent'] ?? 0;

          final favItem = data['favouriteItem'];
          if (favItem != null) {
            favouriteItemName = favItem['itemName'] ?? "Unknown Item";
            favouriteItemQuantity = favItem['totalQuantity'] ?? 0;
          }
        });
      }
    } catch (e) {
      print("Error fetching user stats: $e");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("My Food Stats", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const BreakBiteSpinner()
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Your Canteen Journey",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Total Spent Card
            buildStatCard(
              title: "Total Spent",
              value: "₹$totalSpent",
              subtitle: "Lifetime spending",
              icon: Icons.account_balance_wallet,
              color: Colors.green,
            ),

            const SizedBox(height: 16),

            // Favourite Item Card
            buildStatCard(
              title: "Most Ordered",
              value: favouriteItemName,
              subtitle: favouriteItemQuantity > 0
                  ? "Ordered $favouriteItemQuantity times"
                  : "Go place an order!",
              icon: Icons.favorite,
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to keep the UI code clean and match your admin theme
  Widget buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 32, color: color),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: color.withOpacity(0.8), fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}