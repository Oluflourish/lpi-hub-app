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
          Container(
            height: 230,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/hands_up.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: new Stack(
                    fit: StackFit.loose,
                    children: <Widget>[
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipOval(
                            child: SizedBox(
                              width: 200,
                              height: 200,
                              child: Image.network(
                                  widget.member.data['downloadUrl'].toString()),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 140.0, right: 0),
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
                                          timestamp: widget
                                              .member.data['createdAt']
                                              .toString(),
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
                        padding: EdgeInsets.only(top: 140.0, left: 150.0),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 0),
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            width: size.width * 1,
            height: 430,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/data_model.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Container(
              child: Column(
                children: <Widget>[
//Tab here
                  Container(
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5),
                            child: Container(
                              height: 40,
                              decoration: new BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: new TabBar(
                                //indicatorSize: TabBarIndicatorSize.label,
                                unselectedLabelColor: Colors.white,

                                indicatorSize: TabBarIndicatorSize.tab,
                                indicator: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Colors.black,
                                      Colors.grey[850]
                                    ]),
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.redAccent),
                                tabs: [
                                  new Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Details',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  new Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Activities',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: Container(
                                  color: Colors.black.withOpacity(0.1),
                                  height: 370,
                                  child: TabBarView(
                                    children: [
                                      SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Expanded(
                                                            child: Text(
                                                          'Firstname',
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        )),
                                                        Expanded(
                                                            child: Text(
                                                          'Surname',
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        ))
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'Email',
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Expanded(
                                                            child: Text(
                                                          'Phone',
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        )),
                                                        Expanded(
                                                            child: Text(
                                                          'Gender',
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        ))
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'Membership Type',
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Expanded(
                                                            child: Text(
                                                          'Firstname',
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        )),
                                                        Expanded(
                                                            child: Text(
                                                          'Surname',
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        ))
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'Email',
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Expanded(
                                                            child: Text(
                                                          'Phone',
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        )),
                                                        Expanded(
                                                            child: Text(
                                                          'Gender',
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        ))
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'Membership Type',
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Icon(Icons.games),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

//Build details here
            ),
          )
        ],
      ),
    );
  }
}
