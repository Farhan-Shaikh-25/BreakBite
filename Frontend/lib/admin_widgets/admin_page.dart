import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/admin_utils/admin_order_provider.dart';
import 'package:provider/provider.dart';
import 'package:frontend/admin_widgets/item_form_page.dart';
import 'package:frontend/widgets/breakbite_appbar.dart';
import 'package:frontend/widgets/breakbite_spinner.dart';
import '../pages/login_page.dart';
import 'admin_history_page.dart';
import 'admin_live_page.dart';
import 'admin_report_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;

  void _handleLogout(BuildContext context) async {
    // Show a confirmation dialog (Optional but professional)
    bool? confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text("Logout", style: TextStyle(color: Colors.white)),
        content: const Text("Are you sure you want to sign out?", style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Logout", style: TextStyle(color: Colors.redAccent))
          ),
        ],
      ),
    );

    if (confirm == true) {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        // Remove all previous routes and go to Login
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false,
        );
      }
    }
  }
  // initState is now empty or removed because fetchOrders happens in the Provider creation!

  @override
  Widget build(BuildContext context) {
    // Watch the provider for the loading status
    final orderProvider = context.watch<AdminOrderProvider>();

    if (orderProvider.isLoading) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: BreakBiteAppBar(),
        body: const Center(child: BreakBiteSpinner()),
      );
    }

    final screens = [
      const LivePage(),
      const HistoryPage(),
      ItemFormPage(),
      AdminReportPage()
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Admin Panel", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () => _handleLogout(context),
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            tooltip: "Logout",
          ),
        ],
      ),
      body: screens[_selectedIndex],
      floatingActionButton: FloatingActionButton(
          onPressed: () => orderProvider.fetchOrders(),
          backgroundColor: Colors.yellowAccent,
          tooltip: "refresh",
          child: Icon(Icons.refresh_outlined),

      ),
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
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Report"),
        ],
      ),
    );
  }
}