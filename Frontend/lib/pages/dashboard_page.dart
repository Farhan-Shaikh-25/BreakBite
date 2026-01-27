import 'package:flutter/material.dart';
import 'package:frontend/utils/order_data.dart';
import 'package:frontend/widgets/breakbite_appbar.dart';
import 'package:provider/provider.dart';

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
      body: SingleChildScrollView(
      child:Padding(
        padding: EdgeInsets.all(15),
        child:Center(
        child: Column(
          children: [
            Row(
              children: [
                Text(widget.uname, style: TextTheme.of(context).headlineSmall,),
                Text(context.watch<OrderData>().orderId.toString(),),
              ],
            ),
            ListView.builder(
                 shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, i) => Container(
                  width: 100,
                  height: 100,
                  color: Colors.brown,
                  child: Text("item $i"),
                )),
            ElevatedButton(
                onPressed: () {print("Logged out");} ,
                child: Text("Log Out"))
          ],
        ),
      ),
      ),
      )
    );
  }
}