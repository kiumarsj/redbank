import 'package:flutter/material.dart';

class ServiceCardWidget extends StatelessWidget {
  final Color? cardcolor;
  final IconData cardicon;
  final String title;

  const ServiceCardWidget({
    required this.cardcolor,
    required this.cardicon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: cardcolor,
          ),
          child: Icon(
            cardicon,
            color: Colors.white,
            size: 30,
          ),
        ),
        SizedBox(height: 10),
        Container(
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
          ),
        )
      ],
    );
  }
}
