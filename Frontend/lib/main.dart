import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:frontend/pages/auth_gate.dart";
import "package:frontend/utils/notification_services.dart";
import "package:frontend/utils/order_data.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";
import "firebase_options.dart";

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final notificationService = NotificationService();
  notificationService.initNotifications();
  runApp(
      ChangeNotifierProvider(
          create: (context) => OrderData(orderId: "1236"),
          child: MyApp(),
      )
  );
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
      home: const AuthGate()
    );
  }
}

