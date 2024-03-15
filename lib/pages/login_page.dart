// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hackerkernel_assignment/pages/home_page.dart';
import 'package:hackerkernel_assignment/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/loginscreen.png"),
              const SizedBox(height: 35),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: 'Email ID',
                    prefixIcon: Icon(
                      Icons.alternate_email_rounded,
                    )),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    suffixIcon: Icon(
                      Icons.visibility_off,
                    )),
              ),
              const SizedBox(height: 70),
              ElevatedButton(
                onPressed: () async {
                  var pref = await SharedPreferences.getInstance();
                  pref.setString("email", emailController.text);
                  pref.setString("password", passwordController.text);
                  final email = emailController.text;
                  final password = passwordController.text;

                  if (email.isNotEmpty && password.isNotEmpty) {
                    final success = await loginUser(email, password);
                    if (success) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    } else {
                      //login error
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Login Failed'),
                            content: const Text('Invalid email or password.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                    minimumSize: MaterialStatePropertyAll(
                      Size(
                        double.infinity,
                        60,
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 6, 124, 221),
                    )),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getValue() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.getString("email");
    prefs.getString("password");
    setState(() {});
  }
}
