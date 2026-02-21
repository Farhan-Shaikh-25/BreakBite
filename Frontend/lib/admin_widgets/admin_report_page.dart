import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/breakbite_spinner.dart';
import 'package:http/http.dart';

class AdminReportPage extends StatefulWidget {
  const AdminReportPage({super.key});

  @override
  State<AdminReportPage> createState() => AdminReportPageState();
}

class AdminReportPageState extends State<AdminReportPage> {
  String selectedTimeframe = 'daily'; // Default timeframe
  bool isLoading = true;

  // Data variables
  int totalSales = 0;
  String mostSoldProduct = "N/A";
  String peakHour = "N/A";

  @override
  void initState() {
    super.initState();
    fetchReportData();
  }

  Future<void> fetchReportData() async {
    setState(() => isLoading = true);

    try {
      final response = await get(
        Uri.parse("https://breakbite.onrender.com/order/report/$selectedTimeframe"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        setState(() {
          totalSales = data['totalSales'] ?? 0;
          mostSoldProduct = data['mostSoldProduct'] ?? "N/A";
          peakHour = data['peakHour'] ?? "N/A";
        });
      }
    } catch (e) {
      print("Error fetching report: $e");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Timeframe Toggle Buttons
          Center(
            child: ToggleButtons(
              isSelected: [
                selectedTimeframe == 'daily',
                selectedTimeframe == 'weekly',
                selectedTimeframe == 'monthly',
              ],
              onPressed: (index) {
                setState(() {
                  if (index == 0) selectedTimeframe = 'daily';
                  if (index == 1) selectedTimeframe = 'weekly';
                  if (index == 2) selectedTimeframe = 'monthly';
                });
                fetchReportData(); // Fetch new data when clicked
              },
              color: Colors.white70,
              selectedColor: Colors.black,
              fillColor: Colors.yellow,
              borderRadius: BorderRadius.circular(8),
              borderColor: Colors.yellow,
              selectedBorderColor: Colors.yellow,
              children: const [
                Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Daily")),
                Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Weekly")),
                Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Monthly")),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // 2. Report Data Display
          isLoading
              ? const Expanded(child: BreakBiteSpinner())
              : Expanded(
            child: ListView(
              children: [
                buildReportCard("Total Sales", "₹$totalSales", Icons.currency_rupee, Colors.green),
                const SizedBox(height: 16),
                buildReportCard("Most Sold Product", mostSoldProduct, Icons.fastfood, Colors.orange),
                const SizedBox(height: 16),
                buildReportCard("Peak Hour", peakHour, Icons.access_time, Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to make the stats look good
  Widget buildReportCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}