import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  static const String id = 'activity_screen';
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/data_model.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Activities',
          ),
        ),
        body: ActivityPage(),
      ),
    );
  }
}

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  Future _data;

  Future getActivities() async {
    var firestore = Firestore.instance;
    //we get all member documents here
    QuerySnapshot qn = await firestore.collection('activity').getDocuments();
    return qn.documents;
  }

  @override
  void initState() {
    super.initState();
    //data is set here from the return in method
    _data = getActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.8),
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
                      leading: CircleAvatar(
                        child: Text(
                          (index+1).toString(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor:
                            snapshot.data[index].data["activity"] ==
                                    'Signed Out'
                                ? Colors.red
                                : Colors.green,
                      ),
                      title: Text(
                        snapshot.data[index].data["member"].toString() +
                            ' just ' +
                            snapshot.data[index].data["activity"].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        snapshot.data[index].data["actionTime"]
                            .toDate()
                            .toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
