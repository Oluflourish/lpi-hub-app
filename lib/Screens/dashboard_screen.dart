import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lpi_app/screens/members/member_tabs.dart';
import 'package:lpi_app/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lpi_app/screens/activity.dart';
import 'package:lpi_app/screens/Scan/scanbody.dart';
import 'package:lpi_app/screens/userReg_screen.dart';

class DashboardScreen extends StatefulWidget {
  static const String id = 'dashboard_screen';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String profile;

  SharedPreferences logindata;
  String username;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username');
    });
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          loggedInUser = user;
          profile = loggedInUser.email;
          //profile = loggedInUser.displayName;
        });

        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  getCount() async {
    var qn = Firestore.instance
        .collection('members')
        .where("isloggedIn", isEqualTo: true)
        .limit(1)
        .getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/data_model.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("LPI HUB APP"),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DashboardCounter(
                    title: "MEMBERS",
                    count: "13",
                    icon: "qr-code",
                    color: Color(0xFF01C1F0)),
                DashboardCounter(
                    title: "LOGGED IN",
                    count: "2",
                    icon: "seo-report",
                    color: Color(0xFFF39C11)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DashboardCounter(
                    title: "ADMINS",
                    count: "12",
                    icon: "new",
                    color: Color(0xFFFd34736)),
                DashboardCounter(
                    title: "SUBSCRIBED",
                    count: "32",
                    icon: "user_secret",
                    color: Color(0xFF00A65A)),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                color: Colors.black.withOpacity(0.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Text(
                            'Hello, $profile',
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                          child: Text(
                            "Last login:",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      color: Colors.black,
                      alignment: Alignment.topCenter,
                      icon: Image.asset(
                        "assets/images/notification.png",
                        width: 24,
                      ),
                      onPressed: () {
                        logindata.setBool('login', true);
                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => WelcomeScreen()));
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                DashboardCard(
                  name: "SCAN QR CODE",
                  icon: "qrcode",
                  onTap: () => Navigator.pushNamed(context, ScanScreen.id),
                ),
                DashboardCard(
                  name: "ACTIVITY LOG",
                  icon: "list",
                  onTap: () => Navigator.pushNamed(context, ActivityScreen.id),
                ),
              ],
            ),
            Row(
              children: [
                DashboardCard(
                  name: "NEW MEMBER",
                  icon: "add_user",
                  onTap: () => Navigator.pushNamed(context, RegisterScreen.id),
                ),
                DashboardCard(
                  name: "MEMBERS",
                  icon: "users",
                  onTap: () =>
                      Navigator.pushNamed(context, MemberTabs.id),
                ),
              ],
            ),
            Row(
              children: [
                DashboardCard(
                  name: "ADMINS",
                  icon: "shield",
                ),
                DashboardCard(
                  name: "NOTIFICATIONS",
                  icon: "notification",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    Key key,
    @required this.name,
    @required this.icon,
    this.onTap,
  }) : super(key: key);

  final String name;
  final String icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: screenSize.width / 2 - 16,
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        height: 140,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/$icon.png",
                width: 72, color: Colors.white),
            SizedBox(height: 14),
            Text(
              name,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCounter extends StatelessWidget {
  const DashboardCounter({
    Key key,
    @required this.icon,
    @required this.count,
    @required this.title,
    @required this.color,
  }) : super(key: key);

  final String icon;
  final String count;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MemberTabs.id);
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        width: screenSize.width / 2 - 16,
        height: 56.0,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.black.withOpacity(0.3),
                  width: 64,
                  height: 56,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset("assets/images/$icon.png"),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        count,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Items2 {
  String title;
  String subtitle;
  String event;
  String img;
  Color color;
  Items2({this.title, this.subtitle, this.event, this.img, this.color});
}
