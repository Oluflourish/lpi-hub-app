import 'package:flutter/material.dart';
import 'package:lpi_app/components/text_field_container.dart';

import '../constants.dart';

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

  String _password;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: _obscureText,
        style: TextStyle(color: Colors.white),
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.white),
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: (_obscureText = true)
              ? InkResponse(
                  onTap: _toggle,
                  child: Icon(
                    Icons.visibility,
                    color: kPrimaryColor,
                  ))
              : InkResponse(
                  onTap: _toggle,
                  child: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
