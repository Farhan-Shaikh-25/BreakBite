import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

class AuthCheck{
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User?> signUp(String uemail, String upass, String fname) async{
    try{
      UserCredential userCred = await auth.createUserWithEmailAndPassword(email: uemail, password: upass);
      fname = fname.split(" ")[0];
      await userCred.user?.updateDisplayName(fname);
      return userCred.user;
    } catch(e){ print("Signup Error ${e.toString()}"); }
  }

  static Future<User?> login(String uemail, String upass) async{
    try{
      UserCredential userCred = await auth.signInWithEmailAndPassword(email: uemail, password: upass);
      return userCred.user;
    } catch(e){ print("Signup Error ${e.toString()}"); }
  }
}