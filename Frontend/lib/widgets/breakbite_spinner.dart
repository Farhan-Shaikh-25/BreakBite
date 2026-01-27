import 'package:flutter/material.dart';

class BreakBiteSpinner extends StatefulWidget{
  const BreakBiteSpinner({super.key});

  @override
  State<BreakBiteSpinner> createState() => SpinnerState();
}

class SpinnerState extends State<BreakBiteSpinner> with SingleTickerProviderStateMixin{
  late AnimationController cont;

  @override
  void initState() {
    super.initState();
    cont = AnimationController(
        duration: Duration(seconds: 2),
        vsync: this);
    cont.repeat();
  }

  @override
  void dispose() {
    cont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child:RotationTransition(
        alignment: Alignment.center,
        turns: cont,
        child: const SizedBox( // 2. Force the spinning area to be small
          width: 100,
          height: 100,
          child: Icon(
            Icons.fastfood,
            color: Colors.yellowAccent,
            size: 40// The icon sits inside the 100x100 box
          ),
        ),
    ));
  }
}