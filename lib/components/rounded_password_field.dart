import 'package:flutter/material.dart';
import 'package:lpi_app/utils/colors.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        obscureText: _obscureText,
        style: TextStyle(color: AppColors.black),
        onChanged: widget.onChanged,
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(color: AppColors.black),
          icon: Icon(
            Icons.lock,
            color: AppColors.primaryColor,
          ),
          suffixIcon: (_obscureText == true)
              ? InkResponse(
                  onTap: _toggle,
                  child: Icon(
                    Icons.visibility,
                    color: AppColors.primaryColor,
                  ))
              : InkResponse(
                  onTap: _toggle,
                  child: Icon(
                    Icons.lock,
                    color: AppColors.primaryColor,
                  ),
                ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
