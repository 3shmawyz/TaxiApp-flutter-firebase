import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Function onClick;

  const CustomTextField({@required this.hint,@required this.onClick});

  

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hint =="Password" ? true : false,
      onSaved: onClick,
      decoration: InputDecoration(
          labelText:hint,
          labelStyle: TextStyle(fontSize: 14),
          hintStyle:
              TextStyle(color: Colors.grey, fontSize: 10)),
      style: TextStyle(fontSize: 14),
    );
  }
}