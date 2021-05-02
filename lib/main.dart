import 'package:flutter/material.dart';
import 'package:lpi_app/screens/activity.dart';
import 'package:lpi_app/screens/login_screen.dart';
import 'package:lpi_app/screens/Scan/scanbody.dart';
import 'package:lpi_app/screens/members/member_tabs.dart';
import 'package:lpi_app/screens/signup_screen.dart';
import 'package:lpi_app/screens/userReg_screen.dart';
import 'package:lpi_app/screens/welcome_screen.dart';
import 'package:lpi_app/screens/dashboard_screen.dart';
import 'package:lpi_app/utils/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LPI APP',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
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
        MemberTabs.id: (context) => MemberTabs(),
        ActivityScreen.id: (context) => ActivityScreen()
      },
    );
  }
}
