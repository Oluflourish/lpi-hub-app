import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lpi_app/constants.dart';

final _firestore = Firestore.instance;

FirebaseUser loggedInUser;
bool status = false;

class ScanScreen extends StatefulWidget {
  static const String id = 'scan_screen';

  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";

  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('QR Code Scanner'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                  color: kPrimaryColor,
                  textColor: Colors.black,
                  splashColor: Colors.blueGrey,
                  onPressed: scan,
                  child: const Text('START CAMERA SCAN'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                  color: kPrimaryColor,
                  textColor: Colors.black,
                  splashColor: Colors.blueGrey,
                  onPressed: () async {
                    print('Method invocation happens here first then --->');
                    getDocs();
                  },
                  child: const Text('FIREBASE GETTER'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  barcode,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }

  Future scan() async {
    try {
      //String barcode = (await BarcodeScanner.scan()) as String;

      var test = await BarcodeScanner.scan();
      var mytst = test.rawContent;
      barcode = mytst;

      //call method that updates the  DB here

      debugPrint('This is the barcode feedback $barcode');
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }

    return barcode;
  }
}

void _toggleStatus() async {
  
}

Future getDocs() async {
  QuerySnapshot querySnapshot =
      await Firestore.instance.collection("members").getDocuments();

  for (int i = 0; i < querySnapshot.documents.length; i++) {
    var a = querySnapshot.documents[i];

    var snapshot = await Firestore.instance
        .collection('members')
        .document(a.documentID)
        .get();

    print(snapshot.data['email']);
  }
}
