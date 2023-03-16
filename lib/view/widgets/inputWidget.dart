import 'dart:ui';
import 'package:RedBank/constant/colors.dart';
import 'package:flutter/material.dart';

class PasswordInputWidget extends StatefulWidget {
  PasswordInputWidget(this.hint);
  final String hint;

  @override
  _PasswordInputWidgetState createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool _isObscure = true;
  String _hint = '';

  @override
  void initState() {
    super.initState();
    setInfo(widget.hint);
  }

  void setInfo(String theHint) {
    setState(() {
      _hint = theHint;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        obscureText: _isObscure,
        decoration: new InputDecoration(
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
          hintText: _hint,
          hintStyle: TextStyle(
            fontSize: 14,
            color: MyColors.textgray,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          contentPadding: EdgeInsets.only(right: 10, top: 13, bottom: 13),
          fillColor: Color(0xfff3f4f6),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Color(0xfff3f4f6),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}

class TextInputWidget extends StatefulWidget {
  TextInputWidget(this.hint);
  final String hint;

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  String _hint = '';

  @override
  void initState() {
    super.initState();
    setInfo(widget.hint);
  }

  void setInfo(String theHint) {
    setState(() {
      _hint = theHint;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        decoration: new InputDecoration(
          filled: true,
          hintText: _hint,
          hintStyle: TextStyle(
            fontSize: 14,
            color: MyColors.textgray,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          contentPadding: EdgeInsets.only(right: 10, top: 13, bottom: 13),
          fillColor: Color(0xfff3f4f6),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Color(0xfff3f4f6),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
