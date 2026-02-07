import 'package:flutter/material.dart';
import 'package:frontend/admin_utils/admin_order_provider.dart';
import 'package:provider/provider.dart';
import 'package:frontend/admin_widgets/item_form_page.dart';
import 'package:frontend/widgets/breakbite_appbar.dart';
import 'package:frontend/widgets/breakbite_spinner.dart';
import 'admin_history_page.dart';
import 'admin_live_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;

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
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: BreakBiteAppBar(),
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
        ],
      ),
    );
  }
}