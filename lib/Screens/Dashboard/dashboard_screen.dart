import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          loggedInUser = user;
          profile = loggedInUser.email;
        });

        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Items2 item1 = new Items2(
      title: "SCAN QR CODE",
      subtitle: "March, Wednesday",
      event: "3 Events",
      img: "assets/images/qr-code.png",
      color: Colors.green[400]);

  Items2 item2 = new Items2(
      title: "ACTIVITY LOG",
      subtitle: "Bocali, Apple",
      event: "4 Items",
      img: "assets/images/seo-report.png",
      color: Colors.purple[400]);
  Items2 item3 = new Items2(
      title: "NEW MEMBER",
      subtitle: "Lucy Mao going to Office",
      event: "",
      img: "assets/images/new.png",
      color: Colors.blue[400]);
  Items2 item4 = new Items2(
      title: "MEMBERS",
      subtitle: "Rose favirited your Post",
      event: "",
      img: "assets/images/employee.png",
      color: Colors.pink[400]);

  @override
  Widget build(BuildContext context) {
    List<Items2> myList = [item1, item2, item3, item4];
    return Container(
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
                  width: 360,
                  height: 125,
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
                      return Container(
                        decoration: BoxDecoration(
                            color: data.color,
                            borderRadius: BorderRadius.circular(1)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(''
                                // data.img,
                                // width: 42,
                                ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              ' ',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Opacity(
                opacity: 0.9,
                child: Container(
                  color: Colors.black,
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
                                      fontSize: 18,
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
                        onPressed: () {},
                      )
                    ],
                  ),
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

class Items2 {
  String title;
  String subtitle;
  String event;
  String img;
  Color color;
  Items2({this.title, this.subtitle, this.event, this.img, this.color});
}
