import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lpi_app/Screens/Scan/genScan.dart';

import '../../constants.dart';

class DetailPage extends StatefulWidget {
  final DocumentSnapshot member;
  DetailPage({this.member});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        
        appBar: AppBar(
          title: Text(
            widget.member.data["surname"].toString(),
          ),
        ),
        
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: new Stack(fit: StackFit.loose, children: <Widget>[
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(
                          child: SizedBox(
                            width: 140,
                            height: 140,
                            child: Image.network(
                                widget.member.data['downloadUrl'].toString()),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 90.0, right: 100.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new CircleAvatar(
                              backgroundColor: kPrimaryColor,
                              radius: 25.0,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GenerateScreen(
                                        timestamp: widget.member.data['createdAt'].toString(),
                                      ),
                                    ),
                                  );
                                  print('tapp tapp...............');
                                },
                                child: Image.network(
                                    'https://cdn0.iconfinder.com/data/icons/material-style/48/qrcode-512.png'),
                              ),
                            )
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 90.0, left: 90.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new CircleAvatar(
                              backgroundColor: kPrimaryColor,
                              radius: 25.0,
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  print('tapp tapp...............');
                                },
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),git
                        ),
                  ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              width: size.width * 0.9,
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                widget.member.data['surname'].toString() +
                    ' ' +
                    widget.member.data['firstname'].toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        );
  }
}
