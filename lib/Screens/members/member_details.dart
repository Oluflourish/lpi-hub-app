import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lpi_app/components/rounded_button.dart';
import 'package:lpi_app/utils/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:barcode_widget/barcode_widget.dart';

class MemeberDetails extends StatefulWidget {
  final DocumentSnapshot member;
  MemeberDetails({this.member});

  @override
  _MemeberDetailsState createState() => _MemeberDetailsState();
}

class _MemeberDetailsState extends State<MemeberDetails> {
  _showGenders() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.blackText,
                  child: Text(
                    "${widget.member.data["firstname"]}'s QR Code",
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                ),
                SizedBox(height: 32.0),
                Container(
                  child: BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: widget.member.data['userid'].toString(),
                    height: 180,
                    width: 180,
                  ),
                ),
                SizedBox(height: 32.0),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.blackText,
                  child: Row(
                    children: [
                      Icon(Icons.share),
                      Text(
                        "${widget.member.data["firstname"]}'s QR Code",
                        style: TextStyle(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    TextStyle textStyle1 = TextStyle(
        fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.white);

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
              padding: EdgeInsets.symmetric(vertical: 20.0),
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
                  Stack(
                    children: <Widget>[
                      Column(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                radius: 25.0,
                                child: InkWell(
                                    // onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => GenerateScreen(
                                    //       timestamp: widget
                                    //           .member.data['userid']
                                    //           .toString(),
                                    //     ),
                                    //   ),
                                    // );
                                    // },
                                    // onTap: () => _showTicketCancelDialog(context),
                                    onTap: _showGenders,
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
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: <Widget>[
                      Container(
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
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.0),
                          tabs: [
                            Tab(text: "DETAILS"),
                            Tab(text: "ACTIVITIES"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: ClampingScrollPhysics(),
                          children: [
                            SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    color: Colors.black.withOpacity(0.5),
                                    padding: const EdgeInsets.all(14.0),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 14.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                'First name',
                                                style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Last name',
                                                style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 4.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                "${widget.member.data["firstname"]}"
                                                    .toUpperCase(),
                                                style: textStyle1,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${widget.member.data["surname"]}"
                                                    .toUpperCase(),
                                                style: textStyle1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Email',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "${widget.member.data["email"]}",
                                              style: textStyle1,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                                child: Text(
                                              'Phone',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.primaryColor),
                                            )),
                                            Expanded(
                                                child: Text(
                                              'Gender',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.primaryColor),
                                            ))
                                          ],
                                        ),
                                        SizedBox(height: 4.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                "${widget.member.data["phone"]}",
                                                style: textStyle1,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${widget.member.data["gender"]}"
                                                    .toUpperCase(),
                                                style: textStyle1,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 20.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Membership Type',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "${widget.member.data["accountLevel"]}"
                                                  .toUpperCase(),
                                              style: textStyle1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black.withOpacity(0.5),
                                    padding: const EdgeInsets.all(14.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                                child: Text(
                                              'Account Created',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.primaryColor),
                                            )),
                                            Expanded(
                                                child: Text(
                                              DateFormat('yMMMd').format(widget
                                                  .member.data["createdAt"]
                                                  .toDate()),
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color:
                                                      AppColors.primaryColor),
                                            ))
                                          ],
                                        ),
                                        SizedBox(height: 4.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                DateFormat('yMMMd').format(
                                                    widget.member
                                                        .data["createdAt"]
                                                        .toDate()),
                                                style: textStyle1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Last login',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              DateFormat('yMMMd').format(widget
                                                  .member.data["createdAt"]
                                                  .toDate()),
                                              style: textStyle1,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                                child: Text(
                                              'Last seen',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.primaryColor),
                                            )),
                                            Expanded(
                                                child: Text(
                                              'Hub Presence',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.primaryColor),
                                            ))
                                          ],
                                        ),
                                        SizedBox(height: 4.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: screenSize.width * 0.45,
                                                child: Text(
                                                  'Last seen',
                                                  style: textStyle1,
                                                )),
                                            Container(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 6.0,
                                                    horizontal: 16.0),
                                                decoration: BoxDecoration(
                                                  color: AppColors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                child: Text(
                                                  'LOGGED IN',
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 1.0,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black.withOpacity(0.5),
                                    padding: const EdgeInsets.all(14.0),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 14.0),
                                    child: Column(
                                      children: <Widget>[
                                        RoundedButton(
                                          text: 'DEACTIVATE MEMBER',
                                          textColor: AppColors.white,
                                          press: () {},
                                        ),
                                        RoundedButton(
                                          text: 'LOG MEMBER OUT',
                                          textColor: AppColors.white,
                                          press: () {},
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        color: Colors.black.withOpacity(0.5),
                                        padding: const EdgeInsets.all(14.0),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 14.0),
                                        child: CircularPercentIndicator(
                                          radius: 140.0,
                                          lineWidth: 10.0,
                                          animation: true,
                                          percent: 0.7,
                                          backgroundColor: AppColors.white,
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                          progressColor: Colors.redAccent,
                                          center: new Text(
                                            "70.0%",
                                            style: new TextStyle(
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15.0),
                                      Column(
                                        children: <Widget>[
                                          Container(
                                            width: screenSize.width * 0.5,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0,
                                                vertical: 8.0),
                                            margin: const EdgeInsets.only(
                                                top: 14.0, bottom: 8.0),
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Text(
                                                      'HOURLY USAGE',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12.0,
                                                          color: AppColors
                                                              .primaryColor),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        '50%',
                                                        style: TextStyle(
                                                            fontSize: 30.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .white),
                                                      ),
                                                      Text(
                                                        '32 hours left',
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontSize: 12.0,
                                                            color: AppColors
                                                                .white),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  LinearPercentIndicator(
                                                    padding: EdgeInsets.zero,
                                                    width:
                                                        screenSize.width * 0.5 -
                                                            24,
                                                    lineHeight: 8.0,
                                                    percent: 0.5,
                                                    // center: Text("50.0%"),

                                                    linearStrokeCap:
                                                        LinearStrokeCap
                                                            .roundAll,
                                                    backgroundColor:
                                                        AppColors.white,
                                                    progressColor:
                                                        AppColors.primaryColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: screenSize.width * 0.5,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0,
                                                vertical: 16.0),
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Text(
                                                      'HOURLY USAEGE',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12.0,
                                                          color: AppColors
                                                              .primaryColor),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        '50%',
                                                        style: TextStyle(
                                                            fontSize: 30.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .white),
                                                      ),
                                                      Text(
                                                        '32 hours left',
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontSize: 12.0,
                                                            color: AppColors
                                                                .white),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  LinearPercentIndicator(
                                                    padding: EdgeInsets.zero,
                                                    width:
                                                        screenSize.width * 0.5 -
                                                            24,
                                                    lineHeight: 8.0,
                                                    percent: 0.5,
                                                    // center: Text("50.0%"),

                                                    linearStrokeCap:
                                                        LinearStrokeCap
                                                            .roundAll,
                                                    backgroundColor:
                                                        AppColors.white,
                                                    progressColor:
                                                        AppColors.primaryColor,
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
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.black.withOpacity(0.8),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: <Widget>[
                                          RoundedButton(
                                            textColor: AppColors.white,
                                            text: 'ADJUST HOURLY USAGE',
                                            press: () {},
                                          ),
                                          RoundedButton(
                                            textColor: AppColors.white,
                                            text: 'ADJUST MONTHLY USAGE',
                                            press: () {},
                                          )
                                        ],
                                      ),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
