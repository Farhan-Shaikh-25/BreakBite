import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'admin_order.dart';

class AdminOrderProvider extends ChangeNotifier {
  List<AdminOrder> _orders = [];
  bool _isLoading = false;

  List<AdminOrder> get orders => _orders;
  bool get isLoading => _isLoading;

  // Filtered Lists
  List<AdminOrder> get liveOrders => _orders.where((o) => o.status != 'Completed').toList();
  List<AdminOrder> get historyOrders => _orders.where((o) => o.status == 'Completed').toList();

  Future<void> fetchOrders() async {
    _isLoading = true;
    notifyListeners(); // Tells the UI to show the spinner

    final msg = await get(Uri.parse("http://localhost:5000/order/"));
    final List<dynamic> data = jsonDecode(msg.body)['message'];

    _orders = data.map((json) => AdminOrder.fromJson(json)).toList();
    _isLoading = false;
    notifyListeners(); // Tells the UI to show the data
  }

  Future<void> updateStatus(String orderId, String newStatus) async {
    int index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      await patch(
          Uri.parse("http://localhost:5000/order/updatestatus"),
          headers: {
            'Content-Type' : 'application/json'
          },
          body: jsonEncode({
            "id": orderId,
            "newStatus": newStatus
          })
      );
      _orders[index].status = newStatus;
      notifyListeners(); // This is the magic! Everyone (Stats, Cards) updates now.
    }

  }
}