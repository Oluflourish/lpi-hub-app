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
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
  child: new TabBar(
    
    tabs: [
      new Tab(
          icon: const Icon(Icons.home),
          text: 'Address',
      ),
      new Tab(
          icon: const Icon(Icons.my_location),
          text: 'Location',
      ),
       new Tab(
          icon: const Icon(Icons.my_location),
          text: 'Location',
      ),
    ],
  ),


          ),
        ),
      ),
    );
  }
}


