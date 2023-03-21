import 'dart:async';

import 'package:e_commerce_app/views/login/login.dart';
import 'package:e_commerce_app/views/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return const HomePage();
                  } else {
                    return const Login();
                  }
                }),
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Lottie.asset('assets/images/83548-online-shopping-black-friday.json'),
    );
  }
}
