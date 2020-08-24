import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lpi_app/Screens/Dashboard/dashboard_screen.dart';
import 'package:lpi_app/components/rounded_button.dart';
import 'package:lpi_app/functions/utility.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Uploader extends StatefulWidget {
  final File file;
  final String imagePath;
  final String firstname;
  final String surname;
  final String gender;
  final String membershipType;
  final String email;
  final String phone;
  final Timestamp created;

  Uploader(
      {Key key,
      this.file,
      this.created,
      this.imagePath,
      this.firstname,
      this.surname,
      this.gender,
      this.membershipType,
      this.email,
      this.phone})
      : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://lpiapp-4a5a5.appspot.com');

  StorageUploadTask _uploadTask;
  StorageFileDownloadTask _downloadTask;
  String imageCloudPath;
  String downloadAddress;
  String _downlaodUrl;
  bool showSpinner = false;

  _startUpload() {
    String filePath = 'images/${DateTime.now()}.png';
    imageCloudPath = filePath;

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  Future getImageUrl(filePath) async {
    StorageReference _reference =
        FirebaseStorage.instance.ref().child(filePath.toString());
    String downloadAddress = await _reference.getDownloadURL();
    setState(() {
      _downlaodUrl = downloadAddress;
    });
  }

  final _firestore = Firestore.instance;
  FirebaseUser loggedInUser;
  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (context, snapshot) {
            var event = snapshot?.data?.snapshot;
            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
              children: <Widget>[
                if (_uploadTask.isComplete) Text('Uploaded!'),
                if (_uploadTask.isPaused)
                  FlatButton(
                    onPressed: _uploadTask.resume,
                    child: Icon(Icons.play_arrow),
                  ),
                if (_uploadTask.isInProgress)
                  FlatButton(
                    onPressed: _uploadTask.pause,
                    child: Icon(Icons.pause),
                  ),
                LinearProgressIndicator(value: progressPercent),
                Text('${(progressPercent * 100).toStringAsFixed(2)}%'),
              ],
            );
          });
    } else {
      return RoundedButton(
        text: 'REGISTER MEMBER',
        press: () async {
          try {
            _startUpload();
            Timestamp created = Timestamp.now();

            await Future.delayed(const Duration(milliseconds: 5000), () {
              setState(() {
                // Here you can write your code for open new
                getImageUrl(imageCloudPath);
              });
            });

            await Future.delayed(const Duration(milliseconds: 2000), () {
              print('The download path we seek is ---->  $_downlaodUrl');
              _firestore.collection('members').add({
                'firstname': widget.firstname,
                'email': widget.email,
                'createdAt': created,
                'gender': widget.gender,
                'surname': widget.surname,
                'phone': widget.phone,
                'accountLevel': widget.membershipType,
                'profilepic': imageCloudPath,
                'downloadUrl': _downlaodUrl,
                'isloggedIn': false,
              }).then((value) {
                var hey = value.documentID.toString();
                print('This is the document ID ----> $hey');
                _firestore
                    .collection('members')
                    .document(hey)
                    .updateData({'userid': hey});
              });

              print('The Image path we seek is ---->  $imageCloudPath');
              Navigator.pushNamed(context, DashboardScreen.id);
            });
          } catch (e) {
            Utility.getInstance()
                .showAlertDialog(context, 'Upload Error', e.toString());
          }
        },
      );
    }
  }
}
