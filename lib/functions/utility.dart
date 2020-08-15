import 'package:flutter/material.dart';

class Utility{

  static Utility utility = null;

  static Utility getInstance(){
    if(utility == null){
      utility = Utility();
    }
    return utility;
  }

  showAlertDialog(BuildContext context, String alertTitle, String alertMessage){
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel", style: TextStyle(color: Colors.black),),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
   

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(alertTitle),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(alertMessage)
          ],
        ),
      ),
      actions: [
        cancelButton,
        
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }

}