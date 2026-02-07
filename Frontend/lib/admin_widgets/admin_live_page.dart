import 'package:flutter/material.dart';
import 'package:frontend/admin_utils/admin_order_provider.dart';
import 'package:frontend/admin_widgets/admin_order_card.dart';
import 'package:frontend/admin_widgets/admin_stat_card.dart';
import 'package:provider/provider.dart';

class LivePage extends StatelessWidget{
  const LivePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final liveOrders = context.watch<AdminOrderProvider>().liveOrders;
    final completedOrdersCount = context.watch<AdminOrderProvider>().historyOrders.length;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Stats Row
          Row(
            children: [
              AdminStatCard(
                  title: "Processing",
                  count: liveOrders.where((o) => o.status == 'Processing').length.toString(),
                  color: Colors.orange),
              const SizedBox(width: 10),
              AdminStatCard(
                  title: "Preparing",
                  count: liveOrders.where((o) => o.status == 'Preparing').length.toString(),
                  color: Colors.blue),
              const SizedBox(width: 10),
              AdminStatCard(
                  title: "Completed",
                  count: completedOrdersCount.toString(),
                  color: Colors.green),
            ],
          ),
          const SizedBox(height: 20),
          const Text("Active Orders", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 10),

          // 2. Orders List
          Expanded(
            child: ListView.builder(
              itemCount: liveOrders.length,
              itemBuilder: (context, index) {
                return AdminOrderCard(order:liveOrders[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}