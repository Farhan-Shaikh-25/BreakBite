import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';

// 1. Background Message Handler (Must be OUTSIDE any class)


class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  // 2. Initialize Everything
  Future<void> initNotifications() async {
    // A. Request Permissions (For Android 13+ and iOS)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    }

    // B. Get the Device Token (You need this for your Backend!)
    final fcmToken = await _firebaseMessaging.getToken();
    await sendTokenToBackend(fcmToken!);

    // C. Initialize Local Notifications (For Foresground Popups)
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher'); // Ensure app icon exists

    const InitializationSettings initSettings =
    InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(settings: initSettings);

    // D. Listen for Foreground Messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _showLocalNotification(message);
      }
    });
  }

  // 3. Helper to show the popup when app is open
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'breakbite_channel_id', // Channel ID
      'BreakBite Notifications', // Channel Name
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      id: 0,// Notification ID
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: platformDetails,
    );
  }

  Future<void> sendTokenToBackend(String token) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final tok = await user.getIdToken();

    try {
      final response = await patch(
        Uri.parse("https://breakbite.onrender.com/user/update-fcm"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $tok"
        },
        body: jsonEncode({
          "fcmToken": token,
        }),
      );

      if (response.statusCode == 200) {
        print("Backend: FCM Token stored successfully.");
      }
    } catch (e) {
      print("Backend Error: Could not save FCM token: $e");
    }
  }
}