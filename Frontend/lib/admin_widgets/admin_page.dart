import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/admin_utils/admin_order.dart';
import 'package:frontend/pages/item_form_page.dart';
import 'package:frontend/widgets/breakbite_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'admin_history_page.dart';
import '../widgets/breakbite_textbox.dart';
import 'admin_live_page.dart';
import 'admin_order_details.dart';
import 'package:http/http.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;
  late List<AdminOrder> orders;

  @override
  void initState() async {
    super.initState();
    final msg = await get(
      Uri.parse("http://localhost:5000/order/"),
      headers: {
        'Content-Type' : 'application/json'
      }
    );
    final orderMap = jsonDecode(msg.body);
    orders = orderMap.map((order) => AdminOrder.fromJson(order)).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Filter lists based on status
    final List<AdminOrder> liveOrders = orders.where((o) => o.status != 'Collected').toList();
    final List<AdminOrder> historyOrders = orders.where((o) => o.status == 'Collected').toList();

    final screens = [
      LivePage(liveOrders: liveOrders),
      HistoryPage(historyOrders: historyOrders),
      ItemFormPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: BreakBiteAppBar(),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Live Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Add Item"),
        ],
      ),
    );
  }

  // --- TAB 1: LIVE DASHBOARD ---
  Widget _buildLiveDashboard(List<AdminOrder> orders) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Stats Row
          Row(
            children: [
              _buildStatCard("Pending", orders.where((o) => o.status == 'Pending').length.toString(), Colors.orange),
              const SizedBox(width: 10),
              _buildStatCard("Cooking", orders.where((o) => o.status == 'Cooking').length.toString(), Colors.blue),
              const SizedBox(width: 10),
              _buildStatCard("Ready", orders.where((o) => o.status == 'Ready').length.toString(), Colors.green),
            ],
          ),
          const SizedBox(height: 20),
          const Text("Active Orders", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 10),

          // 2. Orders List
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return _buildOrderCard(orders[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER WIDGETS ---
  Widget _buildStatCard(String title, String count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Column(
          children: [
            Text(count, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            Text(title, style: TextStyle(color: color.withOpacity(0.8), fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(AdminOrder order) {
    Color statusColor = Colors.grey;
    if (order.status == 'Pending') statusColor = Colors.orange;
    if (order.status == 'Cooking') statusColor = Colors.blue;
    if (order.status == 'Ready') statusColor = Colors.green;

    return GestureDetector(
      onTap: () async {
        // Navigate to details and wait for result (updated status)
        final newStatus = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminOrderDetailsPage(order: order)),
        );
        if (newStatus != null) {
          setState(() {
            order.status = newStatus;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(15),
          border: Border(left: BorderSide(color: statusColor, width: 5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.id, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: statusColor.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                  child: Text(order.status.toUpperCase(), style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 10)),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(order.userName, style: const TextStyle(color: Colors.white70, fontSize: 14)),
            const Divider(color: Colors.white24),
            Text("${order.items.length} Items • ₹${order.total}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}