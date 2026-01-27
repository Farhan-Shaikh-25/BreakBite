import 'package:flutter/material.dart';
import 'package:frontend/utils/PageNav.dart';
import 'package:frontend/widgets/breakbite_spinner.dart';

class LoadingPage extends StatefulWidget{
  final Widget child;
  const LoadingPage({super.key, required this.child});

  @override
  State<LoadingPage> createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage>{

  @override
  void initState() {
    super.initState();
    delay();
  }

  void delay() async{
    await Future.delayed(Duration(seconds: 5));
    if(mounted) {
      Navigator.of(context).pushReplacement(PageNav(child: widget.child));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BreakBiteSpinner());
  }
}