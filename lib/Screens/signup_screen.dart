import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lpi_app/screens/login_screen.dart';
import 'package:lpi_app/screens/userReg_screen.dart';
import 'package:lpi_app/components/rounded_button.dart';
import 'package:lpi_app/components/rounded_input_field.dart';
import 'package:lpi_app/components/rounded_password_field.dart';
import 'package:lpi_app/functions/googlesignin.dart';
import 'package:lpi_app/functions/utility.dart';
import 'package:lpi_app/utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;

  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

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
                  "CREATE ACCOUNT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                    fontSize: 28.0,
                  ),
                ),
                SizedBox(height: 30.0),
                RoundedInputField(
                  hintText: "Email",
                  onChanged: (value) {
                    email = value;
                  },
                ),
                RoundedPasswordField(
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(height: 20.0),
                RoundedButton(
                  text: "CREATE ACCOUNT",
                  press: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
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
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have an Account ? ",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 15.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    )
                  ],
                ),
                if (false) ...[
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9),
        height: 1.5,
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/data_model.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      // Here i can use size.width but use double.infinity because both work as a same
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/lpi_hub_white.png",
              width: size.width * 0,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class SocalIcon extends StatelessWidget {
  final String iconSrc;
  final Function press;
  const SocalIcon({
    Key key,
    this.iconSrc,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          border: Border.all(
            width: 2,
            color: AppColors.primaryColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
