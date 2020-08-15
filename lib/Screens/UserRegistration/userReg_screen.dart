import 'package:flutter/material.dart';
import 'package:lpi_app/Screens/UserRegistration/components/body.dart';

class RegisterScreen extends StatelessWidget {
  static const String id = 'UserReg_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Body(),
    );
  }
}
