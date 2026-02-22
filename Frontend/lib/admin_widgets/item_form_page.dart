import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../widgets/breakbite_textbox.dart';

class ItemFormPage extends StatelessWidget{
  ItemFormPage({super.key});

  final TextEditingController itemName = TextEditingController();
  final TextEditingController itemPrice = TextEditingController();
  final TextEditingController category = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Center(
      child: SingleChildScrollView( // Added scroll for small screens
        child: Padding(
          // 2. Responsive Padding: Use 10% of screen or a max width
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: screenWidth > 600 ? 400 : screenWidth * 0.9,
            child: Column(
              children: [
                // --- TOP BUN ---
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: const BoxDecoration(
                    color: Color(0xFFD99058), // Toasted Bun Color
                    borderRadius: BorderRadius.vertical(top: Radius.circular(80)),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
                  ),
                  child: Text(
                    "Add Item",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 20,
                  color: Colors.yellow,
                ),
                // --- THE "FILLINGS" (TextFields) ---
                Container( //
                  color: Colors.brown,// Cheese yellow background!,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      BreakBiteTextBox(hint: "Item Name", icon: Icons.food_bank, cont: itemName,),
                      const SizedBox(height: 10),
                      BreakBiteTextBox(hint: "Item Price", icon: Icons.money, cont: itemPrice,),
                      const SizedBox(height: 10,),
                      DropdownButtonFormField<String>(
                        hint: Text("Select Category", style: TextTheme.of(context).bodyMedium?.copyWith(color: Colors.brown)),
                        dropdownColor: Colors.grey[300], // Background of the actual list
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.brown),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.category, color: Colors.brown),
                          filled: true,
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextTheme.of(context).bodyMedium?.copyWith(color: Colors.brown),
                        items: ["Beverages", "Snacks", "Thali", "South Indian"]
                            .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        )).toList(),
                        onChanged: (value) {
                          category.text = value!; // Update your controller manually
                        },
                      )
                    ],
                  ),
                ),
                // --- BOTTOM BUN ---
                Material(
                  color: const Color(0xFFA66D42), // Move color here
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                  clipBehavior: Clip.antiAlias, // <--- This is the cookie cutter!
                  child: InkWell(
                    onTap: () async{
                      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
                      final msg = await post(
                          Uri.parse("https://breakbite.onrender.com/item/add"),
                          headers: {
                            "Content-Type": "application/json",
                            "Authorization": "Bearer $token"
                          },
                          body: jsonEncode({
                            "itemName" : itemName.text,
                            "itemPrice" : itemPrice.text,
                            "category" : category.text
                          })
                      );
                      print(jsonDecode(msg.body)['message']);
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: const Text("Add Item"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}