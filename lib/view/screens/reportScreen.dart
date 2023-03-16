import 'package:flutter/material.dart';
import 'package:RedBank/constant/colors.dart';
import 'package:RedBank/view/widgets/appBar_widget.dart';
import 'package:RedBank/services/sqlConnection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:file_picker/file_picker.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:RedBank/services/pdfMaker.dart';

// var myTheme = ThemeData.withFont(
//   base: Font.ttf(await rootBundle.load("assets/OpenSans-Regular.ttf")),
//   bold: Font.ttf(await rootBundle.load("assets/OpenSans-Bold.ttf")),
//   italic: Font.ttf(await rootBundle.load("assets/OpenSans-Italic.ttf")),
//   boldItalic: Font.ttf(await rootBundle.load("assets/OpenSans-BoldItalic.ttf")),
// );

List<dynamic> result = [];
DataTable myDataTable = _createDataTable();
DataTable _createDataTable() {
  return DataTable(columns: _createColumns(), rows: _createRows());
}

List<DataColumn> _createColumns() {
  return [
    DataColumn(label: Text('تاریخ')),
    DataColumn(label: Text('مبلغ')),
    DataColumn(label: Text('مقصد'))
  ];
}

List<DataRow> _createRows() {
  return result
      .map((record) => DataRow(cells: [
            DataCell(Text(record['date'].toString())),
            DataCell(Text(record['amount'].toString())),
            DataCell(Text(record['destCard'].toString()))
          ]))
      .toList();
}

// screen statefule widget
class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void makePDF() async {
    //final font = await rootBundle.load("assets/fonts/Vazir-Regular.ttf");
    //final ttf = pw.Font.ttf(font);
    final pdf = pw.Document();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String LoggedInUser = await prefs.getString("username").toString();
    String title = "Transactions Report for user: $LoggedInUser";
    try {
      if (Permission.storage.isGranted != true) {
        var status = Permission.storage.request();
        print('---------------- is granted?');
        print(status.isGranted);
        File file = LocalFileSystem().file(await getFilePath());
        var writeResult =
            await file.writeAsBytes(await generateReport(title, result));
        print(writeResult);
      } else {
        File file = LocalFileSystem().file(await getFilePath());
        var writeResult =
            await file.writeAsBytes(await generateReport(title, result));
        print(writeResult);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getFilePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String LoggedInUser = await prefs.getString("username").toString();
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    return '$selectedDirectory/user_${LoggedInUser}_transactions_report.pdf';
  }

  void getData() async {
    SqlConnection con = SqlConnection();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String LoggedInUser = await prefs.getString("username").toString();
    //getting transactions
    result = await con.readQuery(
        "SELECT tt.date,tt.amount,tt.destCard FROM transactionTbl tt WHERE username = '$LoggedInUser'");
    print(result);
    setState(() {
      myDataTable = DataTable(
        columns: _createColumns(),
        rows: _createRows(),
        //dataRowHeight: 40,
        //headingRowHeight: 30,
        columnSpacing: 40.0,
        border: TableBorder.all(
            color: Colors.black,
            width: 1.0,
            borderRadius: BorderRadius.circular(5),
            style: BorderStyle.solid),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primaryColor,
        tooltip: "ذخیره جدول در فایل PDF",
        child: Icon(Icons.save),
        onPressed: () {
          makePDF();
        },
      ),
      appBar: AppBarWidget(
        text: "گزارش تراکنش ها",
      ),
      body: ListView(
        children: [myDataTable],
      ),
    );
  }
}
