import 'package:flutter/material.dart';

class BreakBiteAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const BreakBiteAppBar({super.key, this.title = "BreakBite"});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Row(
        children: [
          Icon(Icons.fastfood_outlined),
          SizedBox(width:10),
          Text(title),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}