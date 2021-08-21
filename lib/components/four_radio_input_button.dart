import 'package:flutter/material.dart';
import 'package:lpi_app/utils/colors.dart';

class QuadDualRadioButton extends StatefulWidget {
  final String title;
  final int selectedValue2;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String option5;
  final String option6;
  final Function onChanged;
  String radioValue;

  QuadDualRadioButton(
      {Key key,
      this.title,
      this.option1,
      this.option2,
      this.option3,
      this.option4,
      this.option5,
      this.option6,
      this.onChanged,
      this.selectedValue2})
      : super(key: key);

  @override
  _QuadDualRadioButtonState createState() => _QuadDualRadioButtonState();
}

class _QuadDualRadioButtonState extends State<QuadDualRadioButton> {
  int selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = -2;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Card(
      
        color: AppColors.secondaryColor,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Radio(
                      hoverColor: Colors.white,
                      value: 2,
                      activeColor: AppColors.primaryColor,
                      groupValue: widget.selectedValue2,
                      onChanged: widget.onChanged,
                    ),
                    Text(
                  widget.option1,
                  style: TextStyle(color: Colors.white),
                ),
                  ],
                ),
                
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      value: 3,
                      activeColor: AppColors.primaryColor,
                      groupValue: widget.selectedValue2,
                      onChanged: widget.onChanged,
                    ),
                    Text(
                  widget.option2,
                  style: TextStyle(color: Colors.white),
                ),
                  ],
                ),
                
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      value: 4,
                      activeColor: AppColors.primaryColor,
                      groupValue: widget.selectedValue2,
                      onChanged: widget.onChanged,
                    ),
                    Text(
                  widget.option3,
                  style: TextStyle(color: Colors.white),
                ),
                  ],
                ),
                
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      value: 5,
                      activeColor: AppColors.primaryColor,
                      groupValue: widget.selectedValue2,
                      onChanged: widget.onChanged,
                    ),
                    Text(
                  widget.option4,
                  style: TextStyle(color: Colors.white),
                ),
                  ],
                ),
                
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      value: 6,
                      activeColor: AppColors.primaryColor,
                      groupValue: widget.selectedValue2,
                      onChanged: widget.onChanged,
                    ),
                    Text(
                  widget.option5,
                  style: TextStyle(color: Colors.white),
                ),
                  ],
                ),
                
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      value: 7,
                      activeColor: AppColors.primaryColor,
                      groupValue: widget.selectedValue2,
                      onChanged: widget.onChanged,
                    ),
                    Text(
                  widget.option6,
                  style: TextStyle(color: Colors.white),
                ),
                  ],
                ),
                
              ],
            )
          ],
        ),
      ),
    );
  }
}
