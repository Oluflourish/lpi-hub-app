import 'package:flutter/material.dart';
import 'package:lpi_app/Screens/AllMembers/body.dart';
import 'package:lpi_app/Screens/Login/login_screen.dart';
import 'package:lpi_app/Screens/Scan/genScan.dart';
import 'package:lpi_app/Screens/Scan/scanbody.dart';
import 'package:lpi_app/Screens/Signup/signup_screen.dart';
import 'package:lpi_app/Screens/TabView/body.dart';
import 'package:lpi_app/Screens/UserRegistration/userReg_screen.dart';
import 'package:lpi_app/Screens/Welcome/welcome_screen.dart';
import 'package:lpi_app/constants.dart';
import 'package:lpi_app/Screens/Dashboard/dashboard_screen.dart';

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
      initialRoute: WelcomeScreen.id ,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        DashboardScreen.id: (context) => DashboardScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ScanScreen.id: (context) => ScanScreen(),
        ListViewScreen.id: (context) => ListViewScreen(),
        TabViewScreen.id: (context) => TabViewScreen()
        
      },
    );
  }
}
