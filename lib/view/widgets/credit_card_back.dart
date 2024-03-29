import 'package:flutter/material.dart';
import 'package:RedBank/constant/colors.dart';

class RedCardBack extends StatelessWidget {
  final String name;
  final String col1;
  final String col2;
  final String col3;
  final String col4;
  final String date;
  final String cvv2;

  const RedCardBack({
    required this.name,
    required this.col1,
    required this.col2,
    required this.col3,
    required this.col4,
    required this.date,
    required this.cvv2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 25, left: 25),
      decoration: BoxDecoration(
        color: MyColors.primaryColorMate,
        borderRadius: BorderRadius.circular(25),
      ),
      width: 250,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Spacer(),
                  Text(name),
                  SizedBox(height: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(col1),
                      Text(col2),
                      Text(col3),
                      Text(col4),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("CVV2"),
                              Text(cvv2),
                            ],
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(":EXp"),
                              Text(date),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.black,
            width: 50,
          ),
        ],
      ),
    );
  }
}
