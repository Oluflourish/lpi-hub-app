import 'package:flutter/material.dart';
import 'package:lpi_app/utils/colors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = AppColors.primaryColor,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20.0)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontSize: 16.0, fontWeight: FontWeight.bold, letterSpacing: 1.0),
          ),
        ),
      ),
    );
  }
}
