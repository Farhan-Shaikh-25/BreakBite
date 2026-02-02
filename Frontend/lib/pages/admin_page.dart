import 'package:flutter/material.dart';
import 'package:frontend/pages/item_form_page.dart';
import 'package:frontend/widgets/breakbite_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/breakbite_textbox.dart';
import 'admin_order_details.dart';

// --- MOCK DATA MODEL (Replace with your OrderData provider or MongoDB model later) ---
class AdminOrder {
  final String id;
  final String userName;
  String status; // 'Pending', 'Cooking', 'Ready', 'Collected'
  final double total;
  final List<String> items;
  final String time;

  AdminOrder({
    required this.id,
    required this.userName,
    required this.status,
    required this.total,
    required this.items,
    required this.time,
  });
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;

  // Mock Data List
  final List<AdminOrder> _orders = [
    AdminOrder(id: "#1001", userName: "Rahul K.", status: "Pending", total: 180, items: ["Veg Burger", "Coke"], time: "10:30 AM"),
    AdminOrder(id: "#1002", userName: "Priya S.", status: "Cooking", total: 250, items: ["Chicken Wrap", "Fries", "Pepsi"], time: "10:32 AM"),
    AdminOrder(id: "#1003", userName: "Amit B.", status: "Ready", total: 60, items: ["Coffee"], time: "10:35 AM"),
    AdminOrder(id: "#0998", userName: "Sneha G.", status: "Collected", total: 120, items: ["Cheese Sandwich"], time: "09:45 AM"),
    AdminOrder(id: "#0999", userName: "Vikram R.", status: "Collected", total: 200, items: ["Pasta"], time: "09:50 AM"),
  ];

  @override
  Widget build(BuildContext context) {
    // Filter lists based on status
    final liveOrders = _orders.where((o) => o.status != 'Collected').toList();
    final historyOrders = _orders.where((o) => o.status == 'Collected').toList();

    final screens = [
      _buildLiveDashboard(liveOrders),
      _buildHistoryList(historyOrders),
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

  // --- TAB 2: HISTORY LIST ---
  Widget _buildHistoryList(List<AdminOrder> orders) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          color: Colors.grey[900],
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: const Icon(Icons.check_circle, color: Colors.green),
            title: Text(order.id, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("${order.userName} • ₹${order.total}", style: const TextStyle(color: Colors.white70)),
            trailing: Text(order.time, style: const TextStyle(color: Colors.grey)),
          ),
        );
      },
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