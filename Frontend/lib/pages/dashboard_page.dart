import 'package:flutter/material.dart';
import 'package:frontend/widgets/breakbite_appbar.dart';
import 'package:frontend/widgets/food_card.dart';

class DashboardPage extends StatefulWidget {
  final String uname;
  const DashboardPage({super.key, required this.uname});

  @override
  State<DashboardPage> createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BreakBiteAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [Text(
          "Breakfast",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),


          FoodCard(
            title: "Classic Burger",
            description: "Juicy beef patty with fresh vegetables",
            price: "120",
            imagePath: "assets/images/burger.png",
            onAdd: () {
              print("Burger added");
            },
          ),

          FoodCard(
            title: "Veg Sandwich",
            description: "Fresh veggies with toasted bread",
            price: "60",
            imagePath: "assets/images/sandwich.png",
            onAdd: () {
              print("Sandwich added");
            },
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              print("Logged out");
            },
            child: const Text("Log Out"),
          ),
        ],
      ),
    );
  }
}
