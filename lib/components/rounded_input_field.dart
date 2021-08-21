import 'package:flutter/material.dart';
import 'package:lpi_app/utils/colors.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final bool isLightTheme;
  final bool isPassword;

  const RoundedInputField(
      {Key key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.isLightTheme = true,
      this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: isLightTheme ? AppColors.white : AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        onChanged: onChanged,
        cursorColor: AppColors.primaryColor,
        style: TextStyle(color: AppColors.black),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: AppColors.primaryColor,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
              color: isLightTheme ? AppColors.black : AppColors.white),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
