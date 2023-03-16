import 'package:RedBank/constant/colors.dart';
import 'package:RedBank/constant/dimensions.dart';
import 'package:RedBank/view/widgets/serviceCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MyDimensions.width(context),
            height: MyDimensions.height(context),
            color: MyColors.primaryColor,
            child: Container(
              height: MyDimensions.height(context) / 4,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Icon(
                    Icons.qr_code_rounded,
                    size: 65,
                    color: Colors.white,
                  ),
                  Text(
                    'پرداخت سریع',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 30,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ],
              ),
            ),
          ),
          SlidingSheet(
            elevation: 5,
            cornerRadius: 15,
            // scrollSpec: const ScrollSpec(overscroll: false),
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.2, 0.7, 0.9],
              positioning: SnapPositioning.relativeToAvailableSpace,
              initialSnap: 0.7,
            ),
            builder: (context, state) {
              return Container(
                height: MyDimensions.height(context) - 60,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.only(right: 20),
                        width: MyDimensions.width(context),
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'با رِدی هزینشو بده!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'پرداخت با QR در کارتخوان های سراسر کشور',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 40),
                            Icon(
                              Icons.mobile_friendly,
                              color: Colors.white,
                              size: 55,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Text(
                            'خدمات پرداخت',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 0.6,
                        crossAxisCount: 4,
                        // padding: EdgeInsets.all(10),
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        children: [
                          ServiceCardWidget(
                            cardcolor: Color(0xff7c70bc),
                            cardicon: Icons.checklist,
                            title: 'شارژ',
                          ),
                          ServiceCardWidget(
                            cardcolor: Color(0xff4f91e4),
                            cardicon: Icons.network_wifi,
                            title: 'اینترنت',
                          ),
                          ServiceCardWidget(
                            cardcolor: Color(0xff74a9ea),
                            cardicon: Icons.checklist_outlined,
                            title: 'قبض',
                          ),
                          ServiceCardWidget(
                            cardcolor: Colors.red,
                            cardicon: Icons.airplane_ticket,
                            title: "بلیت",
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.green,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    print('heyyyy');
                                    Navigator.pushNamed(
                                        context, '/reportScreen');
                                  },
                                  child: Icon(
                                    Icons.download,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                child: Center(
                                  child: Text(
                                    "گزارش",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
