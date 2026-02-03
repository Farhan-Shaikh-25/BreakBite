import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'admin_page.dart'; // Import to access AdminOrder model

class AdminOrderDetailsPage extends StatelessWidget {
  final AdminOrder order;

  const AdminOrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
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
                Text(order.time, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            Text("Customer: ${order.userName}", style: const TextStyle(fontSize: 18, color: Colors.white70)),

            const SizedBox(height: 30),

            // Item List
            const Text("Items Ordered:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: order.items.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(order.items[index], style: const TextStyle(color: Colors.white, fontSize: 16)),
                        const Text("x1", style: TextStyle(color: Colors.orange)),
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
                Text("₹${order.total}", style: const TextStyle(color: Colors.greenAccent, fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),

            // --- ACTION BUTTONS (The Control Panel) ---
            if (order.status == 'Pending') ...[
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () => Navigator.pop(context, "Cooking"), // Return new status
                  child: const Text("ACCEPT & COOK", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ] else if (order.status == 'Cooking') ...[
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () => Navigator.pop(context, "Ready"),
                  child: const Text("MARK AS READY", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ] else if (order.status == 'Ready') ...[
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () => Navigator.pop(context, "Collected"),
                  child: const Text("COMPLETE ORDER", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
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