import 'package:RedBank/view/screens/HomeScreen.dart';
import 'package:RedBank/view/screens/transferScreen.dart';
import 'package:RedBank/view/screens/cardScreen.dart';
import 'package:RedBank/view/screens/profileScreen.dart';
import 'package:RedBank/view/screens/balanceScreen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    BalanceScreen(),
    TransferScreen(),
    HomeScreen(),
    CardScreen(),
    ProfileScreen(),
  ];

//onTab action for bottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // appBar: AppBar(title: Text("BluBank")),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/img/Time-Circle.png")),
              label: "",
              tooltip: "transaction",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/img/Swap.png")),
              label: "",
              tooltip: "add transaction",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/img/Home.png")),
              label: "",
              tooltip: "home",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/img/Wallet.png")),
              label: "",
              tooltip: "wallet",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/img/Profile.png")),
              tooltip: "profile",
              label: "",
            ),
          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}
