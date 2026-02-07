import 'package:flutter/material.dart';

class AdminStatCard extends StatelessWidget{
  final String title, count;
  final Color color;
  const AdminStatCard({super.key, required this.title, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Column(
          children: [
            Text(count, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            Text(title, style: TextStyle(color: color.withOpacity(0.8), fontSize: 12)),
          ],
        ),
      ),
    );
  }
}