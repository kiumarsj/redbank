import 'package:RedBank/constant/colors.dart';
import 'package:RedBank/constant/dimensions.dart';
import 'package:RedBank/view/widgets/appBar_widget.dart';
import 'package:RedBank/view/widgets/cardSwitch_widget.dart';
import 'package:RedBank/view/widgets/card_profileScreen_widget.dart';
import 'package:flutter/material.dart';
import 'package:RedBank/services/sqlConnection.dart';
import 'package:shared_preferences/shared_preferences.dart';

String LoggedInUser = '';
String nameLastname = '';
var result;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

header(BuildContext context, {String title = ''}) {
  return Container(
    width: MyDimensions.width(context),
    child: Text(
      title,
      style: TextStyle(fontSize: 24),
    ),
  );
}

profile({
  String name = '',
  String id = '',
  String profilepic = '',
}) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(75),
          color: Colors.black,
          // image: DecorationImage(
          //   image: AssetImage(profilepic),
          // ),
        ),
        width: 75,
        height: 75,
      ),
      SizedBox(height: 5),
      Text(name),
      SizedBox(height: 5),
      Row(
        children: [
          Spacer(),
          Text(
            id,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          Text(
            "@",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          Spacer(),
        ],
      )
    ],
  );
}

bubbles({
  Color? bubblecolor,
  int? width,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: bubblecolor,
    ),
    height: 20,
    width: 20,
  );
}

greytext({String text = ''}) {
  return Text(
    text,
    style: TextStyle(color: Colors.grey),
  );
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    SqlConnection con = SqlConnection();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoggedInUser = await prefs.getString("username").toString();

    //getting transactions
    result = null;
    result = await con.readQuery(
        "SELECT name,lastname FROM usersTbl WHERE username = '$LoggedInUser'");
    setState(() {
      nameLastname = result[0]["name"] + " " + result[0]["lastname"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: "تنظیمات"),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
        color: Colors.white,
        width: MyDimensions.width(context),
        height: MyDimensions.height(context),
        child: ListView(
          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
          children: [
            Column(
              children: [
                //--------------- profile ---------------\\
                Container(
                  alignment: Alignment.topCenter,
                  width: MyDimensions.width(context),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: 75,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Container(
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.amber,
                                        ),
                                        height: 15,
                                        width: 15,
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 50),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: MyColors.primaryColor,
                                        ),
                                        height: 10,
                                        width: 10,
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.pink[100],
                                        ),
                                        height: 5,
                                        width: 5,
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: profile(
                            name: nameLastname,
                            id: LoggedInUser,
                            //  profilepic: '',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 75,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 50),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.green,
                                        ),
                                        height: 10,
                                        width: 10,
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 25),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: MyColors.primaryColor,
                                        ),
                                        height: 5,
                                        width: 5,
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                //--------------- informatin ---------------\\
                header(context, title: "اطلاعات"),
                SizedBox(height: 20),
                Cartprofilescreenwidget(
                  whiteicon: Icons.account_balance_rounded,
                  title: "حساب بانکی",
                ),
                SizedBox(height: 10),
                Cartprofilescreenwidget(
                  whiteicon: Icons.sim_card_rounded,
                  title: "تغییر شماره تلفن همراه",
                ),
                SizedBox(height: 10),
                Cartprofilescreenwidget(
                  whiteicon: Icons.place_rounded,
                  title: "تغییر آدرس سکونت",
                ),
                SizedBox(height: 20),

                //--------------- security ---------------\\
                header(context, title: "امنیت"),
                SizedBox(height: 20),
                CardSwitchWidget(
                  title: "ورود با تشخیص چهره",
                  greyicon: Icons.face_unlock_outlined,
                ),
                SizedBox(height: 10),
                Cartprofilescreenwidget(
                  whiteicon: Icons.vpn_key_rounded,
                  title: "تغییر رمز عبور",
                ),
                SizedBox(height: 10),
                Cartprofilescreenwidget(
                  whiteicon: Icons.smartphone_outlined,
                  title: "دستگاه های من",
                ),
                SizedBox(height: 20),

                //--------------- notification ---------------\\
                header(context, title: "اطلاع رسانی"),

                SizedBox(height: 20),
                Cartprofilescreenwidget(
                  whiteicon: Icons.notifications_rounded,
                  title: "تنظیمات اطلاع رسانی",
                ),
                SizedBox(height: 20),

                //--------------- public ---------------\\
                header(context, title: "عمومی"),
                SizedBox(height: 20),
                Cartprofilescreenwidget(
                  whiteicon: Icons.people_rounded,
                  title: "دعوت از دوستان",
                ),
                SizedBox(height: 10),
                Cartprofilescreenwidget(
                  whiteicon: Icons.description_rounded,
                  title: "قوانین و شرایط",
                ),
                SizedBox(height: 10),
                Cartprofilescreenwidget(
                  whiteicon: Icons.insert_emoticon_rounded,
                  title: "درباره ما",
                ),
                SizedBox(height: 10),
                Cartprofilescreenwidget(
                  whiteicon: Icons.exit_to_app_rounded,
                  title: "خروج از حساب کاربری",
                ),
                SizedBox(height: 20),

                //--------------- version ---------------\\
                Column(
                  children: [
                    greytext(text: "Version 1.0.0"),
                    Container(
                      color: Colors.amber,
                      width: MyDimensions.width(context),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
