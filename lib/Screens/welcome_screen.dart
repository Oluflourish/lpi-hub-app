import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lpi_app/screens/dashboard_screen.dart';
import 'package:lpi_app/screens/login_screen.dart';
import 'package:lpi_app/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoggedIn;

  checkUserLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLoggedIn = (pref.getBool('isLoggedIn') ?? false);
  }

  @override
  void initState() {
    super.initState();

    checkUserLoggedIn();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) {
            if (isLoggedIn) {
              return DashboardScreen();
            } else {
              return LoginScreen();
            }
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/lpi_logo.png",
              // "assets/images/lpi_hub_white.png",
              height: 180,
            ),
            SizedBox(height: 36),
            Text(
              "INNOVATION",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "HUB",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 56.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
