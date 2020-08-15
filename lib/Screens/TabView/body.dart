import 'package:flutter/material.dart';

class TabViewScreen extends StatefulWidget {
  static const String id = 'tabview_screen';
  @override
  _TabViewScreenState createState() => _TabViewScreenState();
}

class _TabViewScreenState extends State<TabViewScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
          child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            unselectedLabelColor: Colors.white, 
            labelColor: Colors.black,
            tabs: [
              new Tab(icon: new Icon(Icons.people)),
              new Tab(
                icon: new Icon(Icons.local_activity),
              ),
              new Tab(
                icon: new Icon(Icons.notifications),
              )
            ],
            
          ),
          
        ),
      ),
    );
  }
}


