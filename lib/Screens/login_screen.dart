import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lpi_app/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lpi_app/screens/dashboard_screen.dart';
import 'package:lpi_app/screens/signup_screen.dart';
import 'package:lpi_app/components/rounded_button.dart';
import 'package:lpi_app/components/rounded_input_field.dart';
import 'package:lpi_app/components/rounded_password_field.dart';
import 'package:lpi_app/functions/utility.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  String email;
  String password;
  bool showSpinner = false;
  bool newuser;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              AppColors.transparent.withOpacity(0.4), BlendMode.dstATop),
          image: AssetImage('assets/images/hub2.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            height: screenSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/images/lpi_hub_white.png"),
                SizedBox(height: 36.0),
                Text(
                  "LOGIN",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                    fontSize: 30.0,
                  ),
                ),
                SizedBox(height: 30.0),
                RoundedInputField(
                  hintText: "Email",
                  onChanged: (value) {
                    email = value.trim();
                  },
                ),
                RoundedPasswordField(
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(height: 20.0),
                RoundedButton(
                  text: "LOGIN",
                  press: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();

                        pref.setBool('isLoggedIn', true);
                        pref.setString('username', email);
                        Navigator.popAndPushNamed(context, DashboardScreen.id);
                      }
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                      });

                      Utility.getInstance().showAlertDialog(
                          context, 'Login Error', e.toString());
                    }
                  },
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don’t have an Account ? ",
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 15.0),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
