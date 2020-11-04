import 'package:flutter/material.dart';
import 'package:lpi_app/constants.dart';
import '../screens/UserRegistration/components/uploader.dart';

class DualRadioButton extends StatefulWidget {
  final String title;
  final int selectedValue;
  final String option1;
  final String option2;
  final Function onChanged;
  String radioValue;

  DualRadioButton(
      {Key key,
      this.title,
      this.option1,
      this.option2,
      this.onChanged,
      this.selectedValue})
      : super(key: key);

  @override
  _DualRadioButtonState createState() => _DualRadioButtonState();
}

class _DualRadioButtonState extends State<DualRadioButton> {
  int selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = -1;
  }

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Card(
        color: kPrimaryLightColor,
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 5, top: 10),
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  hoverColor: Colors.white,
                  value: 0,
                  activeColor: kPrimaryColor,
                  groupValue: widget.selectedValue,
                  onChanged: widget.onChanged,
                ),
                Text(
                  widget.option1,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 50,
                ),
                Radio(
                  value: 1,
                  activeColor: kPrimaryColor,
                  groupValue: widget.selectedValue,
                  onChanged: widget.onChanged,
                ),
                Text(
                  widget.option2,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
