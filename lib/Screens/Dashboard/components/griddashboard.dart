import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lpi_app/Screens/AllMembers/body.dart';
import 'package:lpi_app/Screens/Scan/genScan.dart';
import 'package:lpi_app/Screens/Scan/scanbody.dart';
import 'package:lpi_app/Screens/UserRegistration/userReg_screen.dart';

class GridDashboard extends StatelessWidget {
  final scan = ScanScreen();
  final gen = GenerateScreen();
  Items item1 = new Items(
      title: "SCAN QR CODE",
      subtitle: "March, Wednesday",
      event: "3 Events",
      img: "assets/images/qr-code.png");

  Items item2 = new Items(
    title: "ACTIVITY LOG",
    subtitle: "Bocali, Apple",
    event: "4 Items",
    img: "assets/images/seo-report.png",
  );
  Items item3 = new Items(
    title: "NEW MEMBER",
    subtitle: "Lucy Mao going to Office",
    event: "",
    img: "assets/images/new.png",
  );
  Items item4 = new Items(
    title: "MEMBERS",
    subtitle: "Rose favirited your Post",
    event: "",
    img: "assets/images/employee.png",
  );
  Items item5 = new Items(
    title: "ADMINS",
    subtitle: "Homework, Design",
    event: "4 Items",
    img: "assets/images/shield.png",
  );
  Items item6 = new Items(
    title: "NOTIFICATIONS",
    subtitle: "",
    event: "2 Items",
    img: "assets/images/notification.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10)),
              child: InkResponse(
                onTap: () {
                  _onTileClicked(myList.indexOf(data));

                  if (myList.indexOf(data) == 0) {
                    Navigator.pushNamed(context, ScanScreen.id);
                  }
                  if (myList.indexOf(data) == 1) {
                    
                  }
                  if (myList.indexOf(data) == 3) {
                    Navigator.pushNamed(context, ListViewScreen.id);
                  }
                  if (myList.indexOf(data) == 2) {
                    Navigator.pushNamed(context, RegisterScreen.id);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 42,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items({this.title, this.subtitle, this.event, this.img});
}

void _onTileClicked(int index) {
  debugPrint("You tapped on item $index");

  //ScanScreen();
}
