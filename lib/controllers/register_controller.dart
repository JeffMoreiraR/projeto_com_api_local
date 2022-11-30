import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:login_api/users/user.dart';

class RegisterController {
  static const String url = "http://10.0.0.193:3000/";
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<bool> register(User user) async {
    String userJson = json.encode(user.toJson());

    print("JSON GERADO: $userJson");
    http.Response response = await http.post(
      Uri.parse("${url}register"),
      headers: {"Content-type": "application/json"},
      body: userJson,
    );

    logger.e("CABECALHO: ${response.headers}");
    logger.v("CORPO: ${response.body}");
    logger.w("CODIGO: ${response.statusCode}");
    var result = json.decode(response.body);
    print("ESSE AQUI EH O RESULT -> $result");
    if (response.statusCode != 201) {
      switch (result) {
        case "Email already exists":
          throw EmailAlreadyExistsException();
      }
      throw HttpException(response.body);
    }
    return true;
  }
}

class EmailAlreadyExistsException implements Exception {}
