import "package:flutter/material.dart";
import "package:frontend/pages/landing_page3.dart";
import "package:frontend/utils/PageNav.dart";

import "../widgets/breakbite_button.dart";


class LandingPage2 extends StatelessWidget{
  const LandingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Digital Receipt",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.yellowAccent),
              ),
              SizedBox(height: 10,),
              Text(
                  "no need to stand in queues!",
                  style: Theme.of(context).textTheme.labelLarge
              ),
              SizedBox(height: 10,),
              BreakBiteButton(child: "Get Started", onPressed: () => Navigator.of(context).pushReplacement(PageNav(child:LandingPage3())))
            ],
          )
      ),
    );
  }
}