import 'package:flutter/material.dart';
import 'package:lpi_app/screens/activity.dart';
import 'package:lpi_app/screens/login_screen.dart';
import 'package:lpi_app/screens/Scan/scanbody.dart';
import 'package:lpi_app/screens/signup_screen.dart';
import 'package:lpi_app/screens/TabView/body.dart';
import 'package:lpi_app/screens/userReg_screen.dart';
import 'package:lpi_app/screens/welcome_screen.dart';
import 'package:lpi_app/constants.dart';
import 'package:lpi_app/screens/dashboard_screen.dart';

import 'Screens/TabView/listwithtab.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LPI APP',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        DashboardScreen.id: (context) => DashboardScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ScanScreen.id: (context) => ScanScreen(),
        // ListViewScreen.id: (context) => ListViewScreen(),
        TabViewScreen.id: (context) => TabViewScreen(),
        ListWithTabScreen.id: (context) => ListWithTabScreen(),
        ActivityScreen.id: (context) => ActivityScreen()
      },
    );
  }
}
