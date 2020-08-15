import 'package:flutter/material.dart';

class Alert extends StatefulWidget {
  final String error;

  Alert({Key key, this.error}) : super(key: key);

  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Authentication Error"),
          content: new Text(widget.error),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
