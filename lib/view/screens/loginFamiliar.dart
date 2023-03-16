import 'package:flutter/material.dart';
import 'package:RedBank/constant/colors.dart';
import 'package:RedBank/constant/dimensions.dart';
import 'package:RedBank/services/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

String nameofUser = '';

class FamiliarLogin extends StatefulWidget {
  const FamiliarLogin({Key? key}) : super(key: key);

  @override
  State<FamiliarLogin> createState() => _FamiliarLoginState();
}

class _FamiliarLoginState extends State<FamiliarLogin> {
  bool _isObscure = true;
  String passValue = '';

  @override
  void initState() {
    getLoggedInUserName();
    super.initState();
  }

  void getLoggedInUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameofUser = prefs.getString("username") ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 30, bottom: 70),
                child: Image.asset(
                  'assets/img/redLogo.png',
                  width: MyDimensions.width(context) / 2.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: Center(
                  child: Text(
                    nameofUser,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: TextField(
                  onChanged: (value) {
                    passValue = value;
                  },
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
                    hintText: 'رمز عبور',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: MyColors.textgray,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.only(right: 10, top: 13, bottom: 13),
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
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  child: Text(
                    'ورود',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    try {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String loggedInUserName =
                          prefs.getString("username") ?? '';
                      if (passValue != '') {
                        Authenticate auth = Authenticate(
                            username: loggedInUserName, password: passValue);
                        bool result = await auth.authenticator();
                        if (result == true) {
                          prefs.setBool("isLoggedIn", true);
                          Navigator.pushNamed(context, '/main');
                        }
                      } else {
                        print('Password field is empty');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
              SizedBox(
                height: MyDimensions.height(context) * 0.2,
              ),
              InkWell(
                child: Center(
                  child: Text(
                    'خروج از حساب کاربری',
                    style: TextStyle(
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.remove("username");
                  prefs.setBool("isLoggedIn", false);
                  Navigator.pushNamed(context, '/loginStranger');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
