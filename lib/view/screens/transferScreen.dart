import 'package:RedBank/view/widgets/transferCard.dart';
import 'package:RedBank/view/widgets/floatingAction.dart';
import 'package:flutter/material.dart';
import 'package:RedBank/services/sqlConnection.dart';
import 'package:shared_preferences/shared_preferences.dart';

var result;
final transfersList = List<Widget>.empty(growable: true);

class TransferScreen extends StatefulWidget {
  @override
  TransferScreenstate createState() => TransferScreenstate();
}

class TransferScreenstate extends State<TransferScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    SqlConnection con = SqlConnection();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String LoggedInUser = await prefs.getString("username").toString();

    //getting transactions
    result = null;
    result = await con.readQuery(
        "SELECT tt.destCard,ut.name,ut.lastname FROM transactionTbl tt INNER JOIN usersTbl ut ON tt.username = '$LoggedInUser' AND ut.cardNumber = tt.sourceCard");
//    "SELECT tt.destCard,ut.name,ut.lastname FROM transactionTbl tt INNER JOIN usersTbl ut ON ut.username != '$LoggedInUser' AND tt.username = ut.username AND tt.sourceCard != (SELECT cardNumber FROM usersTbl WHERE username = '$LoggedInUser')"
    print(result);
    setState(() {
      transfersList.clear();
      for (int i = 0; i < result.length; i++) {
        transfersList.add(TransferCard(
            name: result[i]["name"] + " " + result[i]["lastname"],
            cardNum: result[i]["destCard"].toString(),
            bankImage: 'assets/img/bankimg1.png'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingBTN(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(shape: BoxShape.circle),
                height: 56,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      size: 15,
                      color: Colors.grey[500],
                    ),
                    Icon(
                      Icons.arrow_downward,
                      size: 15,
                      color: Colors.grey[500],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "انتقال های اخیر",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: transfersList,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
