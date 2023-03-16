import 'package:RedBank/constant/dimensions.dart';
import 'package:RedBank/constant/colors.dart';
import 'package:RedBank/view/widgets/transactionCard.dart';
import 'package:RedBank/view/widgets/appBar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:flutter/material.dart';
import 'package:RedBank/services/sqlConnection.dart';

String theBalance = '';
var result;
final transactions = List<Widget>.empty(growable: true);

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({Key? key}) : super(key: key);

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    SqlConnection con = SqlConnection();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //getting balance value
    String LoggedInUser = await prefs.getString("username").toString();
    var balanceResult = await con.readQuery(
        "SELECT balance FROM usersTbl WHERE username = '$LoggedInUser'");
    theBalance = balanceResult[0]['balance'].toString();

    //getting transactions
    result = null;
    result = await con.readQuery(
        "SELECT amount,date FROM transactionTbl WHERE username = '$LoggedInUser'");
    setState(() {
      transactions.clear();
      for (int i = 0; i < result.length; i++) {
        transactions.add(TransactionCard(
            title: "خرید اینترنتی",
            datetime: result[i]["date"].toString(),
            fee: result[i]["amount"].toString(),
            greyicon: Icons.shop_2));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        foregroundcolor: Colors.white,
        text: "صورت حساب",
        backgroundColor: MyColors.primaryColor,
      ),
      body: Stack(
        children: [
          SlidingSheet(
            elevation: 16,
            cornerRadius: 16,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [1.0, 0.65],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            headerBuilder: (context, state) {
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                height: 50,
                width: double.infinity,
                child: Text(
                  "تراکنش های اخیر",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              );
            },
            body: Container(
              height: MyDimensions.height(context),
              width: MyDimensions.width(context),
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '$theBalance ریال ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      "موجودی",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.resolveWith<Size?>(
                          (states) {
                            return Size(MyDimensions.width(context) / 1.5,
                                MyDimensions.height(context) / 15);
                          },
                        ),
                        elevation: MaterialStateProperty.resolveWith<double?>(
                          (states) {
                            return 16;
                          },
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (states) {
                            return MyColors.primaryColorMate;
                          },
                        ),
                      ),
                      onPressed: () async {
                        // TODO: do something
                      },
                      icon: Icon(Icons.add),
                      label: Text("افزایش موجودی"),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            builder: (context, state) {
              return Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: transactions,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
