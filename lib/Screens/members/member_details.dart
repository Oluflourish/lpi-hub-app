import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lpi_app/screens/Scan/genScan.dart';
import 'package:lpi_app/components/rounded_button.dart';
import 'package:lpi_app/utils/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MemeberDetails extends StatefulWidget {
  final DocumentSnapshot member;
  MemeberDetails({this.member});

  @override
  _MemeberDetailsState createState() => _MemeberDetailsState();
}

class _MemeberDetailsState extends State<MemeberDetails> {
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/data_model.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.modulate),
                  image: AssetImage('assets/images/hands_up.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: new Stack(
                      // fit: StackFit.loose,
                      children: <Widget>[
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(100)),
                              child: ClipOval(
                                child: SizedBox(
                                  width: 180,
                                  height: 180,
                                  child: Image.network(widget
                                      .member.data['downloadUrl']
                                      .toString()),
                                ),
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
                                  backgroundColor: AppColors.primaryColor,
                                  radius: 25.0,
                                  child: InkResponse(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                GenerateScreen(
                                              timestamp: widget
                                                  .member.data['userid']
                                                  .toString(),
                                            ),
                                          ),
                                        );
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
                                backgroundColor: AppColors.primaryColor,
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
              child: Column(
                children: <Widget>[
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
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(50)),
                              child: new TabBar(
                                 unselectedLabelColor: AppColors.black,
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelColor: AppColors.white,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.primaryColor,
                                ),
                                labelStyle: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500),

                                tabs: [
                                  new Tab(text: "DETAILS"),
                                  new Tab(text: "ACTIVITIES"),
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
                                  height: (size.height / 5) * 4 - 220,
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
                                                              color: AppColors
                                                                  .primaryColor),
                                                        )),
                                                        Expanded(
                                                            child: Text(
                                                          'Surname',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .primaryColor),
                                                        ))
                                                      ],
                                                    ),
                                                    SizedBox(height: 4.0),
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
                                                    SizedBox(height: 20),
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
                                                              color: AppColors
                                                                  .primaryColor),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 4.0),
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
                                                    SizedBox(height: 20),
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
                                                              color: AppColors
                                                                  .primaryColor),
                                                        )),
                                                        Expanded(
                                                            child: Text(
                                                          'Gender',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .primaryColor),
                                                        ))
                                                      ],
                                                    ),
                                                    SizedBox(height: 4.0),
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
                                                    SizedBox(height: 20),
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
                                                              color: AppColors
                                                                  .primaryColor),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 4.0),
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
                                                              color: AppColors
                                                                  .primaryColor),
                                                        )),
                                                        Expanded(
                                                            child: Text(
                                                          DateFormat('yMMMd')
                                                              .format(widget
                                                                  .member
                                                                  .data[
                                                                      "createdAt"]
                                                                  .toDate()),
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .primaryColor),
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
                                                            DateFormat('yMMMd')
                                                                .format(widget
                                                                    .member
                                                                    .data[
                                                                        "createdAt"]
                                                                    .toDate()),
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
                                                              color: AppColors
                                                                  .primaryColor),
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
                                                          DateFormat('yMMMd')
                                                              .format(widget
                                                                  .member
                                                                  .data[
                                                                      "createdAt"]
                                                                  .toDate()),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 20),
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
                                                              color: AppColors
                                                                  .primaryColor),
                                                        )),
                                                        Expanded(
                                                            child: Text(
                                                          'Hub Presence',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .primaryColor),
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
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
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
                                                    .withOpacity(0.8),
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
                                                          color: AppColors
                                                              .primaryColor,
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
                                                        .withOpacity(0.8),
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
                                                                        color: AppColors
                                                                            .primaryColor),
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
                                                                      AppColors
                                                                          .secondaryColor,
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
                                                        .withOpacity(0.8),
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
                                                                  color: AppColors
                                                                      .primaryColor),
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
                                                                AppColors
                                                                    .primaryColor,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color:
                                                Colors.black.withOpacity(0.8),
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
            )
          ],
        ),
      ),
    );
  }
}
