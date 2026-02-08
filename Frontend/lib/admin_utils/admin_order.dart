import 'package:flutter/material.dart';

class AdminOrder{
  final String id, uid, orderDate;
  final List orderItems;
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
      orderDate: json['createdAt'].toString().replaceFirst('T', ' ').substring(0,16),
      totalAmount: int.parse(json['totalAmount'].toString()),
      status: json['status'],
    );
  }
}