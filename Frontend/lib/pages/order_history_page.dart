import 'package:flutter/material.dart';
import 'package:frontend/widgets/breakbite_spinner.dart';
import 'package:provider/provider.dart';
import '../utils/order_provider.dart';
import 'digital_receipt_page.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().fetchMyOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();
    final orders = orderProvider.myOrders;
    final isLoading = orderProvider.isLoading;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders", style: textTheme.titleLarge),
      ),
      body: isLoading
          ? const Center(child: BreakBiteSpinner())
          : orders.isEmpty
          ? _buildEmptyState(context, textTheme)
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return _buildOrderCard(context, orders[index], textTheme);
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, TextTheme textTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fastfood_outlined, size: 80, color: Colors.grey[800]),
          const SizedBox(height: 20),
          Text("No orders yet!", style: textTheme.headlineSmall),
          const SizedBox(height: 10),
          Text(
            "You haven't ordered any food yet.\nHungry?",
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.black,
            ),
            child: Text("Order Now", style: textTheme.labelLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Order order, TextTheme textTheme) {
    Color statusColor;
    switch (order.status) {
      case 'Completed': statusColor = Colors.green; break;
      case 'Processing': statusColor = Colors.orange; break;
      case 'Preparing': statusColor = Colors.blue; break;
      case 'Collected': statusColor = Colors.grey; break;
      case 'Cancelled': statusColor = Colors.red; break;
      default: statusColor = Colors.blue;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order #${order.id.substring(order.id.length - 4)}",
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              _buildStatusChip(order.status, statusColor, textTheme),
            ],
          ),
          const Divider(color: Colors.white24, height: 24),
          Text(
            "${order.orderItems.length} Items",
            style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.orderDate, style: textTheme.labelSmall?.copyWith(color: Colors.grey)),
              Text(
                "Total: ₹${order.totalAmount}",
                style: textTheme.titleMedium?.copyWith(color: Colors.yellow, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (order.status == 'Completed')
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DigitalReceiptPage(
                        orderId: order.id,
                        items: order.orderItems,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.qr_code_scanner, color: Colors.black),
                label: const Text(
                  "SHOW PICKUP RECEIPT",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow, // Matches the receipt theme
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status, Color color, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Text(
        status,
        style: textTheme.labelSmall?.copyWith(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}