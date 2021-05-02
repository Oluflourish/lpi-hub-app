import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lpi_app/screens/members/member_details.dart';
import 'package:lpi_app/widgets/member_item.dart';

class InActiveMembers extends StatefulWidget {
  @override
  _InActiveMembersState createState() => _InActiveMembersState();
}

class _InActiveMembersState extends State<InActiveMembers> {
  Future _data;
  Future getMembers() async {
    var firestore = Firestore.instance;
    //we get all member documents here
    QuerySnapshot qn = await firestore
        .collection('members')
        .where('isloggedIn', isEqualTo: false)
        .getDocuments();
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
                    var userData = snapshot.data[index];
                    return MemberItem(
                      userData: userData,
                      onTap: () => navigateToDetail(snapshot.data[index]),
                    );
                  });
            }
          }),
    );
  }
}
