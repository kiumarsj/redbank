import 'package:RedBank/constant/colors.dart';
import 'package:flutter/material.dart';

class RedCardFront extends StatelessWidget {
  const RedCardFront({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: MyColors.primaryColorMate,
        borderRadius: BorderRadius.circular(25),
      ),
      width: 250,
      child: Column(
        children: [
          Spacer(),
          Container(
            width: 75,
            height: 75,
            child: Icon(
              Icons.flutter_dash_rounded,
              size: 75,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'bank, but lovely',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Spacer(),
          Icon(
            Icons.flip_rounded,
            size: 24,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
