import 'package:RedBank/constant/dimensions.dart';
import 'package:RedBank/view/widgets/appBar_widget.dart';
import 'package:RedBank/view/widgets/credit_card_back.dart';
import 'package:RedBank/view/widgets/credit_card_front.dart';
import 'package:RedBank/view/widgets/cardScreenWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:RedBank/services/sqlConnection.dart';
import 'package:shared_preferences/shared_preferences.dart';

var result;
String name = '', number = '', date = '', cvv2 = '';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    SqlConnection con = SqlConnection();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String LoggedInUser = await prefs.getString("username").toString();

    //getting card info
    result = null;
    result = await con.readQuery(
        "SELECT name,lastname,cardNumber,cardExpDate,cardCvv2 FROM usersTbl WHERE username = '$LoggedInUser'");
    setState(() {
      name =
          result[0]["name"].toString() + " " + result[0]["lastname"].toString();
      number = result[0]["cardNumber"].toString();
      date = result[0]["cardExpDate"].toString();
      cvv2 = result[0]["cardCvv2"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // all of the useful part of the screen is a scaffold and keeps all widgets in its core.
      appBar: AppBarWidget(text: "کارت"), // just and app bar for the top
      body: Container(
        width: MyDimensions.width(context),
        height: MyDimensions.height(context),
        color: Colors.white,
        padding: EdgeInsets.only(top: 25),
        child: Stack(
          // a container for keeping our stack of widgets
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 25, left: 25),
                    child: FlipCard(
                      fill: Fill.fillBack,
                      direction: FlipDirection.HORIZONTAL,
                      front:
                          RedCardFront(), // self defines widgets for front and back of the flipping card
                      back: RedCardBack(
                          name: name,
                          col1: number,
                          col2: "",
                          col3: "",
                          col4: "",
                          date: date,
                          cvv2: cvv2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: MyDimensions.height(context) / 3,
                ),
              ],
            ),
            CardScreenWidgets(),
          ],
        ),
      ),
    );
  }
}
