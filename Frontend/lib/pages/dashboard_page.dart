import 'package:flutter/material.dart';
import 'package:frontend/widgets/breakbite_drawer.dart';
import 'package:frontend/widgets/breakbite_spinner.dart';
import 'package:provider/provider.dart';

import '../utils/menu_provider.dart';
import '../utils/notification_services.dart';
import '../utils/order_provider.dart';
import '../widgets/breakbite_appbar.dart';
import '../widgets/breakbite_food_card.dart';
import 'cart_page.dart';

class DashboardPage extends StatelessWidget {
  final String uname;
  const DashboardPage({super.key, required this.uname});

  @override
  Widget build(BuildContext context) {
    final menuProvider = context.watch<MenuProvider>();
    final orderProvider = context.watch<OrderProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: BreakBiteAppBar(),
      drawer: BreakBiteDrawer(uname: uname),
      body: menuProvider.isLoading
          ? const BreakBiteSpinner()
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text("Welcome, $uname!", style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 20),
          ...menuProvider.menuItems.map((item) => BreakbiteFoodCard(item: item)).toList(),
        ],
      ),
      floatingActionButton: orderProvider.orderItems.isNotEmpty
          ? FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                        value: orderProvider,
                        child:const CartPage()
                    )
              )
          );
        },
        label: Text("View Cart • ₹${orderProvider.getTotal()}"),
        icon: const Icon(Icons.shopping_cart),
        backgroundColor: Colors.yellow,
      ) : null,
    );
  }
}