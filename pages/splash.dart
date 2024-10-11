import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/model/user.dart';
import 'package:flutter_application_2/pages/list-dishes.dart';
import 'package:flutter_application_2/utils/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print("User Details: $user");
      if (user == null) {
        print('User is currently signed out!');
        Timer(const Duration(seconds: 3), () {
          Navigator.of(context).pushReplacementNamed("/login");
        });
      } else {
        print('User is signed in!');
        if (user.uid != null) {
          Util.UID = user.uid;
          Timer(const Duration(seconds: 3), () {
            final docRef =
                FirebaseFirestore.instance.collection("users").doc(Util.UID);
            docRef.get().then(
              (DocumentSnapshot doc) {
                final data = doc.data() as Map<String, dynamic>?;
                if (data != null) {
                  Util.user = AppUser.fromMap(data);
                  Navigator.of(context).pushReplacementNamed("/home");
                } else {
                  print("Document data is null");
                  // Handle null data case appropriately
                }
              },
              onError: (e) => print("Error getting document: $e"),
            );
          });
        } else {
          print("User UID is null");
          // Handle null UID case appropriately
        }
      }
    });

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed("/login");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blue,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Center(
            child: Image.asset(
              'assets/sportsscape.png',
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
