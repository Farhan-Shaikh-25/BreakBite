import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:frontend/pages/landing_page.dart";
import "package:frontend/pages/loading_page.dart";
import "package:google_fonts/google_fonts.dart";
import "firebase_options.dart";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme
        ).apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white, // Sets icons and text to white

          // Optional: If you want to force Poppins specifically for AppBars
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      title: "BreakBite",
      home: LoadingPage(child: LandingPage()),
    );
  }
}

