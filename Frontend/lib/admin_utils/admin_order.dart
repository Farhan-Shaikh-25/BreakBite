import 'package:flutter/material.dart';

class AdminOrder{
  final String id, uid;
  final List orderItems;
  final DateTime orderDate;
  final int totalAmount;
  String status;

  AdminOrder({
   required this.id,
   required this.uid,
   required this.orderItems,
   required this.orderDate,
   required this.totalAmount,
   required this.status
  });

  factory AdminOrder.fromJson(Map<String, dynamic> json) {
    return AdminOrder(
      id: json['_id'],
      uid: json['userId'],
      orderItems: json['orderItems'],
      orderDate: DateTime.parse(json['orderDate']),
      totalAmount: json['totalAmount'].toDouble(),
      status: json['status'],
    );
  }
}