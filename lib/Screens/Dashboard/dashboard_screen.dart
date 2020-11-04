import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lpi_app/screens/TabView/listwithtab.dart';
import 'package:lpi_app/screens/Welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/griddashboard.dart';

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

  Items2 item1 = new Items2(
      title: "MEMBERS",
      subtitle: "32",
      event: "3 Events",
      img: "assets/images/qr-code.png",
      color: Colors.green[400]);

  Items2 item2 = new Items2(
      title: "LOGGED IN",
      subtitle: "1",
      event: "4 Items",
      img: "assets/images/seo-report.png",
      color: Colors.purple[400]);
  Items2 item3 = new Items2(
      title: "ADMINS",
      subtitle: "4",
      event: "",
      img: "assets/images/new.png",
      color: Colors.blue[400]);
  Items2 item4 = new Items2(
      title: "SUBSCRIBED",
      subtitle: "3",
      event: "",
      img: "assets/images/employee.png",
      color: Colors.pink[400]);

  @override
  Widget build(BuildContext context) {
    List<Items2> myList = [item1, item2, item3, item4];
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
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                Flexible(
                    child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: (MediaQuery.of(context).size.height) / 5,
                  color: Colors.transparent,
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 16 / 5.5,
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: myList.map((data) {
                      return InkResponse(
                        onTap: () {
                          if (myList.indexOf(data) == 0) {
                            Navigator.pushNamed(context, ListWithTabScreen.id);
                          }
                          if (myList.indexOf(data) == 1) {
                            Navigator.pushNamed(context, ListWithTabScreen.id);
                          }
                          if (myList.indexOf(data) == 2) {
                            Navigator.pushNamed(context, ListWithTabScreen.id);
                          }
                          if (myList.indexOf(data) == 3) {
                            Navigator.pushNamed(context, ListWithTabScreen.id);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: data.color,
                              borderRadius: BorderRadius.circular(1)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    color: Colors.black.withOpacity(0.5),
                                    width: 50,
                                    height: 54.5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(data.img),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 8),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          data.subtitle,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          data.title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
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
                    }).toList(),
                  ),
                ))
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
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
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                          child: Text(
                            "Home",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
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
            SizedBox(
              height: 15,
            ),
            GridDashboard()
          ],
        ),
      ),
    );
  }
}

class QuerySnapshot {}

class Items2 {
  String title;
  String subtitle;
  String event;
  String img;
  Color color;
  Items2({this.title, this.subtitle, this.event, this.img, this.color});
}
