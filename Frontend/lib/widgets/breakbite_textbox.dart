import 'package:flutter/material.dart';

class BreakBiteTextBox extends StatelessWidget{
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextInputType keyboard;
  const BreakBiteTextBox({
    super.key,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.keyboard = TextInputType.text,

  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      keyboardType: keyboard,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color:Colors.black),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.brown,),
        hintText: hint,
        filled: true,
        fillColor: Colors.white70,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}