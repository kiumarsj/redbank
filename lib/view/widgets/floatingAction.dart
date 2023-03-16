import 'package:RedBank/constant/colors.dart';
import 'package:flutter/material.dart';

class FloatingBTN extends StatefulWidget {
  const FloatingBTN({Key? key}) : super(key: key);

  @override
  _FloatingBTNState createState() => _FloatingBTNState();
}

class _FloatingBTNState extends State<FloatingBTN> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: MyColors.primaryColor,
      foregroundColor: Colors.white,
      onPressed: () {
        // Respond to button press
      },
      icon: Icon(
        Icons.add,
        size: 30,
      ),
      label: Text(
        'انتقال جدید',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
