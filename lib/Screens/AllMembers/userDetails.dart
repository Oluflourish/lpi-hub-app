import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lpi_app/Screens/Scan/genScan.dart';
import 'package:lpi_app/components/rectangle_input_field.dart';
import 'package:lpi_app/components/rounded_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
          widget.member.data["firstname"].toString() +
              ' ' +
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
                                                .member.data['userid']
                                                .toString(),
                                          ),
                                        ),
                                      );
                                      print(' tapp tapp...............');
                                    },
                                    child: Icon(
                                      Icons.crop_free,
                                      color: Colors.black,
                                    )),
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
                                onPressed: () {},
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
                                                          widget.member
                                                              .data["surname"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                        Expanded(
                                                            child: Text(
                                                          widget.member
                                                              .data["firstname"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ))
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
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
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          widget.member
                                                              .data["email"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
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
                                                            widget.member
                                                                .data["phone"]
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            widget.member
                                                                .data["gender"]
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
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
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          widget
                                                              .member
                                                              .data[
                                                                  "accountLevel"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
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
                                                          'Account Created',
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        )),
                                                        Expanded(
                                                            child: Text(
                                                          'Aug 2, 2020',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        ))
                                                      ],
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
                                                            widget
                                                                .member
                                                                .data[
                                                                    "createdAt"]
                                                                .toDate()
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
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
                                                          'Last login',
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        ),
                                                      ],
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
                                                          widget.member
                                                              .data["createdAt"]
                                                              .toDate()
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
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
                                                          'Last seen',
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        )),
                                                        Expanded(
                                                            child: Text(
                                                          'Hub Presence',
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor),
                                                        ))
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
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
                                                    RoundedButton(
                                                      text: 'DEACTIVATE MEMBER',
                                                      press: () {},
                                                    ),
                                                    RoundedButton(
                                                      text: 'LOG MEMBER OUT',
                                                      press: () {},
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child:
                                                      CircularPercentIndicator(
                                                    radius: 150.0,
                                                    lineWidth: 13.0,
                                                    animation: true,
                                                    percent: 0.7,
                                                    circularStrokeCap:
                                                        CircularStrokeCap.round,
                                                    progressColor:
                                                        Colors.redAccent,
                                                    center: new Text(
                                                      "70.0%",
                                                      style: new TextStyle(
                                                          color: kPrimaryColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                                height: 15,
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Container(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child: Text(
                                                                    'data',
                                                                    style: TextStyle(
                                                                        color:
                                                                            kPrimaryColor),
                                                                  ),
                                                                ),
                                                                Text('data'),
                                                                Text('data'),
                                                                LinearPercentIndicator(
                                                                  width: 140.0,
                                                                  lineHeight:
                                                                      14.0,
                                                                  percent: 0.5,
                                                                  center: Text(
                                                                    "50.0%",
                                                                    style: new TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12.0),
                                                                  ),
                                                                  linearStrokeCap:
                                                                      LinearStrokeCap
                                                                          .roundAll,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .grey,
                                                                  progressColor:
                                                                      kPrimaryLightColor,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 18.7,
                                                  ),
                                                  Container(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Text(
                                                              'data',
                                                              style: TextStyle(
                                                                  color:
                                                                      kPrimaryColor),
                                                            ),
                                                          ),
                                                          Text('data'),
                                                          Text('data'),
                                                          LinearPercentIndicator(
                                                            width: 140.0,
                                                            lineHeight: 14.0,
                                                            percent: 0.5,
                                                            center: Text(
                                                              "50.0%",
                                                              style: new TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      12.0),
                                                            ),
                                                            linearStrokeCap:
                                                                LinearStrokeCap
                                                                    .roundAll,
                                                            backgroundColor:
                                                                Colors.grey,
                                                            progressColor:
                                                                kPrimaryColor,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: <Widget>[
                                                  RoundedButton(
                                                    text: 'ADJUST HOURLY USAGE',
                                                    press: () {},
                                                  ),
                                                  RoundedButton(
                                                    text:
                                                        'ADJUST MONTHLY USAGE',
                                                    press: () {},
                                                  )
                                                ],
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
