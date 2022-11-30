import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';

import "package:http/http.dart" as http;

class LoginController {
  static const String url = "http://10.0.0.193:3000/";
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<bool> login(String email, String password) async {
    http.Response response = await http.post(
      Uri.parse("${url}login"),
      //headers: {"Content-type": "application/json"},
      body: {
        "email": email,
        "password": password,
      },
    );

    var result = json.decode(response.body);
    
    print("CORPO DA RESPOSTA: $result");
    logger.e(result);
    if (response.statusCode != 200) {
      switch (result) {
        case "Cannot find user":
          throw UserNotFindException();
        case "Incorrect password":
          throw IncorrecPasswordException();
      }
      throw HttpException(response.body);
    }
    return true;
  }
}

class UserNotFindException implements Exception {}
class IncorrecPasswordException implements Exception {}
