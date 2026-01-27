import "package:flutter/material.dart";
import "package:frontend/pages/login_page.dart";
import "package:frontend/widgets/breakbite_button.dart";
import "../utils/PageNav.dart";

class LandingPage3 extends StatelessWidget{
  const LandingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Notifications",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.yellowAccent, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
              Text(
                  "no need to stand in queues!",
                  style: Theme.of(context).textTheme.labelLarge
              ),
              SizedBox(height: 10,),
              BreakBiteButton(child: "Get Started", onPressed: () => Navigator.of(context).pushReplacement(PageNav(child:LoginPage())))
            ],
          )
      ),

    );
  }
}