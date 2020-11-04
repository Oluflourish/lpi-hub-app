import 'package:flutter/material.dart';
import 'package:lpi_app/Screens/Login/login_screen.dart';
import 'package:lpi_app/Screens/Signup/signup_screen.dart';
import 'package:lpi_app/components/rounded_button.dart';
import 'package:lpi_app/constants.dart';
import 'background.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      
      child: SingleChildScrollView(
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
    );
  
  }
}
