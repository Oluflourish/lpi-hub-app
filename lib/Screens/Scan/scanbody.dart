import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lpi_app/utils/colors.dart';

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
  dynamic data;
  String log;

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

  getDoc() async {
    print(barcode);
    await scan();
    Firestore.instance
        .collection('members')
        .where("userid", isEqualTo: barcode)
        .limit(1)
        .getDocuments()
        .then(
      (value) async {
        if (value.documents.length > 0) {
          for (int i = 0; i < value.documents.length; i++) {
            var a = value.documents[i];

            var snapshot = await Firestore.instance
                .collection('members')
                .document(a.documentID)
                .get();

            print(snapshot.data['email']);
            print(snapshot.data['userid']);
            print(snapshot.data['isloggedIn']);
            status = snapshot.data['isloggedIn'];
            print(status);
            Timestamp time = Timestamp.now();
            if (status == false) {
              print('Inside if condition');
              status = true;

              setState(() {
                log = 'signed in';
              });

              _firestore.collection('activity').add({
                'actionTime': time,
                'member': snapshot.data['email'],
                'status': status,
                'activity': 'Signed In'
              });
              _firestore
                  .collection('members')
                  .document(a.documentID)
                  .updateData({'isloggedIn': status, 'lastAction': time});
            } else if (status == true) {
              print('Inside else if condition');
              status = false;
              setState(() {
                log = 'signed out';
              });

              _firestore.collection('activity').add({
                'actionTime': Timestamp.now(),
                'member': snapshot.data['email'],
                'status': status,
                'activity': 'Signed Out'
              });
              _firestore
                  .collection('members')
                  .document(a.documentID)
                  .updateData({'isloggedIn': status, 'lastAction': time});
            }
          }
        } else {
          return null;
        }
      },
    );
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
                  color: AppColors.primaryColor,
                  textColor: Colors.black,
                  splashColor: Colors.blueGrey,
                  onPressed: getDoc,
                  child: const Text('START CAMERA SCAN'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'User $log',
                  textAlign: TextAlign.center,
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

  Future<String> scan() async {
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
  }
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
//3B9U1Yz7fINZvO1FYT6d
