import 'package:sql_conn/sql_conn.dart';
import 'dart:convert';

class SqlConnection {
  // defining SQL class and its properties
  // these are DB server credentials that are just defined here
  final String server = '192.168.1.2';
  final String port = '1433';
  final String dbName = 'RedBankdb';
  final String user = 'sa';
  final String pass = '1234kj4321@#';

  Future<void> openConnection() async {
    // in this asynchronous functions i open an SQL connection and print the status message
    try {
      await SqlConn.connect(
          ip: server,
          port: port,
          databaseName: dbName,
          username: user,
          password: pass);
      print('***********************');
      print('isConnected?');
      print(SqlConn.isConnected);
      print('***********************');
    } catch (e) {
      print(e.toString());
    }
  }

  Future readQuery(String query) async {
    // in this read query i call the openConnection func and submit my query string and wait for result
    await openConnection();
    var rawResult = await SqlConn.readData(query);
    SqlConn.disconnect();
    // the results are going to be in json format so i decode them for furture uses
    return jsonDecode(rawResult);
  }

  // like the read just with a diffrent command for write
  Future writeQuery(String query) async {
    await openConnection();
    var rawResult = await SqlConn.writeData(query);
    SqlConn.disconnect();
    return jsonDecode(rawResult);
  }
}
