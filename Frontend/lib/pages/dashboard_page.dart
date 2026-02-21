import 'package:flutter/material.dart';
import 'package:frontend/widgets/breakbite_drawer.dart';
import 'package:frontend/widgets/breakbite_spinner.dart';
import 'package:provider/provider.dart';

import '../utils/menu_provider.dart';
import '../utils/order_provider.dart';
import '../widgets/breakbite_appbar.dart';
import '../widgets/breakbite_food_card.dart';
import 'cart_page.dart';

class DashboardPage extends StatelessWidget {
  final String uname;
  final Map<String, String> imgMap = {
    "Beverages" : "assets/images/bev.png",
    "Snacks" : "assets/images/sna.png",
    "Thali" : "assets/images/tha.png",
    "South Indian" : "assets/images/sou.png"
  };
  DashboardPage({super.key, required this.uname});

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
          : RefreshIndicator(
        backgroundColor: Colors.black,
        color: Colors.yellow,
        onRefresh: () async {
          await menuProvider.fetchMenu();
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text("Welcome, $uname!", style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 20),
            ...menuProvider.menuItems.map((item) => BreakbiteFoodCard(item: item, imagePath: imgMap[item.category].toString(),)).toList(),
            const Divider(color: Colors.yellow,),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.175,
              child: Center(
                child: Text(
                  "We Only have This Much for Now",
                  style: TextTheme.of(context).bodyLarge?.copyWith(
                      color: Colors.grey
                  ),),
              ),
            )
          ],
        ),
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