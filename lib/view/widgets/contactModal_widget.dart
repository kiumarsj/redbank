import 'package:RedBank/constant/colors.dart';
import 'package:RedBank/constant/dimensions.dart';
import 'package:flutter/material.dart';

class ContactWidget extends StatelessWidget {
  final Color? color;
  final Color? background;

  ContactWidget({this.color, this.background});

  blulist({String title = "", IconData? greyicon}) {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      height: 50,
      child: Row(
        children: [
          Container(
            child: Icon(greyicon, color: Colors.grey),
          ),
          SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Container(
                width: MyDimensions.width(context),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  children: [
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Center(
                            child: Text(
                              "رِدی لاین",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "همیشه به وقت همه جا",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ),
                          Divider(),
                          blulist(
                            title: "گفتگو",
                            greyicon: Icons.question_answer_outlined,
                          ),
                          Divider(),
                          blulist(
                            title: "تماس",
                            greyicon: Icons.call_outlined,
                          ),
                          Divider(),
                          blulist(
                            title: "سوالات متداول",
                            greyicon: Icons.quiz_outlined,
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            "انصراف",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: MyColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: background ?? MyColors.primaryColor,
            shape: BoxShape.circle,
          ),
          width: 25,
          height: 25,
          child: Center(
            child: Text(
              '?',
              style: TextStyle(
                color: color ?? Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
