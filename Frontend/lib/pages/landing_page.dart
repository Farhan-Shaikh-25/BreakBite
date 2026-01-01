import "package:flutter/material.dart";
import "../utils/PageNav.dart";
import "../widgets/breakbite_button.dart";
import "landing_page2.dart";

class LandingPage extends StatelessWidget{
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Canteen Ordering App",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.yellowAccent),
            ),
            SizedBox(height: 10,),
            Text(
              "no need to stand in queues!",
              style: Theme.of(context).textTheme.labelLarge
            ),
            SizedBox(height: 10,),
            BreakBiteButton(child: "Get Started", onPressed: () => Navigator.of(context).pushReplacement(PageNav(child:LandingPage2())))
          ],
        )
      ),
    );
  }
}