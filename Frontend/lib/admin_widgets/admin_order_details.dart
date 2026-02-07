import 'package:flutter/material.dart';
import 'package:frontend/admin_utils/admin_order_provider.dart';
import 'package:frontend/admin_widgets/admin_live_page.dart';
import 'package:provider/provider.dart';
import '../admin_utils/admin_order.dart';

class AdminOrderDetailsPage extends StatelessWidget {
  final AdminOrder order;

  const AdminOrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.read<AdminOrderProvider>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("Order Details", style: TextTheme.of(context).headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.id, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange)),
                Text(order.orderDate.toString(), style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 30),
            // Item List
            const Text("Items Ordered:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: order.orderItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(order.orderItems[index]['itemName'], style: const TextStyle(color: Colors.white, fontSize: 16)),
                        Text(
                            "${order.orderItems[index]['quantity'].toString()} x ₹${order.orderItems[index]['itemPrice'].toString()}"
                            , style: TextStyle(color: Colors.orange)),
                        Text("₹${(order.orderItems[index]['quantity'] * order.orderItems[index]['itemPrice']).toString()}"
                            , style: TextStyle(color: Colors.orange)),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Total Section
            const Divider(color: Colors.white24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Amount", style: TextStyle(color: Colors.white70, fontSize: 16)),
                Text("₹${order.totalAmount}", style: const TextStyle(color: Colors.greenAccent, fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),

            // --- ACTION BUTTONS (The Control Panel) ---
            if (order.status == 'Processing') ...[
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    orderProvider.updateStatus(order.id, "Preparing");
                    // order.status = "Preparing";
                    // Navigator.of(context).pushReplacement(
                    //     MaterialPageRoute(builder: (context) => LivePage())
                    // );
                    Navigator.of(context).pop();
                  }, // Return new status
                  child: const Text("ACCEPT & COOK", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ] else if (order.status == 'Preparing') ...[
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    orderProvider.updateStatus(order.id, "Completed");
                    // order.status = "Completed";
                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(builder: (context) => LivePage())
                    // );
                    Navigator.of(context).pop();

                  },
                  child: const Text("MARK AS READY", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}