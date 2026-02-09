import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'order_provider.dart'; // Ensure this points to your Item class

class MenuProvider extends ChangeNotifier {
  List<Item> _menuItems = [];
  bool _isLoading = false;
  List<Item> get menuItems => _menuItems;
  bool get isLoading => _isLoading;

  Future<void> fetchMenu() async {
    _isLoading = true;
    notifyListeners(); // Show spinner in UI

    try {
      // Replace with your machine's IP if testing on a physical device
      final response = await get(
        Uri.parse("https://breakbite.onrender.com:5000/item"),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = jsonDecode(response.body);

        // Assuming your backend returns { "message": [...] }
        final List<dynamic> itemsData = decodedData['message'];

        _menuItems = itemsData.map((json) => Item.fromJson(json)).toList();
      } else {
        debugPrint("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Connection Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); // Hide spinner and show data
    }
  }
}