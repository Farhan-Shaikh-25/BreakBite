import 'package:flutter/material.dart';
import 'package:frontend/admin_utils/admin_order.dart';

class LivePage extends StatefulWidget{
  final List<AdminOrder> liveOrders;

  const LivePage({super.key, required this.liveOrders});

  @override
  State<LivePage> createState() => LivePageState();
}

class LivePageState extends State<LivePage>{

  @override
  Widget build(BuildContext context) {

  }
}