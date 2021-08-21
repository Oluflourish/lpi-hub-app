import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lpi_app/components/four_radio_input_button.dart';
import 'package:lpi_app/components/radio_input_field.dart';
import 'package:lpi_app/components/rectangle_input_field.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:lpi_app/screens/dashboard_screen.dart';
import 'package:lpi_app/components/rounded_button.dart';
import 'package:lpi_app/functions/utility.dart';
import 'package:lpi_app/utils/colors.dart';


FirebaseUser loggedInUser;

class RegisterScreen extends StatefulWidget {
  static const String id = 'UserReg_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;

  int selectedValue;
  int selectedValue2;
  String imagePath;
  String imageCloudPath;
  String firstname;
  String surname;
  String gender;
  String membershipType;
  String email;
  String phone;
  Timestamp created;
  File _imageFile;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

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

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
      //imagePath = _imageFile.path;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    );
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() => _imageFile = null);
  }

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://lpiapp-4a5a5.appspot.com');

  StorageUploadTask _uploadTask;

  void _startUpload() {
    String filePath = 'images/${DateTime.now()}.png';
    imageCloudPath = filePath;
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(_imageFile);
    });
  }

  _downloadImg(imageRef) {
    var url = _storage.ref().child(imageRef).getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/data_model.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/lpi_hub_white.png",
                width: size.width * 0,
              ),
            ),
            // Positioned(
            //   bottom: 0,
            //   right: 0,
            //   child: Image.asset(
            //     "assets/images/login_bottom.png",
            //     width: size.width * 0,
            //   ),
            // ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child:
                            new Stack(fit: StackFit.loose, children: <Widget>[
                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipOval(
                                child: SizedBox(
                                    width: 140,
                                    height: 140,
                                    child: (_imageFile != null)
                                        ? Image.file(
                                            _imageFile,
                                            fit: BoxFit.contain,
                                          )
                                        : Image.network(
                                            'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png')),
                              ),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 90.0, right: 100.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  (_imageFile != null)
                                      ? CircleAvatar(
                                          backgroundColor: AppColors.primaryColor,
                                          radius: 25.0,
                                          child: IconButton(
                                            icon: Icon(Icons.crop),
                                            onPressed: _cropImage,
                                            color: Colors.black,
                                          ),
                                        )
                                      : new CircleAvatar(
                                          backgroundColor: AppColors.primaryColor,
                                          radius: 25.0,
                                          child: IconButton(
                                            icon: Icon(Icons.photo_camera),
                                            onPressed: () =>
                                                _pickImage(ImageSource.camera),
                                            color: Colors.black,
                                          ),
                                        )
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(top: 90.0, left: 90.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  (_imageFile != null)
                                      ? new CircleAvatar(
                                          backgroundColor: AppColors.primaryColor,
                                          radius: 25.0,
                                          child: IconButton(
                                            icon: Icon(Icons.refresh),
                                            onPressed: _clear,
                                            color: Colors.black,
                                          ),
                                        )
                                      : new CircleAvatar(
                                          backgroundColor: AppColors.primaryColor,
                                          radius: 25.0,
                                          child: IconButton(
                                            icon: Icon(Icons.photo_library),
                                            onPressed: () =>
                                                _pickImage(ImageSource.gallery),
                                            color: Colors.black,
                                          ),
                                        )
                                ],
                              )),
                        ]),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RectangleInputField(
                          icon: Icons.person,
                          hintText: "Surname",
                          onChanged: (value) {
                            //email = value;
                            surname = value;
                          },
                        ),
                        RectangleInputField(
                          icon: Icons.person,
                          hintText: "Firstname",
                          onChanged: (value) {
                            //email = value;
                            firstname = value;
                          },
                        ),
                        RectangleInputField(
                          icon: Icons.email,
                          hintText: "Email",
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                        RectangleInputField(
                          icon: Icons.phone,
                          hintText: "Phone Number",
                          onChanged: (value) {
                            phone = value;
                          },
                        ),
                        DualRadioButton(
                          title: 'Gender',
                          option1: 'Female',
                          option2: 'Male',
                          selectedValue: selectedValue,
                          onChanged: (int selectionValue) {
                            setState(() {
                              selectedValue = selectionValue;
                              (selectionValue == 0)
                                  ? gender = "Female"
                                  : gender = "Male";
                            });
                          },
                        ),
                        QuadDualRadioButton(
                          title: 'Membership Type',
                          option1: 'Pay as you go',
                          option2: 'Izone (Individual)',
                          option3: 'Izone (Startup/Group)',
                          option4: 'Premium',
                          option5: 'Intern',
                          option6: 'Hub Courses',
                          selectedValue2: selectedValue2,
                          onChanged: (int selectionValue2) {
                            setState(() {
                              selectedValue2 = selectionValue2;
                              if (selectionValue2 == 2) {
                                membershipType = 'Pay as you go';
                              } else if (selectionValue2 == 3) {
                                membershipType = 'Izone (Individual)';
                              } else if (selectionValue2 == 4) {
                                membershipType = 'Izone (Startup/Group)';
                              } else if (selectionValue2 == 5) {
                                membershipType = 'Premium';
                              } else if (selectionValue2 == 6) {
                                membershipType = 'Intern';
                              } else if (selectionValue2 == 7) {
                                membershipType = 'Hub Course';
                              }
                            });
                          },
                        ),
                        Container(
                          child: Uploader(
                            file: _imageFile,
                            firstname: firstname,
                            surname: surname,
                            gender: gender,
                            created: created,
                            membershipType: membershipType,
                            email: email,
                            phone: phone,
                          ),
                        ),
                        // RoundedButton(
                        //   text: "REGISTER MEMBER",
                        //   press: () {

                        //     created = Timestamp.now();
                        //     _firestore.collection('members').add({
                        //       'firstname': firstname,
                        //       'email': email,
                        //       'createdAt': created,
                        //       'gender': gender,
                        //       'surname': surname,
                        //       'phone': phone,
                        //       'accountLevel': membershipType,
                        //       'profilepic': imageCloudPath
                        //     });
                        //     print('The Image path we seek is ---->  $imageCloudPath');
                        //     Navigator.pushNamed(context, DashboardScreen.id);
                        //     Uploader(
                        //       file: _imageFile,
                        //     );
                        //     _startUpload;
                        //   },
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



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
            // _startUpload();
            Timestamp created = Timestamp.now();

            // await Future.delayed(const Duration(milliseconds: 5000), () {
            //   setState(() {
            //     // Here you can write your code for open new
            //     getImageUrl(imageCloudPath);
            //   });
            // });

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
