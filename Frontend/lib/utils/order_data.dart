import 'package:flutter/material.dart';

class OrderData extends ChangeNotifier{
  String? orderId;

  OrderData({
    this.orderId
  });

  void updateOrder(String? orderId){
    this.orderId = orderId;
    notifyListeners();
  }
}