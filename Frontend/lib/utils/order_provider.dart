import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class OrderProvider extends ChangeNotifier{
  final List<Item> _orderItems = [];

  List<Item> get orderItems => _orderItems;

  int getItemQuantity(String itemId) {
    int index = _orderItems.indexWhere((it) => it.itemId == itemId);
    return index != -1 ? _orderItems[index].quantity : 0;
  }

  void addToCart(Item item, BuildContext context){
    int index = _orderItems.indexWhere((it) => it.itemId == item.itemId);
    if (index != -1) {
      // 2. Check Quantity Limit (Max 3)
      if (_orderItems[index].quantity < 3) {
        _orderItems[index].quantity++;
      } else {
        showToast("Maximum 3 of the same item allowed!", context);
        return;
      }
    } else {
      // 3. Check Total Unique Items Limit (Max 5)
      if (_orderItems.length < 5) {
        _orderItems.add(item..quantity = 1);
      } else {
        showToast("You can only order up to 5 different items!", context);
        return;
      }
    }
    notifyListeners();
  }

  void decrementQuantity(Item item) {
    int index = _orderItems.indexWhere((it) => it.itemId == item.itemId);
    if (index != -1) {
      if (_orderItems[index].quantity > 1) {
        _orderItems[index].quantity -= 1;
      } else {
        _orderItems.removeAt(index); // Remove item if it hits 0
      }
      notifyListeners();
    }
  }

  int getTotal(){
    return _orderItems.fold(0, (total, item) => total + (item.itemPrice * item.quantity));
  }

  Future<void> placeOrder() async{
    final user = FirebaseAuth.instance.currentUser;
    final String? token = await user?.getIdToken();
    await post(
        Uri.parse("http://192.168.1.4:5000/order/add"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          "orderItems": _orderItems.map((item) => item.toJson()).toList()
        })
    );
    _orderItems.clear();
    notifyListeners();
  }

  // Add these variables inside OrderProvider
  List<Order> _myOrders = [];
  List<Order> get myOrders => _myOrders;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchMyOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = FirebaseAuth.instance.currentUser;
      final token = await user?.getIdToken();

      final response = await get(
        Uri.parse("http://192.168.1.4:5000/order/user"), // Verify this route matches your backend!
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['message'];
        _myOrders = data.map((json) => Order.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error fetching orders: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void showToast(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontFamily: 'Poppins', color: Colors.black)),
        backgroundColor: Colors.yellow,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class Order {
  final String id;
  final int totalAmount;
  final String status;
  final String orderDate;
  final List<dynamic> orderItems; // Keeping it dynamic for simplicity

  Order({
    required this.id,
    required this.totalAmount,
    required this.status,
    required this.orderDate,
    required this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'], // MongoDB ID
      totalAmount: int.parse(json['totalAmount'].toString()),
      status: json['status'] ?? 'Processing',
      orderDate: json['createdAt'].toString().replaceFirst('T', ' ').substring(0,16),
      orderItems: json['orderItems'] ?? [],
    );
  }
}

class Item{
  final String itemId, itemName, category;
  final int itemPrice;
  int quantity = 0;
  Item({required this.itemId, required this.itemName, required this.itemPrice, required this.category});

  factory Item.fromJson(Map<String,dynamic> json){
    return Item(
      itemId: json['_id'],
      itemName: json['itemName'],
      itemPrice: json['itemPrice'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'itemPrice': itemPrice,
      'quantity': quantity,
    };
  }
}