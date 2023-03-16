import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:RedBank/services/sqlConnection.dart';

var result = null;

class Authenticate {
  // defining Authenticate class and it's constructor
  Authenticate({required this.username, required this.password});
  final String username;
  final String password;

  Future<bool> authenticator() async {
    // authenticator async function that returns the result of the auth in bool format
    var bytes = utf8.encode(password);
    var cipher = sha256.convert(bytes).toString();
    SqlConnection con = SqlConnection();
    result = null;
    result = await con.readQuery(
        "SELECT password FROM usersTbl WHERE username = '$username'");
    print('------------------------');
    print('Calculated cipher:  $cipher');
    print('------------------------');
    if (cipher == result[0]["password"]) {
      print('Access Granted!');
      return true;
    } else {
      print('No Access!!!');
      return false;
    }
  }
}
