import 'dart:convert';

import 'package:http/http.dart' as http;

Future<bool> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('https://reqres.in/api/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    // Successful login
    return true;
  } else {
    // Failed login
    return false;
  }
}

class User {
  final String email;
  final String password;

  User({required this.email, required this.password});
}
