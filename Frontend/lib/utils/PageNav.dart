  import 'package:flutter/material.dart';

  class PageNav extends PageRouteBuilder{
    final Widget child;
    PageNav({required this.child}):super(
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, anim, secAnim) => child,
      transitionsBuilder: (context, anim, secAnim, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset(0.0, 0.0);

        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offAnim = anim.drive(tween);

        return SlideTransition(position: offAnim, child: child,);
      }
    );


  }