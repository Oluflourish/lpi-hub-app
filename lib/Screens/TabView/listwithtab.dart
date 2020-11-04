import 'package:flutter/material.dart';
import 'package:lpi_app/screens/AllMembers/activeListPage.dart';
import 'package:lpi_app/screens/AllMembers/body.dart';
import 'package:lpi_app/screens/AllMembers/inActiveListPage.dart';

class ListWithTabScreen extends StatefulWidget {
  static const String id = 'listtabview_screen';
  @override
  _ListWithTabScreenState createState() => _ListWithTabScreenState();
}

class _ListWithTabScreenState extends State<ListWithTabScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/data_model.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Text('Members')),
          body: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Container(
                  decoration: new BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: new TabBar(
                    //indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.white,

                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black, Colors.grey[850]]),
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.redAccent),
                    tabs: [
                      new Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'All',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      new Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Active',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      new Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Subscribed',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: Container(
                    color: Colors.black.withOpacity(0.8),
                    height: size.height - 148,
                    child: TabBarView(children: [
                      ListPage(),
                      ActiveListPage(),
                      InActiveListPage(),
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
