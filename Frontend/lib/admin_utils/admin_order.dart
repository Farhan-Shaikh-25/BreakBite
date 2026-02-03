import 'package:flutter/material.dart';

class AdminOrder{
  final String uid;
  final List orderItems;
  final DateTime orderDate;
  final int totalAmount;
  final String status;

  const AdminOrder({
   required this.uid,
   required this.orderItems,
   required this.orderDate,
   required this.totalAmount,
   required this.status
  });

  factory AdminOrder.fromJson(Map<String, dynamic> json) {
    return AdminOrder(
      uid: json['uid'],
      orderItems: json['orderItems'],
      orderDate: DateTime.parse(json['orderDate']),
      totalAmount: json['totalAmount'].toDouble(),
      status: json['status'],
    );
  }
}