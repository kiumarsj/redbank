import 'package:RedBank/constant/colors.dart';
import 'package:RedBank/constant/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:RedBank/services/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StrangerLogin extends StatefulWidget {
  const StrangerLogin({Key? key}) : super(key: key);

  @override
  State<StrangerLogin> createState() => _StrangerLoginState();
}

class _StrangerLoginState extends State<StrangerLogin> {
  bool _isObscure = true;
  String usernameValue = '';
  String passValue = '';

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
                child: TextField(
                  onChanged: (value) {
                    usernameValue = value;
                  },
                  decoration: new InputDecoration(
                    filled: true,
                    hintText: 'نام کاربری',
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
                      if (usernameValue != '' && passValue != '') {
                        Authenticate auth = Authenticate(
                            username: usernameValue, password: passValue);
                        bool result = await auth.authenticator();
                        if (result == true) {
                          prefs.setString("username", usernameValue);
                          prefs.setBool("isLoggedIn", true);
                          Navigator.pushNamed(context, '/main');
                        }
                      } else {
                        print('fileds are empty');
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
                    'Made by @kiumarsj',
                    style: TextStyle(
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
