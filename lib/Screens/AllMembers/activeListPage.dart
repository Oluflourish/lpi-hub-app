import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lpi_app/Screens/AllMembers/userDetails.dart';

class ActiveListPage extends StatefulWidget {
  @override
  _ActiveListPageState createState() => _ActiveListPageState();
}

class _ActiveListPageState extends State<ActiveListPage> {
  Future _data;
  Future getMembers() async {
    var firestore = Firestore.instance;
    //we get all member documents here
    QuerySnapshot qn = await firestore
        .collection('members')
        .where('isloggedIn', isEqualTo: true)
        .getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot member) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  member: member,
                )));
  }

  @override
  void initState() {
    super.initState();
    //data is set here from the return in method
    _data = getMembers();
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
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(100)),
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
