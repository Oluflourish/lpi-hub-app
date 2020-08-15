import 'package:flutter/material.dart';
import 'package:lpi_app/Screens/Welcome/components/body.dart';

class WelcomeScreen extends StatelessWidget {
   static const String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
