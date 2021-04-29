import 'package:flutter/material.dart';
import 'package:lpi_app/screens/login_screen.dart';
import 'package:lpi_app/screens/signup_screen.dart';
import 'package:lpi_app/components/rounded_button.dart';
import 'package:lpi_app/constants.dart';

class WelcomeScreen extends StatelessWidget {
   static const String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
      color: Colors.grey[850],
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0,
            ),
          ),
          SingleChildScrollView(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            Text(
              "WELCOME TO LPI HUB",
              
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: kPrimaryColor),
            ),
            SizedBox(height: size.height * 0),
            ColorFiltered(
                          child: Image.asset(
                "assets/images/hands_up.jpg",
                height: size.height * 0.45,
              ),
              colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.darken),
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              textColor: Colors.black,
              press: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: Colors.black,
              textColor: Colors.white,
              press: () {
                Navigator.pushNamed(
                 context,SignUpScreen.id
                );
              },
            ),
          ],
        ),
      ),
    
        ],
      ),
    ),
  
    );
  }
}
