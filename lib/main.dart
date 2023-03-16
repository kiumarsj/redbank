import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:RedBank/view/screens/HomeScreen.dart';
import 'package:RedBank/view/screens/mainScreen.dart';
import 'package:RedBank/view/screens/reportScreen.dart';
import 'package:RedBank/view/screens/transferScreen.dart';
import 'constant/colors.dart';
import 'package:RedBank/view/screens/balanceScreen.dart';
import 'package:RedBank/view/screens/loginStranger.dart';
import 'package:RedBank/view/screens/loginFamiliar.dart';
import 'package:RedBank/view/screens/cardScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// defining routes widget
Widget theRoute = StrangerLogin();

Future<void> main() async {
  //checking if user has bees signedIn before or not
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isLoggedIn') ?? false;
  print('------------------');
  print('isLoggedIn:  $status');
  print('------------------');
  theRoute = (status == true
      ? FamiliarLogin()
      : StrangerLogin()); // and decide to navigate it to correct page
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // in MyApp class we build a material app and return it ro runApp()
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        //here we define our app's routes
        '/main': (context) => MainScreen(),
        '/loginStranger': (context) => StrangerLogin(),
        '/loginFmiliar': (context) => FamiliarLogin(),
        '/balanceScreen': (context) => BalanceScreen(),
        '/TransactionScreen': (context) => TransferScreen(),
        '/homeScreen': (context) => HomeScreen(),
        '/cardScreen': (context) => CardScreen(),
        '/reportScreen': (context) => ReportScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'BluBank',
      theme: ThemeData(
        // here we define app's theme and Locale
        fontFamily: "Vazir",
        primaryColor: MyColors.primaryColor,
      ),
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"),
      ],
      locale: Locale("fa", "IR"),
      home: theRoute,
    );
  }
}
