import 'package:flutter/material.dart';
import 'package:frontend/widgets/breakbite_appbar.dart';

class DashboardPage extends StatefulWidget{
  final String uname;
  const DashboardPage({super.key, required this.uname});

  @override
  State<DashboardPage> createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BreakBiteAppBar(),
      body: Center(
        child: Column(
          children: [
            Text(widget.uname, style: TextTheme.of(context).bodyMedium,),
            ElevatedButton(
                onPressed: () {print("Logged out");} ,
                child: Text("Log Out"))
          ],
        ),
      ),
    );
  }
}