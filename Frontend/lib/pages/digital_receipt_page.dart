import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:screen_protector/screen_protector.dart';

class DigitalReceiptPage extends StatefulWidget {
  final String orderId;
  final List<dynamic> items;

  const DigitalReceiptPage({super.key, required this.orderId, required this.items});

  @override
  State<DigitalReceiptPage> createState() => _DigitalReceiptPageState();
}

class _DigitalReceiptPageState extends State<DigitalReceiptPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _timeLeft = 120; // 2 Minutes validity
  bool _isCollected = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _enableSecureMode(); // Prevent Screenshots
    _startTimer();

    // The Rotating Burger Animation
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  Future<void> _markAsCollected() async {
    if (_isCollected) return;
    _isCollected = true;

    try {
      final response = await patch(
        Uri.parse("https://breakbite.onrender.com:5000/order/updatecollected"),
        headers: {
          "Content-Type": "application/json"
        },
        body: jsonEncode({"id": widget.orderId})
      );

      if (response.statusCode == 200) {
        print("Order marked as collected successfully.");
      }
    } catch (e) {
      print("Error marking order as collected: $e");
    }
  }

  Future<void> _enableSecureMode() async {
    await ScreenProtector.protectDataLeakageOn(); // Prevent Screenshots
  }

  Future<void> _disableSecureMode() async {
    await ScreenProtector.protectDataLeakageOff(); // Allow Screenshots again
  }
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() => _timeLeft--);
      } else {
        _timer?.cancel();
        Navigator.pop(context); // Auto-close when time is up
      }
    });
  }

  @override
  void dispose() {
    _disableSecureMode();
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Formatting the time (e.g., 01:59)
    String minutes = (_timeLeft ~/ 60).toString().padLeft(2, '0');
    String seconds = (_timeLeft % 60).toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: Colors.yellowAccent[700], // SUPER BRIGHT
      body: SafeArea(
        child: Center(child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. The "Live" Indicator
            const Text(
              "LIVE RECEIPT",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            const SizedBox(height: 40),

            // 2. The Rotating Burger Spinner (Proof of Life)
            RotationTransition(
              turns: _controller,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 4),
                  color: Colors.white,
                ),
                child: const Icon(Icons.lunch_dining, size: 80, color: Colors.black),
              ),
            ),
            const SizedBox(height: 40),

            // 3. Massive Order ID
            const Text("ORDER ID", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(
              "#${widget.orderId.substring(widget.orderId.length - 4)}",
              style: const TextStyle(fontSize: 80, fontWeight: FontWeight.w900, height: 1.0),
            ),

            // 4. Item Summary
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "${widget.items.length} Items • Ready for Pickup",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const Spacer(),

            // 5. Countdown Timer (The "Bomb")
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timer, color: Colors.redAccent),
                  const SizedBox(width: 10),
                  Text(
                    "Valid for $minutes:$seconds",
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'monospace'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Close Button
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close Receipt", style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
      ),
    );
  }
}