import 'package:flutter/material.dart';
import 'package:lpi_app/screens/members/active_members.dart';
import 'package:lpi_app/screens/members/all_members.dart';
import 'package:lpi_app/screens/members/in_active_members.dart';
import 'package:lpi_app/utils/colors.dart';

class MemberTabs extends StatefulWidget {
  static const String id = 'listtabview_screen';
  @override
  _MemberTabsState createState() => _MemberTabsState();
}

class _MemberTabsState extends State<MemberTabs> {
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
              Container(
                height: 40,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                decoration: new BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: new TabBar(
                  unselectedLabelColor: AppColors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppColors.white,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.primaryColor,
                  ),
                  labelStyle:
                      TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500),
                  tabs: [
                    new Tab(text: "ALL"),
                    new Tab(text: "ACTIVE"),
                    new Tab(text: "SUBSCRIBED"),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    color: Colors.black.withOpacity(0.8),
                    child: TabBarView(children: [
                      AllMembers(),
                      ActiveMembers(),
                      InActiveMembers(),
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
