import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lpi_app/Screens/Dashboard/dashboard_screen.dart';
import 'package:lpi_app/Screens/Login/login_screen.dart';
import 'package:lpi_app/Screens/Signup/components/background.dart';
import 'package:lpi_app/Screens/Signup/components/or_divider.dart';
import 'package:lpi_app/Screens/Signup/components/social_icon.dart';
import 'package:lpi_app/Screens/Signup/signup_screen.dart';
import 'package:lpi_app/Screens/UserRegistration/userReg_screen.dart';
import 'package:lpi_app/Screens/Welcome/welcome_screen.dart';
import 'package:lpi_app/components/already_have_an_account_acheck.dart';
import 'package:lpi_app/components/rounded_button.dart';
import 'package:lpi_app/components/rounded_input_field.dart';
import 'package:lpi_app/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lpi_app/constants.dart';
import 'package:lpi_app/functions/alertDialog.dart';
import 'package:lpi_app/functions/googlesignin.dart';
import 'package:lpi_app/functions/utility.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _auth = FirebaseAuth.instance;

  String email;

  String password;

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              Text(
                "SIGNUP",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    fontSize: 20),
              ),
              SizedBox(height: size.height * 0),
              Image.asset(
                "assets/images/register.png",
                height: size.height * 0.35,
                width: size.width * 0.8,
              ),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {
                  email = value;
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  password = value;
                },
              ),
              RoundedButton(
                text: "SIGNUP",
                press: () async {
                  // print(email);
                  // print(password);
                  //where firebase auth comes in
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, RegisterScreen.id);
                    }
                  } catch (e) {
                    print('Error caught ------>  ' + e.toString());
                    setState(() {
                      showSpinner = false;
                    });

                    Utility.getInstance().showAlertDialog(
                        context, 'Sign Up Error', e.toString());
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
              OrDivider(),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocalIcon(
                      iconSrc: "assets/icons/facebook.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      iconSrc: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      iconSrc: "assets/icons/google-plus.svg",
                      press: () {
                        signInWithGoogle().whenComplete(() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return RegisterScreen();
                              },
                            ),
                          );
                        });
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
