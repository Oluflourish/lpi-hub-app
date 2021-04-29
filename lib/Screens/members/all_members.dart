import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lpi_app/screens/members/member_details.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

String _downlaodUrl;

class _ListPageState extends State<ListPage> {
  Future _data;

  Future getMembers() async {
    var firestore = Firestore.instance;
    //we get all member documents here 
    QuerySnapshot qn = await firestore.collection('members').getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot member) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MemeberDetails(
                  member: member,
                )));
  }

  @override
  void initState() {
    super.initState();
    //data is set here from the return in method
    _data = getMembers();
  }

  Future getImageUrl(imageRef) async {
    StorageReference _reference =
        FirebaseStorage.instance.ref().child(imageRef);
    String downloadAddress = await _reference.getDownloadURL();
    setState(() {
      _downlaodUrl = downloadAddress;
    });
    return _downlaodUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: _data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text(
                  "Loading ...",
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              return new ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      leading: Container(
                        decoration:BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(100)) ,
                        child: ClipOval(
                          
                          child:
                              (snapshot.data[index].data["downloadUrl"] != null)
                                  ? Image.network(
                                      snapshot.data[index].data["downloadUrl"],
                                      fit: BoxFit.contain,
                                    )
                                  : Image.network(
                                      'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
                                      fit: BoxFit.contain,
                                    ),
                        ),
                      ),
                      title: Text(
                        snapshot.data[index].data["firstname"].toString() +
                            ' ' +
                            snapshot.data[index].data["surname"].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        snapshot.data[index].data["email"].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () => navigateToDetail(snapshot.data[index]),
                    );
                  });
            }
          }),
    );
  }
}
